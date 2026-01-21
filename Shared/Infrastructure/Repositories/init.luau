local WeaponRepository = require(script.WeaponRepository)
local EnemyRepository = require(script.EnemyRepository)
local PotionRepository = require(script.PotionRepository)
local ItemRepository = require(script.ItemRepository)

---@class SharedRepositories
---@field weaponRepository SharedWeaponRepository
---@field itemRepository SharedItemRepository
---@field enemyRepository SharedEnemyRepository
---@field potionRepository SharedPotionRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return SharedRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
    self.weaponRepository = WeaponRepository.new(diContainer)
    self.itemRepository = ItemRepository.new(diContainer)
    self.enemyRepository = EnemyRepository.new(diContainer)
    self.potionRepository = PotionRepository.new(diContainer)
	return self
end

function Repositories:init()
    self.weaponRepository:init()
    self.itemRepository:init()
    self.enemyRepository:init()
    self.potionRepository:init()
end

return Repositories