---@class ServerHuntingController
---@field diContainer DIContainer
---@field huntingService ServerHuntingService
---@field _deltaTime number
---@field _updateTime number
---@field mainWorld Model
local HuntingController = {}
HuntingController.__index = HuntingController

---@param diContainer DIContainer
---@return ServerHuntingController
function HuntingController.new(diContainer)
	local self = setmetatable({}, HuntingController)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._updateTime = 5
	return self
end

function HuntingController:init()
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	self.huntingService = application.services.huntingService
	self.mainWorld = workspace.Worlds.MainWorld
end

---@param deltaTime number
function HuntingController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime < self._updateTime then
		return
	end

	if self.huntingService.isActive then
		-- self.huntingService:stop()
	else
		self.huntingService:start()
	end

	self._deltaTime = 0
end

return HuntingController
