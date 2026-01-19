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

function EnemyController:init() end

function EnemyController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._updateTime then
		self._deltaTime = 0 -- Reset delta time

		for _, enemy in self.enemies do
			enemy:update()
		end
	end
end

function EnemyController:onEnemySpawned(enemy)
	self.enemies[enemy.id] = enemy
end

function EnemyController:onEnemyDied(enemy)
	self.enemies[enemy.id] = nil
end

return EnemyController
