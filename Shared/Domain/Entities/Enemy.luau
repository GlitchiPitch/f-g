--// Services
local HttpService = game:GetService("HttpService")

---@class EnemyEntity
---@field id string
---@field name string
---@field health number
---@field speed number
---@field damage number
---@field attackRange number
---@field sightRange number
---@field respawnTime number
---@field storedModel Model
local Enemy = {}
Enemy.__index = Enemy

-- Constructor
---@param enemyData table
---@return EnemyEntity
function Enemy.new(enemyData)
	local self = setmetatable({}, Enemy)
	self.name = enemyData.name
	-- Unique ID
	self.id = HttpService:GenerateGUID(false)

	-- Stats
	self.health = enemyData.health
	self.speed = enemyData.speed
	self.damage = enemyData.damage
	self.attackRange = enemyData.attackRange
	self.sightRange = enemyData.sightRange
	self.respawnTime = enemyData.respawnTime

	-- Other
	self.storedModel = enemyData.model -- Model in the SeverStorage
	self.model = nil -- Model of the alive NPC
	self.spawnPoint = nil
	self.attackAnimation = enemyData.attackAnimation -- Optional
	self.behaviorTree = nil -- Will be set by handler
	self.onDeath = nil -- Callback for death handling, set by handler

	return self
end

---@param onDeath function
function Enemy:init(onDeath, behaviorTree)
	self.onDeath = onDeath
	self.behaviorTree = behaviorTree
end

-- Spawn method
function Enemy:spawn(spawnpoint: Vector3, enemyFolder: Folder)
	if self.model then
		return
	end

	-- Clone the model and set position
	local modelClone = self.storedModel:Clone()
	modelClone.PrimaryPart.CFrame = CFrame.new(spawnpoint)
	modelClone.Parent = enemyFolder

	self.spawnPoint = spawnpoint
	self.model = modelClone

	self.humanoid = modelClone:FindFirstChildOfClass("Humanoid")

	-- Load attack animation if available
	if self.attackAnimation and self.humanoid then
		local animator = self.humanoid:FindFirstChildOfClass("Animator")
		if animator then
			local anim = Instance.new("Animation")
			anim.AnimationId = "rbxassetid://" .. self.attackAnimation
			self.attackTrack = animator:LoadAnimation(anim)
		end
	end

	if self.humanoid then
		self.humanoid.MaxHealth = self.health
		self.humanoid.Health = self.health
		self.humanoid.WalkSpeed = self.speed

		self.humanoid.Died:Connect(function()
			self:die()
		end)
	end

	return modelClone
end

-- Run AI
function Enemy:update()
	if self.model and self.model.Parent then
		self.behaviorTree:Tick(self)
	else
		self:die()
	end
end

-- Handle death
function Enemy:die()
	if not self.model then
		return
	end

	local model = self.model
	self.model = nil

	task.spawn(function()
		task.wait(3) -- Prevents the body from instantly disappearing
		model:Destroy()
	end)

	-- Call death callback (handler will handle respawn/removal logic)
	if self.onDeath then
		self.attackTrack:Stop()
		self.attackTrack = nil
		self.onDeath()
	end
end

function Enemy:attack()
	self.attackTrack:Play()
end
-- Cleanup
function Enemy:destroy()
	if self.attackTrack then
		self.attackTrack:Stop()
		self.attackTrack = nil
	end

	if self.model then
		self.model:Destroy()
		self.model = nil
	end
end

return Enemy
