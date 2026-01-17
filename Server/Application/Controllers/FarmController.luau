---@class ServerFarmController
---@field farmService ServerFarmService

local FarmController = {}
FarmController.__index = FarmController

---@param diContainer DIContainer
---@return ServerFarmController
function FarmController.new(diContainer)
	local self = setmetatable({}, FarmController)
	self.diContainer = diContainer
	self.foodSpawnRate = 10
	self.foodSpawnTimer = 0
	
	return self
end

function FarmController:init()
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	self.farmService = application.services.farmService
end

---@param deltaTime number
function FarmController:update(deltaTime)
	self.foodSpawnTimer += deltaTime
	if self.foodSpawnTimer >= self.foodSpawnRate then
		self.foodSpawnTimer = 0
		self.farmService:spawnFood()
		
	end
end

return FarmController
