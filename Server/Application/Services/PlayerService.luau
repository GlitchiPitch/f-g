---@class ServerPlayerService
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.remoteEventService = shared.infrastructure.services.remoteEventService
	self.playerRepository = infrastructure.repositories.playerRepository
	self.constants = shared.constants
end

function PlayerService:onPlayerAdded(player)
	self.playerRepository:getPlayerEntity(player)
end

function PlayerService:onPlayerRemoving(player)
	self.playerRepository:removePlayerEntity(player)
end

function PlayerService:updatePlayer(player)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	self.remoteEventService:fireClient(player, self.constants.REMOTE_EVENTS.PLAYER_UPDATED, {
		playerData = playerEntity:getData(),
	})
end

return PlayerService
