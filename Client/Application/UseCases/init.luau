---@class ClientUseCases
---@field diContainer DIContainer
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field eventBus EventBus
---@field playerService ClientPlayerService
---@field lightingService LightingService
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
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.playerService = application.services.playerService
	self.lightingService = application.services.lightingService
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.eventBus = shared.eventBus
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

---@param data table
function UseCases:brewPotion(data)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.BREW_POTION,
		data = data,
	})
end

function UseCases:updatePlayer(data)
	self.playerService:updatePlayer(data)
	self.lightingService:setMode(self.playerService:getPlayerState())
	self.eventBus:fire(self.constants.REMOTE_EVENTS.PLAYER_UPDATED, data)
end

function UseCases:onFoodSpawned(data)
	self.eventBus:fire(self.constants.REMOTE_EVENTS.FOOD_SPAWNED, data)
end

function UseCases:onFoodEaten(data)
	self.eventBus:fire(self.constants.REMOTE_EVENTS.FOOD_EATEN, data)
end

function UseCases:equipItem(item)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.EQUIP_ITEM,
		data = { item = item },
	})
end

return UseCases
