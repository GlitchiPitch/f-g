local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedAlchemyService = require(ReplicatedStorage.Shared.Application.Services.AlchemyService)

---@class ServerAlchemyService : SharedAlchemyService
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
local AlchemyService = setmetatable({}, SharedAlchemyService)
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return ServerAlchemyService
function AlchemyService.new(diContainer)
    return setmetatable(SharedAlchemyService.new(diContainer), AlchemyService)
end

function AlchemyService:init()
    ---@type ServerInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    self.playerRepository = infrastructure.repositories.playerRepository
    SharedAlchemyService.init(self)

end

---@param data table
function AlchemyService:tryBrew(data)
    local playerEntity = self.playerRepository:getPlayerEntity(data.player)
    if not self:checkRecipe(playerEntity.inventory, data.recipe) then
        return false
    end
    
    self:removeIngredients(playerEntity, data.recipe)
    self:addPotion(playerEntity, data.potion)
    return true
end

---@param playerEntity PlayerEntity
---@param recipe table
function AlchemyService:removeIngredients(playerEntity, recipe)
    for itemName, amount in recipe do
        playerEntity.inventory[itemName] = playerEntity.inventory[itemName] - amount
    end
end

---@param playerEntity PlayerEntity
---@param potion table
function AlchemyService:addPotion(playerEntity, potion)
    playerEntity.inventory[potion.name] = playerEntity.inventory[potion.name] + 1
end

return AlchemyService