---@class SharedItemsRepository
---@field diContainer DIContainer
---@field data ItemsData
local ItemsRepository = {}
ItemsRepository.__index = ItemsRepository

---@param diContainer DIContainer
---@return SharedItemsRepository
function ItemsRepository.new(diContainer)
	local self = setmetatable({}, ItemsRepository)
	self.diContainer = diContainer
	return self
end

function ItemsRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.data = shared.data.Items
end

---@return ItemsData
function ItemsRepository:getAllItems()
    return self.data
end

---@param itemName string
---@return ItemData?
function ItemsRepository:getItem(itemName)
    return self.data[itemName]
end

return ItemsRepository