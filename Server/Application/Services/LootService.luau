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