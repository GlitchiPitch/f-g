---@class ClientActionService
---@field diContainer DIContainer
---@field animationService ClientAnimationService
---@field remoteEventService RemoteEventService
---@field constants Constants
local ActionService = {}
ActionService.__index = ActionService

---@param diContainer DIContainer
---@return ClientActionService
function ActionService.new(diContainer)
	local self = setmetatable({}, ActionService)
	self.diContainer = diContainer
	return self
end

function ActionService:init()
    ---@type ClientApp
    local application = self.diContainer:resolve("Application")
    self.useCases = application.useCases
    self.animationService = application.services.animationService
end

function ActionService:npcAction()
end

function ActionService:idleAction()
    self.animationService:playAnimation("peck")
    self.useCases:peck()
end

return ActionService