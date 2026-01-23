---@class ServerHuntingController
---@field diContainer DIContainer
---@field _deltaTime number
---@field _updateTime number
---@field mainWorld Model
---@field isActive boolean
local HuntingController = {}
HuntingController.__index = HuntingController

---@param diContainer DIContainer
---@return ServerHuntingController
function HuntingController.new(diContainer)
	local self = setmetatable({}, HuntingController)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._updateTime = 5
	self.isActive = false
	return self
end

function HuntingController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.infrastructure.eventBus
	self.constants = shared.constants
	self.mainWorld = workspace.Worlds.MainWorld

	-- Listen for hunting status changes from HuntingService
	self.eventBus:connect(self.constants.EVENTS.HUNTING_STATUS_CHANGED, function(data)
		self.isActive = data.isActive
	end)
end

---@param deltaTime number
function HuntingController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime < self._updateTime then
		return
	end

	if self.isActive then
		self.eventBus:fire(self.constants.EVENTS.HUNTING_STOP)
	else
		self.eventBus:fire(self.constants.EVENTS.HUNTING_START)
	end

	self._deltaTime = 0
end

return HuntingController
