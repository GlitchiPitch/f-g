---@class SharedEnemyRepository
local EnemyRepository = {}
EnemyRepository.__index = EnemyRepository

---@param diContainer DIContainer
---@return SharedEnemyRepository
function EnemyRepository.new(diContainer)
	local self = setmetatable({}, EnemyRepository)
	self.diContainer = diContainer
	return self
end

function EnemyRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
    self.data = shared.data.Enemies
end

---@return EnemiesData
function EnemyRepository:getAllEnemiesData()
	return self.data
end

---@param enemyName string
---@return EnemyData?
function EnemyRepository:getEnemyData(enemyName)
	return self.data[enemyName]
end

---@param enemyName string
---@return Model?
function EnemyRepository:getEnemyAsset(enemyName)
	local enemyData = self:getEnemyData(enemyName)
	if not enemyData then
		return
	end

	return enemyData.model:Clone()
end

return EnemyRepository