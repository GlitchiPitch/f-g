local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedAlchemyService = require(ReplicatedStorage.Shared.Application.Services.AlchemyService)

---@class ServerAlchemyService : SharedAlchemyService
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field items table<number, table>
local AlchemyService = setmetatable({}, SharedAlchemyService)
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return ServerAlchemyService
function AlchemyService.new(diContainer)
	local self = setmetatable(SharedAlchemyService.new(diContainer), AlchemyService)
	self.items = {}
	return self
end

function AlchemyService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository
	self.potionRepository = shared.infrastructure.repositories.potionRepository
    self.itemRepository = shared.infrastructure.repositories.itemRepository
	SharedAlchemyService.init(self)
end

---@param data table
function AlchemyService:tryBrew(data)
	local playerEntity = self.playerRepository:getPlayerEntity(data.player)
	local resultPotion = self:checkRecipe(self.items[playerEntity.player.UserId])
	if not resultPotion then
		resultPotion = self.itemRepository:getItemAsset("Poop")
	end

	self:addPotion(playerEntity, resultPotion)

    self:clearItems(playerEntity)
	return true
end

---@param playerEntity PlayerEntity
---@param potion Tool
function AlchemyService:addPotion(playerEntity, potion)
	playerEntity:addItemToInventory(potion)
end

---@param playerEntity PlayerEntity
---@param item Tool
function AlchemyService:addItemForBrewing(playerEntity, item)
    if not self.items[playerEntity.player.UserId] then
        self.items[playerEntity.player.UserId] = {}
    end

	table.insert(self.items[playerEntity.player.UserId], item.Name)
    playerEntity:removeItemFromInventory(item.Name)
    return true
end

---@param playerEntity PlayerEntity
function AlchemyService:clearItems(playerEntity)
	self.items[playerEntity.player.UserId] = nil
end

---@param playerEntity PlayerEntity
---@param potion Tool
function AlchemyService:drinkPotion(playerEntity, potion)
	playerEntity:removeItemFromInventory(potion.Name)
	local potionData = self.potionRepository:getPotionData(potion.Name)
	if potionData then
		for _, bonus in potionData.bonus do
			playerEntity:addBonus(bonus)
		end
	end
end

return AlchemyService
