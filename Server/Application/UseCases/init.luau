---@class ServerUseCases
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field actionService ServerActionService
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
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.actionService = application.services.actionService
	self.playerRepository = infrastructure.repositories.playerRepository
end

---@param player Player
function UseCases:peck(player)
	print(`Peck by {player.Name}`)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	self.actionService:peck(playerEntity)
end

return UseCases
