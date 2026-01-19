local Controllers = require(script.Controllers)
local Services = require(script.Services)
local UseCases = require(script.UseCases)
---@class ClientApp
---@field controllers ClientControllers
---@field services ClientAppServices
---@field useCases ClientUseCases
---@field diContainer DIContainer
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.services = Services.new(self.diContainer)
	self.useCases = UseCases.new(self.diContainer)
	self.controllers = Controllers.new(self.diContainer)
	return self
end

function Application:init()
	self.services:init()
	self.useCases:init()
	self.controllers:init()

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	shared.remoteEventService:connectToEvents({
		[shared.constants.REMOTE_EVENTS.HUNTING_STARTED] = function(eventData)
			shared.eventBus:fire(shared.constants.REMOTE_EVENTS.HUNTING_STARTED, eventData)
		end,
		[shared.constants.REMOTE_EVENTS.FOOD_SPAWNED] = function(eventData)
			self.services.farmService:onFoodSpawned(eventData)
		end,
		[shared.constants.REMOTE_EVENTS.FOOD_EATEN] = function(eventData)
			self.services.farmService:onFoodEaten(eventData)
		end,
		[shared.constants.REMOTE_EVENTS.PLAYER_DIED] = function(eventData)
			warn("Application:init - PLAYER_DIED", eventData)
			shared.eventBus:fire(shared.constants.REMOTE_EVENTS.PLAYER_DIED, eventData)
		end,
		[shared.constants.REMOTE_EVENTS.PLAYER_UPDATED] = function(eventData)
			self.services.playerService:updatePlayer(eventData.data)
			self.services.lightingService:setMode(self.services.playerService:getPlayerState())
			shared.eventBus:fire(shared.constants.REMOTE_EVENTS.PLAYER_UPDATED, eventData.data)
		end,
	})
end
return Application
