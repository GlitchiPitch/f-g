---@class SharedAlchemyService
---@field diContainer DIContainer
local AlchemyService = {}
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return SharedAlchemyService
function AlchemyService.new(diContainer)
	local self = setmetatable({}, AlchemyService)
	self.diContainer = diContainer
	return self
end

function AlchemyService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.potionRepository = shared.infrastructure.repositories.potionRepository
end

function AlchemyService:tryBrew()
	error("Not implemented")
end

---@param usedItems string[]
---@return Tool?
function AlchemyService:checkRecipe(usedItems)
	local allPotionsData = self.potionRepository:getAllPotionsData()

	-- Count the used items
	local usedItemCounts = {}
	for _, itemName in usedItems do
		usedItemCounts[itemName] = (usedItemCounts[itemName] or 0) + 1
	end

	-- Find which potion matches the used items
	for potionName, potionData in allPotionsData do
		local recipe = potionData.requirements.recipe
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
			-- Return the potion tool
			return self.potionRepository:getPotionAsset(potionName)
		end
	end

	return nil -- No matching potion found
end

return AlchemyService
