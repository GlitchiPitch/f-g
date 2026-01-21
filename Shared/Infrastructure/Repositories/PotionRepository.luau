---@class SharedPotionRepository
local PotionRepository = {}
PotionRepository.__index = PotionRepository

---@param diContainer DIContainer
---@return SharedPotionRepository
function PotionRepository.new(diContainer)
	local self = setmetatable({}, PotionRepository)
	self.diContainer = diContainer
	return self
end

function PotionRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.data = shared.data.Potions
end

---@return PotionsData
function PotionRepository:getAllPotionsData()
	return self.data
end

---@param potionName string
---@return PotionData?
function PotionRepository:getPotionData(potionName)
	return self.data[potionName]
end

---@param potionName string
---@return Tool?
function PotionRepository:getPotionAsset(potionName)
	local potionData = self:getPotionData(potionName)
	if not potionData then
		return
	end

	return potionData.model:Clone()
end

return PotionRepository