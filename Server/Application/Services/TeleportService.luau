local Players = game:GetService("Players")

---@class TeleportService
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field playerService ServerPlayerService
---@field worlds Folder
---@field telepors Folder
local TeleportService = {}
TeleportService.__index = TeleportService

---@param diContainer DIContainer
---@return TeleportService
function TeleportService.new(diContainer)
	local self = setmetatable({}, TeleportService)
	self.diContainer = diContainer
	self.teleports = workspace.Teleports
	self.worlds = workspace.Worlds
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
end

---@param player Player
---@param worldName string
---@param target '"Enter"' | '"Exit"'
function TeleportService:teleport(player, worldName, target)
	if player and not player:GetAttribute("Teleported") then
		local playerEntity = self.playerRepository:getPlayerEntity(player)
		---@type Folder
		local currentWorldTeleports = worldName and self.teleports:FindFirstChild(worldName)
		local currentWorld = self.worlds:FindFirstChild(worldName)
		if not currentWorldTeleports then
			return	
		end

		---@type Model
		local targetModel = currentWorldTeleports:FindFirstChild(target)

		playerEntity:setCurrentWorld(worldName)
		self.eventBus:fire(self.constants.EVENTS.PLAYER_UPDATE, player)
		player:SetAttribute("Teleported", true)
		player.Character:PivotTo(CFrame.new(targetModel.PrimaryPart.CFrame.Position) + Vector3.new(0, 2, 0))
		player.Character.Parent = currentWorld.Players
		task.delay(2, function()
			player:SetAttribute("Teleported", false)
		end)
	end
end

return TeleportService
