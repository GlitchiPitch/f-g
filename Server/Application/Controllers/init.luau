local RunService = game:GetService("RunService")
local HuntingController = require(script.HuntingController)
local FarmController = require(script.FarmController)
local DayNightController = require(script.DayNightController)
local EnemyController = require(script.EnemyController)
---@class ServerControllers
---@field diContainer DIContainer
---@field huntingController ServerHuntingController
---@field farmController ServerFarmController
---@field dayNightController DayNightController
---@field enemyController ServerEnemyController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ServerControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.diContainer = diContainer
	self.huntingController = HuntingController.new(self.diContainer)
	self.farmController = FarmController.new(self.diContainer)
	self.dayNightController = DayNightController.new(self.diContainer)
	self.enemyController = EnemyController.new(self.diContainer)
	return self
end

function Controllers:init()
	self.huntingController:init()
	self.farmController:init()
	self.dayNightController:init()
	self.enemyController:init()

	local function onRender(deltaTime)
		self.huntingController:update(deltaTime)
		self.farmController:update(deltaTime)
		self.dayNightController:update()
		self.enemyController:update(deltaTime)
	end

	RunService.Heartbeat:Connect(onRender)
end

return Controllers
