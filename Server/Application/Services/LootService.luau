---@class ServerLootService
local LootService = {}
LootService.__index = LootService

---@param diContainer DIContainer
---@return ServerLootService
function LootService.new(diContainer)
	local self = setmetatable({}, LootService)
	self.diContainer = diContainer
	self._lootCahce = {}
	return self
end

function LootService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.infrastructure.eventBus
	self.constants = shared.constants
	self:_setupLootPoints()
end

function LootService:_setupLootPoints()
	local lootFolder = workspace.Worlds.MainWorld.Loot
	---@param loot Model
	for _, loot in lootFolder:GetChildren() do
		self._lootCahce[loot.Name] = loot:Clone()
		loot.Destroying:Connect(function()
			self.eventBus:fire("lootDestroyed", loot)
		end)
	end
end

return LootService
