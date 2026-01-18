local UseCases = require(script.UseCases)
local Services = require(script.Services)
local Controllers = require(script.Controllers)
---@class ServerApp
---@field diContainer DIContainer
---@field services ServerAppServices
---@field useCases ServerUseCases
---@field controllers ServerControllers
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.services = Services.new(diContainer)
	self.useCases = UseCases.new(diContainer)
	self.controllers = Controllers.new(diContainer)
	return self
end

function Application:init()
	self.services:init()
	self.useCases:init()
	self.controllers:init()

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	shared.remoteEventService:connectToEvents({
		[shared.constants.REMOTE_EVENTS.PECK] = function(player, eventData)
			self.useCases:peck(player)
		end,
		[shared.constants.REMOTE_EVENTS.TOOL_ACTIVATED] = function(player, eventData)
			self.useCases:toolActivated(player)
		end,
	})
end

return Application
