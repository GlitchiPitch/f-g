---@class ServerEnemyController
---@field diContainer DIContainer
---@field enemies table<string, EnemyEntity>
local EnemyController = {}
EnemyController.__index = EnemyController

---@param diContainer DIContainer
---@return ServerEnemyController
function EnemyController.new(diContainer)
	local self = setmetatable({}, EnemyController)
	self.diContainer = diContainer
	self.enemies = {}
	self._updateTime = 0.2
	self._deltaTime = 0
	return self
end

function EnemyController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants

	self:_spawnTestEnemies()

end

function EnemyController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._updateTime then
		self._deltaTime = 0 -- Reset delta time
		self.eventBus:fire(self.constants.EVENTS.ENEMY_UPDATE)
	end
end


function EnemyController:_spawnTestEnemies()
	local w1SpawnPoints = workspace.Worlds.World1.EnemySpawnPoints:GetChildren()
	for _, spawnPoint in w1SpawnPoints do

		self.eventBus:fire(self.constants.EVENTS.ENEMY_SPAWNED, {
			enemyType = "Orc",
			spawnPoint = spawnPoint.Position,
		})
	end
end

return EnemyController
