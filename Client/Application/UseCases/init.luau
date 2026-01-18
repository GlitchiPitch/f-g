---@class ClientUseCases
---@field diContainer DIContainer
---@field remoteEventService RemoteEventService
---@field constants Constants
local UseCases = {}
UseCases.__index = UseCases

---@param diContainer DIContainer
---@return ClientUseCases
function UseCases.new(diContainer)
	local self = setmetatable({}, UseCases)
	self.diContainer = diContainer
	return self
end

function UseCases:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

function UseCases:peck()
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.PECK,
	})
end

function UseCases:toolActivated()
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.TOOL_ACTIVATED,
	})
end

return UseCases
