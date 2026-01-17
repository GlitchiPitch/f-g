---@class ClientFarmService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants Constants
local FarmService = {}
FarmService.__index = FarmService

---@param diContainer DIContainer
---@return ClientFarmService
function FarmService.new(diContainer)
	local self = setmetatable({}, FarmService)
	self.diContainer = diContainer
	return self
end

function FarmService:init()
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    self.eventBus = shared.eventBus
    self.constants = shared.constants
end

function FarmService:onFoodSpawned(eventData)
    self.eventBus:fire(self.constants.REMOTE_EVENTS.FOOD_SPAWNED, eventData)
end

function FarmService:onFoodEaten(eventData)
    self.eventBus:fire(self.constants.REMOTE_EVENTS.FOOD_EATEN, eventData)
end

return FarmService