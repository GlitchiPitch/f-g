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
		warn("PlayerService:onPlayerAdded - Character added: ", character)
		local playerEntity = self.playerRepository:getPlayerEntity(player)
		local humanoid = character:FindFirstChild("Humanoid")

		local currentWorldName = playerEntity:getCurrentWorld()
		local currentWorld = workspace.Worlds:FindFirstChild(currentWorldName)
		warn("PlayerService:onPlayerAdded - Current world: ", currentWorldName)
		if currentWorld then
			character.Parent = currentWorld.Players
			character:PivotTo(CFrame.new(currentWorld.SpawnPoint.Position))
		else
			character.Parent = workspace.Lobby.Players
		end

		if humanoid then
			humanoid.Died:Connect(function()
				warn("PlayerService:onPlayerAdded - Humanoid died")
				if player:GetAttribute("Hunter") then
					playerEntity:setCurrentWorld("Butchery")
					player:SetAttribute("Hunter", nil)
				else
					playerEntity:setCurrentWorld("Hell")
				end
				
				if character.PrimaryPart then
					character.PrimaryPart.Anchored = true
				end

				self.remoteEventService:fireClient(player, self.constants.REMOTE_EVENTS.PLAYER_DIED, {
					playerData = playerEntity:getData(),
				})
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
