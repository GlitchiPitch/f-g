---@class ClientAppServices
---@field diContainer DIContainer
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.diContainer = diContainer
	return self
end

function Services:init() end

return Services
