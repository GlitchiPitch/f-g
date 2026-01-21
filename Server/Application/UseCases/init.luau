---@class ServerUseCases
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field actionService ServerActionService
---@field alchemyService ServerAlchemyService
---@field craftService ServerCraftService
---@field remoteEventService RemoteEventService
---@field constants Constants
local UseCases = {}
UseCases.__index = UseCases

---@param diContainer DIContainer
---@return ServerUseCases
function UseCases.new(diContainer)
	local self = setmetatable({}, UseCases)
	self.diContainer = diContainer
	return self
end

function UseCases:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.actionService = application.services.actionService
	self.playerRepository = infrastructure.repositories.playerRepository
	self.alchemyService = application.services.alchemyService
	self.craftService = application.services.craftService
end

---@param player Player
function UseCases:peck(player)
	print(`Peck by {player.Name}`)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	self.actionService:peck(playerEntity)
end

---@param player Player
function UseCases:toolActivated(player)
	print(`Tool activated by {player.Name}`)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	self.actionService:toolActivated(playerEntity)
end

---@param player Player
---@param data table
function UseCases:brewPotion(player, data)
	print(`Brew potion by {player.Name}`)
	data.player = player
	local result, message = self.alchemyService:tryBrew(data)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.BREW_POTION,
		data = {
			result = result,
			message = message,
		},
	})
end

---@param player Player
---@param data table
function UseCases:equipItem(player, data)
	data.player = player
	local currentTool = player.Character:FindFirstChildOfClass("Tool")
	if currentTool then
		if currentTool == data.item then
			currentTool.Parent = player.Backpack
		else
			currentTool.Parent = player.Backpack
			data.item.Parent = player.Character
		end
	else
		data.item.Parent = player.Character
	end
end

---@param player Player
---@param data table
function UseCases:craftItem(player, data)
	print(`Craft item by {player.Name}`)
	data.player = player
	local result, message = self.craftService:tryCraft(data)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.CRAFT_ITEM,
		data = {
			result = result,
			message = message,
		},
	})
end

---@param player Player
---@param data table
function UseCases:addItemForBrewing(player, data)
	data.player = player
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	local result = self.alchemyService:addItemForBrewing(playerEntity, data.item)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.ADD_ITEM_FOR_BREWING,
		data = {
			result = result,
		},
	})
end

return UseCases
