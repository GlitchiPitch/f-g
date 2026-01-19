local CameraController = require(script.CameraController)
local SprintController = require(script.SprintController)

---@class ClientControllers
---@field diContainer DIContainer
---@field cameraController CameraController
---@field sprintController SprintController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ClientControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.diContainer = diContainer
    self.cameraController = CameraController.new(self.diContainer)
    self.sprintController = SprintController.new(self.diContainer)
	return self
end

function Controllers:init()
    self.cameraController:init()
    self.sprintController:init()
end

return Controllers