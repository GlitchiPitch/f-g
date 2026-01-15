---@class Services
---@field diContainer DIContainer
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return Services
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.diContainer = diContainer
	return self
end

function Services:init()
end

return Services
