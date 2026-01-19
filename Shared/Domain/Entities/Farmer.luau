local ReplicatedStorage = game:GetService("ReplicatedStorage")

---@class FarmerEntity
---@field model Model
---@field connections table<string, RBXScriptSignal>
---@field attackDistance number
---@field _humanoid Humanoid
local FarmerEntity = {}
FarmerEntity.__index = FarmerEntity

---@param model Model
---@return FarmerEntity
function FarmerEntity.new(model)
	local self = setmetatable({}, FarmerEntity)
	self.model = model
	self._humanoid = self.model.Humanoid
	self.connections = {}
	self.attackDistance = 20
	return self
end

function FarmerEntity:init(diContainer)
	---@type Shared
	local shared = diContainer:resolve("Shared")
	self.run = self._humanoid.Animator:LoadAnimation(shared.assets.Animations.Run)
	self.idle = self._humanoid.Animator:LoadAnimation(shared.assets.Animations.Idle)

	self.animationTracks = {
		run = self.run,
		idle = self.idle,
	}

	self._humanoid.Changed:Connect(function(_)
		if self._humanoid.WalkToPoint.Magnitude > 0 then
			if self.animationTracks.run.IsPlaying then
				return
			end
			self.animationTracks.run:Play()
		else
			if self.animationTracks.idle.IsPlaying then
				return
			end
			self.animationTracks.idle:Play()
		end
	end)
end

---@param state boolean
function FarmerEntity:setState(state)
	if state then
		self.model.Parent = workspace
	else
		self.model.Parent = ReplicatedStorage
	end
end

---@param position Vector3
function FarmerEntity:setToPosition(position)
	self.model:PivotTo(CFrame.new(position))
end

---@param position Vector3
function FarmerEntity:moveTo(position)
	self._humanoid:MoveTo(position)
end

---@param playerEntity PlayerEntity
function FarmerEntity:attack(playerEntity) end

function FarmerEntity:destroy() end

return FarmerEntity
