local CameraController = require(script.CameraController)

---@class ClientControllers
---@field diContainer DIContainer
---@field cameraController CameraController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ClientControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.diContainer = diContainer
    self.cameraController = CameraController.new(self.diContainer)
	return self
end

function Controllers:init()
    self.cameraController:init()
end

return Controllers