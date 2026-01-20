---@class ClientActionService
---@field diContainer DIContainer
---@field animationService ClientAnimationService
---@field targetController TargetController
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
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    self.useCases = application.useCases
    self.animationService = application.services.animationService
    self.eventBus = shared.eventBus
    self.targetController = application.controllers.targetController
    self.alchemyService = application.services.alchemyService
    self.constants = shared.constants
end

function ActionService:interactAction()
    local currentTarget = self.targetController:getCurrentTarget()
    local interactType = currentTarget:GetAttribute(self.constants.ATTRIBUTES.INTERACT_TYPE)
    if interactType == "Alchemy" then
        self.alchemyService:openAlchemy()
    end
end

function ActionService:idleAction()
    self.animationService:playAnimation("peck")
    self.useCases:peck()
end

return ActionService