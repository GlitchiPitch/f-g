local RunService = game:GetService("RunService")
local CameraController = require(script.CameraController)
local SprintController = require(script.SprintController)
local TargetController = require(script.TargetController)
---@class ClientControllers
---@field diContainer DIContainer
---@field cameraController CameraController
---@field sprintController SprintController
---@field targetController TargetController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ClientControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.diContainer = diContainer
	self.cameraController = CameraController.new(self.diContainer)
	self.sprintController = SprintController.new(self.diContainer)
	self.targetController = TargetController.new(self.diContainer)
	return self
end

function Controllers:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.playerService = application.services.playerService

	self.cameraController:init()
	self.sprintController:init()
	self.targetController:init()

	local function onRender(_)
		if self.playerService:isAlive() then
			self.targetController:update()
			self.cameraController:update()
			-- self.sprintController:update()
		end
	end

	RunService.RenderStepped:Connect(onRender)
end

return Controllers
