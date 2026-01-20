local Players = game:GetService("Players")
---@class TargetController
---@field diContainer DIContainer
---@field playerService ClientPlayerService
---@field availableStatesForRender string[]
---@field eventBus EventBus
local TargetController = {}
TargetController.__index = TargetController

---@param diContainer DIContainer
---@return TargetController
function TargetController.new(diContainer)
	local self = setmetatable({}, TargetController)
	self.diContainer = diContainer
	self.checkedTarget = nil
	self.currentCheckedTarget = nil
	self.player = Players.LocalPlayer

	return self
end

function TargetController:init()
	self.character = self.player.Character or self.player.CharacterAdded:wait()

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	---@type ClientApp
	local application = self.diContainer:resolve("Application")

	self.lockOnInfo = shared.config.Client.TargetController
	self.playerService = application.services.playerService
end

function TargetController:getCurrentTarget()
	return self.currentCheckedTarget
end

function TargetController:update()
	-- local playerState = self.playerService:getPlayerState()
	-- if not table.find(self.availableStatesForRender, playerState) then
	-- 	if self.currentCheckedTarget then
	-- 		self:_toogleTargetView(false)
	-- 		-- self.currentCheckedTarget = nil
	-- 	end
	-- 	return
	-- end

	self.checkedTarget = self:_getTargetsClosestCrosshair()
	if self.checkedTarget then
		if self.currentCheckedTarget and self.currentCheckedTarget ~= self.checkedTarget then
			self:_toogleTargetView(false)
			self.currentCheckedTarget = nil
		end

		self.currentCheckedTarget = self.checkedTarget
		self:_toogleTargetView(true)
		self:_setPlayerStateByTarget()
	else
		if self.currentCheckedTarget then
			self:_toogleTargetView(false)
			self.currentCheckedTarget = nil
			self:_setPlayerStateByTarget()
		end
	end
end

function TargetController:_toogleTargetView(state)
	if state then
		if self.currentCheckedTarget:HasTag(self.constants.INTERACT_OBJECT_TYPES.INTERACT) then
			local ui = self.currentCheckedTarget:FindFirstChildOfClass("BillboardGui")
			if ui then
				ui.Enabled = true
			end
		end
	else
		local ui = self.currentCheckedTarget:FindFirstChildOfClass("BillboardGui")
		if ui then
			ui.Enabled = false
		end
	end
end

function TargetController:_setPlayerStateByTarget()
	if self.currentCheckedTarget then
		-- if self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.INTERACT) then
		-- 	self.playerService:setPlayerState("Interact")
		-- elseif self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.LOOT) then
		-- 	self.playerService:setPlayerState("Loot")
		-- elseif self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.NPC) then
		-- 	self.playerService:setPlayerState("NPC")
		-- else
		-- 	self.playerService:setPlayerState(self.constants.PLAYER_STATES.IDLE)
		-- end
		self.eventBus:fire("toggleActionButton", { state = true })
	else
		-- self.playerService:setPlayerState(self.constants.PLAYER_STATES.IDLE)
		self.eventBus:fire("toggleActionButton", { state = false })
	end
end

function TargetController:_getTargetsInRange()
	local targets = {}
	local partsInRadius =
		workspace:GetPartBoundsInRadius(self.character.HumanoidRootPart.Position, self.lockOnInfo.range)

	for _, part in partsInRadius do
		if part:IsA("BasePart") then
			if game.Players:GetPlayerFromCharacter(part.Parent) then
				if self.lockOnInfo.lockOnPlayers == true then
					if not table.find(targets, part.Parent) then
						table.insert(targets, part.Parent)
					end
				end
			elseif part.Parent:HasTag(self.constants.INTERACT_OBJECT_TYPES.INTERACT) then
				if not table.find(targets, part.Parent) then
					table.insert(targets, part.Parent)
				end
			end
		end
	end

	return targets
end

function TargetController:_getTargetsClosestCrosshair()
	-- Create a ray from the player's position in the direction they're looking
	local origin = self.character.HumanoidRootPart.Position
	local direction = self.character.HumanoidRootPart.CFrame.LookVector

	-- Set up raycast parameters to exclude the player's own character
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = { self.character }

	-- Cast the ray
	local ray = workspace:Raycast(origin, direction * self.lockOnInfo.range, rayParams)

	if ray then
		local hitInstance = ray.Instance
		local hitModel = hitInstance.Parent

		-- Check if the hit object is a valid target
		if hitModel and hitModel ~= self.character then
			-- Check if it's another player
			if game.Players:GetPlayerFromCharacter(hitModel) then
				if self.lockOnInfo.lockOnPlayers == true then
					return hitModel
				end
			-- Check if it has the required tags
			elseif hitModel:HasTag(self.constants.INTERACT_OBJECT_TYPES.INTERACT) then
				return hitModel
			end
		end
	end

	return nil
end

function TargetController:_isTargetInView()
	local excludedCharacters = self:_getTargetsInRange()
	table.remove(excludedCharacters, table.find(excludedCharacters, self.target))

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = excludedCharacters

	local origin = self.character.HumanoidRootPart.Position
	local direction = (self.target.PrimaryPart.Position - origin).Unit

	local ray = workspace:Raycast(origin, direction * self.lockOnInfo.range, rayParams)

	if ray then
		if ray.Instance.Parent == self.target then
			return true
		end
	end

	return false
end

function TargetController:destroy()
	self.currentCheckedTarget = nil
	self.checkedTarget = nil
	self.target = nil
end

return TargetController
