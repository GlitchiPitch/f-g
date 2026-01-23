---@class ServerFarmService
---@field diContainer DIContainer
---@field foodZone Part
---@field remoteEventService RemoteEventService
---@field foodAsset Model
---@field constants Constants
local FarmService = {}
FarmService.__index = FarmService

---@param diContainer DIContainer
---@return ServerFarmService
function FarmService.new(diContainer)
	local self = setmetatable({}, FarmService)
	self.diContainer = diContainer
	self.foodCount = 0
	self.foodCountLimit = 10
	return self
end

function FarmService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.eventBus = shared.infrastructure.eventBus
	self.foodZone = workspace.Worlds.MainWorld.FeedSpawn
	self.foodAsset = shared.assets.Seed

	-- Listen for spawn food requests from FarmController
	self.eventBus:connect(self.constants.EVENTS.FARM_SPAWN_FOOD, function()
		self:spawnFood()
	end)

	-- Listen for food consumption requests from ActionService
	self.eventBus:connect(self.constants.EVENTS.FOOD_EATEN, function(data)
		self:eatFood(data.playerEntity, data.food)
	end)
end

function FarmService:spawnFood()
	if self.foodCount < self.foodCountLimit then
		local food = self.foodAsset:Clone()
		food.Parent = self.foodZone
		food:PivotTo(CFrame.new(self:_getRandomPosition()))
		self.foodCount += 1
		self:_notifyFoodSpawned()
	end
end

function FarmService:_notifyFoodSpawned()
	self.remoteEventService:fireAllClients({
		eventName = self.constants.REMOTE_EVENTS.FOOD_SPAWNED,
		data = {
			message = "Food spawned",
		},
	})
end

function FarmService:eatFood(playerEntity, food)
	food:Destroy()
	self.foodCount -= 1
	self:_notifyFoodEaten(playerEntity)
end

function FarmService:_notifyFoodEaten(playerEntity)
	self.remoteEventService:fireClient(playerEntity.player, {
		eventName = self.constants.REMOTE_EVENTS.FOOD_EATEN,
		data = {},
	})
end

---@return Vector3
function FarmService:_getRandomPosition()
	local minX = self.foodZone.Position.X - self.foodZone.Size.X / 2
	local maxX = self.foodZone.Position.X + self.foodZone.Size.X / 2
	local minZ = self.foodZone.Position.Z - self.foodZone.Size.Z / 2
	local maxZ = self.foodZone.Position.Z + self.foodZone.Size.Z / 2
	local randomX = math.random(minX, maxX)
	local randomZ = math.random(minZ, maxZ)
	return Vector3.new(randomX, self.foodZone.Position.Y, randomZ)
end

return FarmService
