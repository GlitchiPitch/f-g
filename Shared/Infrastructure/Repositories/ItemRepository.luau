---@class SharedItemRepository
---@field diContainer DIContainer
---@field data ItemsData
local ItemRepository = {}
ItemRepository.__index = ItemRepository

---@param diContainer DIContainer
---@return SharedItemRepository
function ItemRepository.new(diContainer)
	local self = setmetatable({}, ItemRepository)
	self.diContainer = diContainer
	return self
end

function ItemRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.data = shared.data.Items
end

---@return ItemsData
function ItemRepository:getAllItemsData()
    return self.data
end

---@param itemName string
---@return ItemData?
function ItemRepository:getItemData(itemName)
    return self.data[itemName]
end

---@param itemName string
---@return Tool?
function ItemRepository:getItemAsset(itemName)
	local itemData = self:getItemData(itemName)
	if not itemData then
		return
	end

	return itemData.model:Clone()
end

return ItemRepository