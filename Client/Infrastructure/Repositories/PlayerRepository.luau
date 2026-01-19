---@class ClientPlayerRepository
---@field diContainer DIContainer
---@field player Player
---@field playerEntity PlayerEntity
---@field playerEntities table<number, PlayerEntity>
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self.playerEntities = {}
	return self
end

function PlayerRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.playerEntity = shared.domain.Entities.Player
end

---@param player Player
---@return PlayerEntity
function PlayerRepository:getPlayerEntity(player)
	if not self.playerEntities[player.UserId] then
		self.playerEntities[player.UserId] = self.playerEntity.new(player)
	end

	return self.playerEntities[player.UserId]
end

return PlayerRepository
