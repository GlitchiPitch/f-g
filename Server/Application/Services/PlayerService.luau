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

---@param player Player
function PlayerService:onPlayerAdded(player)
	local function onCharacterAdded(character)
		local playerEntity = self.playerRepository:getPlayerEntity(player)
		local humanoid = character:FindFirstChild("Humanoid")

		local currentWorldName = playerEntity:getCurrentWorld()
		local currentWorld = workspace.Worlds:FindFirstChild(currentWorldName)

		if currentWorld then
			character.Parent = currentWorld.Players
		else
			character.Parent = workspace.Lobby.Players
		end

		if humanoid then
			humanoid.Died:Connect(function()
				playerEntity:setCurrentWorld("Hell")
			end)
		end
	end

	self.playerRepository:getPlayerEntity(player)
	player.CharacterAdded:Connect(onCharacterAdded)
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
