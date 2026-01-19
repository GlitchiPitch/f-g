local WeaponRepository = require(script.WeaponRepository)
local ItemsRepository = require(script.ItemsRepository)

---@class SharedRepositories
---@field weaponRepository SharedWeaponRepository
---@field itemsRepository SharedItemsRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return SharedRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
    self.weaponRepository = WeaponRepository.new(diContainer)
    self.itemsRepository = ItemsRepository.new(diContainer)
	return self
end

function Repositories:init()
    self.weaponRepository:init()
    self.itemsRepository:init()
end

return Repositories