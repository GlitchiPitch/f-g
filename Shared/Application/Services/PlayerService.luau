--- dont require like other services here. just import for inheritance
---@class SharedPlayerService
---@field diContainer DIContainer
---@field _playerRepository SharedPlayerRepository
---@field constants Constants
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return SharedPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param player Player
---@return PlayerEntity
function PlayerService:getPlayerEntity(player)
	local playerRepository = self:_getPlayerRepository()
	return playerRepository:getPlayerEntity(player)
end

---@param player Player
---@param playerData table
function PlayerService:updatePlayer(player, playerData)
	local playerEntity = self:getPlayerEntity(player)
	if playerData then
		playerEntity:fromData(playerData)
	end
end

---@param player Player
---@return string
function PlayerService:getCurrentWorldName(player)
	local playerEntity = self:getPlayerEntity(player)
	return playerEntity:getCurrentWorld()
end

---@param player Player
---@param worldName string
function PlayerService:setCurrentWorldName(player, worldName)
	local playerEntity = self:getPlayerEntity(player)
	playerEntity:setCurrentWorld(worldName)
end

--- Override in subclasses to return appropriate repository
---@return ServerPlayerRepository | ClientPlayerRepository
function PlayerService:_getPlayerRepository()
	error("BasePlayerService:_getPlayerRepository() must be implemented in subclass")
end

---@param player Player
function PlayerService:_onPlayerAdded(player)
	error("BasePlayerService:_onPlayerAdded() must be implemented in subclass")
end

---@param player Player
function PlayerService:_onPlayerRemoving(player)
	error("BasePlayerService:_onPlayerRemoving() must be implemented in subclass")
end

-- function PlayerService:_refreshPlayerData(player)
-- 	error("BasePlayerService:_refreshPlayerData() must be implemented in subclass")
-- end

return PlayerService
