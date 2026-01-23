local Players = game:GetService("Players")

---@class TeleportHandler
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field playerService ServerPlayerService
local TeleportService = {}
TeleportService.__index = TeleportService

---@param diContainer DIContainer
---@return TeleportHandler
function TeleportService.new(diContainer)
	local self = setmetatable({}, TeleportService)
	self.diContainer = diContainer
	return self
end

function TeleportService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository
	self.eventBus = shared.infrastructure.eventBus
	self.constants = shared.constants
	local lobbyTeleports = workspace.Teleports.Lobby
	self:setupTeleport(lobbyTeleports.Enter.PrimaryPart, lobbyTeleports.Exit.PrimaryPart, "MainWorld")

	for _, world in workspace.Teleports:GetChildren() do
		self:setupTeleport(
			world.Enter.PrimaryPart,
			world.Exit.PrimaryPart,
			world:GetAttribute("NextWorld")
		)
	end
end

---@param a1 BasePart
---@param a2 BasePart
---@param worldName string
function TeleportService:setupTeleport(a1, a2, worldName)
	local function onTouch(otherPart, targetPart)
		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if player and not player:GetAttribute("Teleported") then
			local playerEntity = self.playerRepository:getPlayerEntity(player)
			local currentWorld = if worldName then workspace.Worlds:FindFirstChild(worldName) else workspace.Lobby
			playerEntity:setCurrentWorld(worldName)
			self.eventBus:fire(self.constants.EVENTS.PLAYER_UPDATE, player)
			player:SetAttribute("Teleported", true)
			player.Character:PivotTo(CFrame.new(targetPart.CFrame.Position) + Vector3.new(0, 2, 0))
			player.Character.Parent = currentWorld.Players
			task.delay(2, function()
				player:SetAttribute("Teleported", false)
			end)
		end
	end

	a1.Touched:Connect(function(otherPart)
		onTouch(otherPart, a2)
	end)
	a2.Touched:Connect(function(otherPart)
		onTouch(otherPart, a1)
	end)
end

return TeleportService
