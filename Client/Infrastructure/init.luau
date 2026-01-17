---@class ClientInfrastructure
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@return ClientInfrastructure
function Infrastructure.new()
	local self = setmetatable({}, Infrastructure)
	return self
end

return Infrastructure