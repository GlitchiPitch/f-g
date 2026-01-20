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

---@return Model | nil
function TargetController:getCurrentTarget()
	return self.currentCheckedTarget
end

function TargetController:update()
	
	self.checkedTarget = self:_getTargetsClosestCrosshair()
	if self.checkedTarget then
		if self.currentCheckedTarget and self.currentCheckedTarget ~= self.checkedTarget then
			self.currentCheckedTarget = nil
		end

		self.currentCheckedTarget = self.checkedTarget
		self:_setPlayerStateByTarget()
	else
		if self.currentCheckedTarget then
			self.currentCheckedTarget = nil
			self:_setPlayerStateByTarget()
		end
	end
end

function TargetController:_setPlayerStateByTarget()
	if self.currentCheckedTarget then
		self.eventBus:fire("toggleActionButton", { state = true })
	else
		self.eventBus:fire("toggleActionButton", { state = false })
	end
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
			-- Check if the target is within range
			if game.Players:GetPlayerFromCharacter(hitModel) then
				local distance = (hitModel.PrimaryPart.Position - origin).Magnitude
				if self.lockOnInfo.lockOnPlayers == true and distance <= self.lockOnInfo.range then
					return hitModel
				end
				-- Check if it has the required tags
			elseif hitModel:HasTag(self.constants.TAGS.INTERACT) then
				local distance = (hitModel.PrimaryPart.Position - origin).Magnitude
				if distance <= self.lockOnInfo.range then
					return hitModel
				end
			end
		end
	end

	return nil
end

function TargetController:destroy()
	self.currentCheckedTarget = nil
	self.checkedTarget = nil
	self.target = nil
end

return TargetController
