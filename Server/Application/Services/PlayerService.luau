local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedPlayerService = require(ReplicatedStorage.Shared.Application.Services.PlayerService)

---@class ServerPlayerService : SharedPlayerService
local PlayerService = setmetatable({}, SharedPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedPlayerService.new(diContainer), PlayerService)
	return self
end

function PlayerService:init()
	local function _onPlayerAdded(player)
		self:_onPlayerAdded(player)
	end
	local function _onPlayerRemoving(player)
		self:_onPlayerRemoving(player)
	end
	SharedPlayerService.init(self)

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.infrastructure.eventBus
	self.constants = shared.constants

	-- Listen for player update requests from TeleportService
	self.eventBus:connect(self.constants.EVENTS.PLAYER_UPDATE, function(player)
		self:refreshPlayerData(player)
	end)

	Players.PlayerAdded:Connect(_onPlayerAdded)
	Players.PlayerRemoving:Connect(_onPlayerRemoving)
end

---@param player Player
function PlayerService:refreshPlayerData(player)
	---@type ServerPlayerRepository
	local playerRepository = self:_getPlayerRepository()
	local playerEntity = playerRepository:getPlayerEntity(player)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_UPDATED,
		data = playerEntity:getData(),
	})
end

function PlayerService:_getPlayerRepository()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	return infrastructure.repositories.playerRepository
end

---@param player Player
function PlayerService:_onPlayerAdded(player)
	local playerRepository = self:_getPlayerRepository()
	local function onCharacterAdded(character)
		self:_onCharacterAdded(character)
	end

	playerRepository:getPlayerEntity(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end

function PlayerService:_onCharacterAdded(character)
	local player = Players:GetPlayerFromCharacter(character)
	local playerRepository = self:_getPlayerRepository()
	local playerEntity = playerRepository:getPlayerEntity(player)
	local humanoid = character:FindFirstChild("Humanoid")

	local currentWorldName = playerEntity:getCurrentWorld()
	local currentWorld = workspace.Worlds:FindFirstChild(currentWorldName)
	if currentWorld then
		character.Parent = currentWorld.Players
		character:PivotTo(CFrame.new(currentWorld.SpawnPoint.Position))
	else
		character.Parent = workspace.Lobby.Players
	end

	if humanoid then
		humanoid.Died:Connect(function()
			if player:GetAttribute("Hunter") then
				playerEntity:setCurrentWorld("Butchery")
				player:SetAttribute("Hunter", nil)
			else
				playerEntity:setCurrentWorld("Hell")
			end

			self:updatePlayer(player)

			if character.PrimaryPart then
				character.PrimaryPart.Anchored = true
			end
		end)
	end
end

---@param player Player
---@return boolean
function PlayerService:isAlive(player)
	return self:_isAlive(player)
end

---@param player Player
function PlayerService:_onPlayerRemoving(player)
	---@type ServerPlayerRepository
	local playerRepository = self:_getPlayerRepository()
	playerRepository:removePlayerEntity(player)
end

return PlayerService
