local RunService = game:GetService("RunService")
local HuntingController = require(script.HuntingController)
---@class ServerControllers
---@field diContainer DIContainer
---@field huntingController ServerHuntingController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ServerControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.diContainer = diContainer
	self.huntingController = HuntingController.new(self.diContainer)
	return self
end

function Controllers:init()
	self.huntingController:init()

	local function onRender(deltaTime)
		self.huntingController:update(deltaTime)
	end

	RunService.Heartbeat:Connect(onRender)
end

return Controllers
