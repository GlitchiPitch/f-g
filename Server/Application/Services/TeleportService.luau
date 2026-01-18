local Players = game:GetService("Players")
---@class TeleportHandler
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
	local lobbyTeleports = workspace.Lobby.Teleports
	self:setupTeleport(lobbyTeleports.Enter.PrimaryPart, lobbyTeleports.Exit.PrimaryPart)

	for _, world in workspace.Worlds:GetChildren() do
		if world:FindFirstChild("Teleports") then
			self:setupTeleport(world.Teleports.Enter.PrimaryPart, world.Teleports.Exit.PrimaryPart)
		end
	end
end

---@param a1 BasePart
---@param a2 BasePart
function TeleportService:setupTeleport(a1, a2)
	local function onTouch(otherPart, targetPart)
		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if player and not player:GetAttribute("Teleported") then
			player:SetAttribute("Teleported", true)
			player.Character:PivotTo(CFrame.new(targetPart.CFrame.Position) + Vector3.new(0, 2, 0))
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
