---@class ServerCraftService
local CraftService = {}
CraftService.__index = CraftService

---@param diContainer DIContainer
---@return ServerCraftService
function CraftService.new(diContainer)
	local self = setmetatable({}, CraftService)
	self.diContainer = diContainer
	return self
end

function CraftService:init()
end

---@param data table
function CraftService:tryCraft(data)
	print(`Try craft by {data.player.Name}`)
	return true, "Craft successful"
end

return CraftService