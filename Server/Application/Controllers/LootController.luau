---@class ServerLootController
local LootController = {}
LootController.__index = LootController

---@param diContainer DIContainer
---@return ServerLootController
function LootController.new(diContainer)
	local self = setmetatable({}, LootController)
	self.diContainer = diContainer
	return self
end

function LootController:init()
    ---@type ServerApp
    local application = self.diContainer:resolve("Application")
    self.lootService = application.services.lootService
end

function LootController:update()
    
end

function LootController:onLootDestroyed(loot)
    
end

return LootController