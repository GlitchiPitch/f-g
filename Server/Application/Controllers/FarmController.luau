---@class ServerFarmController
---@field diContainer DIContainer
---@field farmService ServerFarmService
---@field foodSpawnRate number
---@field foodSpawnTimer number
local FarmController = {}
FarmController.__index = FarmController

---@param diContainer DIContainer
---@return ServerFarmController
function FarmController.new(diContainer)
	local self = setmetatable({}, FarmController)
	self.diContainer = diContainer
	self.foodSpawnRate = 2
	self.foodSpawnTimer = 0

	return self
end

function FarmController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
end

---@param deltaTime number
function FarmController:update(deltaTime)
	self.foodSpawnTimer += deltaTime
	if self.foodSpawnTimer >= self.foodSpawnRate then
		self.foodSpawnTimer = 0
		self.eventBus:fire(self.constants.EVENTS.FARM_SPAWN_FOOD)
	end
end

return FarmController
