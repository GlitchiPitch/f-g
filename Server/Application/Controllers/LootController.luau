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
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    self.eventBus = shared.infrastructure.eventBus
    self.constants = shared.constants

    -- Listen for loot destroyed events from LootService
    self.eventBus:connect(self.constants.EVENTS.LOOT_DESTROYED, function(loot)
        self:onLootDestroyed(loot)
    end)
end

function LootController:update()
    
end

function LootController:onLootDestroyed(loot)
    
end

return LootController