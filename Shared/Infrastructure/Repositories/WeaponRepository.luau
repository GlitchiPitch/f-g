---@class SharedWeaponRepository
---@field diContainer DIContainer
---@field data WeaponsData
local WeaponRepository = {}
WeaponRepository.__index = WeaponRepository

---@param diContainer DIContainer
---@return SharedWeaponRepository
function WeaponRepository.new(diContainer)
	local self = setmetatable({}, WeaponRepository)
	self.diContainer = diContainer
	return self
end

function WeaponRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.data = shared.data.Weapons
end

---@return WeaponsData
function WeaponRepository:getAllWeaponsData()
    return self.data
end

---@param weaponName string
---@return WeaponData?
function WeaponRepository:getWeaponData(weaponName)
    return self.data.OneHanded[weaponName] or self.data.TwoHanded[weaponName]
end

---@param weaponName string
---@return Tool?
function WeaponRepository:getWeaponAsset(weaponName)
	local weaponData = self:getWeaponData(weaponName)
	if not weaponData then
		return
	end

	return weaponData.model:Clone()
end

return WeaponRepository