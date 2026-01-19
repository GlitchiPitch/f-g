local EnemyAI = require(script.BehaviorTrees.EnemyAI)

--// Enemy Handler
---@class EnemyService
---@field enemies table<string, EnemyEntity>
---@field diContainer DIContainer
local EnemyService = {}
EnemyService.__index = EnemyService

---@param diContainer DIContainer
---@return EnemyService
function EnemyService.new(diContainer)
	local self = setmetatable({}, EnemyService)
	self.diContainer = diContainer
	self.enemies = {}
	self.enemyFolder = workspace.Enemies
	return self
end

function EnemyService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	self.enemyController = application.controllers.enemyController
	self.EnemyTemplates = shared.data.Enemies
	self.Enemy = shared.domain.Entities.Enemy
end

-- Spawn method
function EnemyService:spawnEnemy(enemyType: string, spawnpoint: Vector3)
	local enemyData = self.EnemyTemplates[enemyType]
	if not enemyData then
		return
	end

	enemyData.name = enemyType
	local enemy = self.Enemy.new(enemyData)

	-- Set behavior tree
	local behaviorTree = EnemyAI(enemy.damage, enemy.attackRange, enemy.sightRange, enemy.attackAnimation)

	enemy:init(function()
		self:handleDeath(enemy)
	end, behaviorTree)

	self.enemies[enemy.id] = enemy
	if enemy.model then
		return
	end

	local model = enemy:spawn(spawnpoint, self.enemyFolder)
	self.enemyController:onEnemySpawned(enemy)

	return model
end

-- Handle death (custom die method that handles respawn and removal)
---@param enemy EnemyEntity
function EnemyService:handleDeath(enemy)
	if not enemy.model then
		return
	end

	self.enemyController:onEnemyDied(enemy)

	if enemy.respawnTime then
		-- Respawn after a set respawn time
		task.spawn(function()
			task.wait(enemy.respawnTime)
			self:spawnEnemy(enemy.name, enemy.spawnPoint)
		end)
	else
		-- Remove from global enemy list if it doesn't respawn
		self.enemies[enemy.id] = nil
	end
end

-- Cleanup
function EnemyService:destroy(enemy: any)
	enemy:destroy()
	-- Remove from global enemy list
	self.enemies[enemy.id] = nil
end

return EnemyService
