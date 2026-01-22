local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedCraftService = require(ReplicatedStorage.Shared.Application.Services.CraftService)

---@class ServerCraftService : SharedCraftService
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field items table<number, table>
local CraftService = setmetatable({}, SharedCraftService)
CraftService.__index = CraftService

---@param diContainer DIContainer
---@return ServerCraftService
function CraftService.new(diContainer)
	local self = setmetatable(SharedCraftService.new(diContainer), CraftService)
	self.items = {}
	return self
end

function CraftService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository
	self.weaponRepository = shared.infrastructure.repositories.weaponRepository
	self.itemRepository = shared.infrastructure.repositories.itemRepository
	SharedCraftService.init(self)
end

---@param data table
function CraftService:tryCraft(data)
	local playerEntity = self.playerRepository:getPlayerEntity(data.player)
	local resultItem = self:checkRecipe(self.items[playerEntity.player.UserId])
	warn("resultItem", resultItem, data, self.items[playerEntity.player.UserId])
	if not resultItem then
		resultItem = self.itemRepository:getItemAsset("Poop")
	end

	self:addItem(playerEntity, resultItem)

	self:clearItems(playerEntity)
	return true
end

---@param playerEntity PlayerEntity
---@param item Tool
function CraftService:addItem(playerEntity, item)
	playerEntity:addItemToInventory(item)
end

---@param playerEntity PlayerEntity
---@param item Tool
function CraftService:addItemForCrafting(playerEntity, item)
	if not self.items[playerEntity.player.UserId] then
		self.items[playerEntity.player.UserId] = {}
	end

	table.insert(self.items[playerEntity.player.UserId], item.Name)
	playerEntity:removeItemFromInventory(item.Name)
	warn(playerEntity.player.Backpack:GetChildren())
	return true
end

---@param playerEntity PlayerEntity
function CraftService:clearItems(playerEntity)
	self.items[playerEntity.player.UserId] = nil
end

---@param playerEntity PlayerEntity
function CraftService:resetCraft(playerEntity)
	for _, itemName in self.items[playerEntity.player.UserId] do
		local item = self.itemRepository:getItemAsset(itemName)
		playerEntity:addItemToInventory(item)
	end
	
	self.items[playerEntity.player.UserId] = nil
end

return CraftService
