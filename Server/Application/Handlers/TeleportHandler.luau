local Players = game:GetService("Players")
---@class TeleportHandler
local TeleportHandler = {}
TeleportHandler.__index = TeleportHandler

---@param diContainer DIContainer
---@return TeleportHandler
function TeleportHandler.new(diContainer)
	local self = setmetatable({}, TeleportHandler)
	self.diContainer = diContainer
	return self
end

function TeleportHandler:init()
	local lobbyTeleports = workspace.Lobby.Teleports
	self:setupTeleport(lobbyTeleports.Enter.PrimaryPart, lobbyTeleports.Exit.PrimaryPart)
end

---@param a1 BasePart
---@param a2 BasePart
function TeleportHandler:setupTeleport(a1, a2)
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

return TeleportHandler
