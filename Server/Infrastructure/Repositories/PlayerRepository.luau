---@class ServerPlayerRepository
---@field diContainer DIContainer
---@field PlayerEntity PlayerEntity
---@field playerEntities table<number, PlayerEntity>
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ServerPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self.playerEntities = {}
	return self
end

function PlayerRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.PlayerEntity = shared.domain.Entities.Player
end

---@param player Player
---@return PlayerEntity
function PlayerRepository:getPlayerEntity(player)
	if not self.playerEntities[player.UserId] then
		self.playerEntities[player.UserId] = self.PlayerEntity.new(player)
	end

	return self.playerEntities[player.UserId]
end

---@param player Player
function PlayerRepository:removePlayerEntity(player)
	self.playerEntities[player.UserId] = nil
end

---@return table<number, PlayerEntity>
function PlayerRepository:getPlayers()
	return self.playerEntities
end

return PlayerRepository
