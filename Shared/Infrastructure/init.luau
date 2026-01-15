local DIContainer = require(script.DIContainer)
local Services = require(script.Services)

---@class Infrastructure
---@field diContainer DIContainer
---@field services Services
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@return Infrastructure
function Infrastructure.new()
	local self = setmetatable({}, Infrastructure)
	self.diContainer = DIContainer.new()
	self.services = Services.new()
	return self
end

return Infrastructure
