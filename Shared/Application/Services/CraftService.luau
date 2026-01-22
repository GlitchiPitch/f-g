---@class SharedCraftService
---@field diContainer DIContainer
local CraftService = {}
CraftService.__index = CraftService

---@param diContainer DIContainer
---@return SharedCraftService
function CraftService.new(diContainer)
	local self = setmetatable({}, CraftService)
	self.diContainer = diContainer
	return self
end

function CraftService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.weaponRepository = shared.infrastructure.repositories.weaponRepository
end

function CraftService:tryCraft()
	error("Not implemented")
end

---@param usedItems string[]
---@return Tool?
function CraftService:checkRecipe(usedItems)
	local allWeaponsData = self.weaponRepository:getAllWeaponsData()

	-- Count the used items
	local usedItemCounts = {}
	for _, itemName in usedItems do
		usedItemCounts[itemName] = (usedItemCounts[itemName] or 0) + 1
	end

	-- Find which weapon matches the used items
	for weaponType, weaponTypeData in allWeaponsData do
		for weaponName, weaponData in weaponTypeData do
			local recipe = weaponData.requirement.recipe
			local recipeMatches = true

			-- Check if used items match the recipe exactly (both ingredients and amounts)
			for itemName, requiredAmount in recipe do
				local usedAmount = usedItemCounts[itemName] or 0
				if usedAmount ~= requiredAmount then
					recipeMatches = false
					break
				end
			end

			-- Also check that we don't have extra items (exact match required)
			for itemName, _ in usedItemCounts do
				if not recipe[itemName] then
					recipeMatches = false
					break
				end
			end

			if recipeMatches then
				-- Return the weapon tool
				return self.weaponRepository:getWeaponAsset(weaponName)
			end
		end
	end

	return nil -- No matching weapon found
end
return CraftService
