--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local HttpService = game:GetService("HttpService")

--// Modules
local BehaviorTree = require(ServerStorage.BehaviorTrees.EnemyAI)
local EnemyTemplates = require(ReplicatedStorage.Modules.EnemyTemplates)

--// Setup
local enemyFolder = workspace:WaitForChild("Enemies")

--// Enemy Class
local module = { enemies = {} }
local enemyClass = {}

enemyClass.__index = enemyClass

-- Constructor
function module.new(enemyType: string)
	local self = setmetatable({}, enemyClass)
	local enemyData = EnemyTemplates[enemyType]

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
	self.behaviorTree = BehaviorTree(self.damage, self.attackRange, self.sightRange, self.attackAnimation)

	module.enemies[self.id] = self
	return self
end

-- Spawn method
function enemyClass:spawn(spawnpoint: Vector3)
	if self.model then
		return
	end

	-- Clone the model and set position
	local modelClone = self.storedModel:Clone()
	modelClone.PrimaryPart.CFrame = CFrame.new(spawnpoint)
	modelClone.Parent = enemyFolder

	self.spawnPoint = spawnpoint
	self.model = modelClone

	local humanoid = modelClone:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.MaxHealth = self.health
		humanoid.Health = self.health
		humanoid.WalkSpeed = self.speed

		humanoid.Died:Connect(function()
			self:die()
		end)
	end

	-- Start AI loop
	self:runAI()

	return modelClone
end

-- Run AI
function enemyClass:runAI()
	task.spawn(function()
		while self.model and self.model.Parent do
			self.behaviorTree:Tick(self)
			task.wait(0.2)
		end
		self:die()
	end)
end

-- Handle death
function enemyClass:die()
	if not self.model then
		return
	end

	local model = self.model
	self.model = nil

	task.spawn(function()
		task.wait(3) -- Prevents the body from instantly disappearing
		model:Destroy()
	end)

	if self.respawnTime then
		-- Respawn after a set respawn time
		task.wait(self.respawnTime)

		self:spawn(self.spawnPoint)
	else
		-- Remove from global enemy list if it doesn't respawn
		module.enemies[self.id] = nil
	end
end

-- Cleanup
function enemyClass:destroy()
	if self.model then
		self.model:Destroy()
		self.model = nil
	end

	-- Remove from gloabl enemy list
	module.enemies[self.id] = nil
end

return module
