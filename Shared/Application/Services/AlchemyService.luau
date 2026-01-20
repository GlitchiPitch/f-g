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
    self.recipes = shared.data.Potions
    self.potions = shared.assets.Potions
end

---@param data table
function AlchemyService:tryBrew(data)
    error("Not implemented")
end

---@param recipe table
---@return boolean
function AlchemyService:checkRecipe(inventory, recipe)
    for itemName, amount in recipe do
        if inventory[itemName] < amount then
            return false
        end
    end
    return true
end

return AlchemyService