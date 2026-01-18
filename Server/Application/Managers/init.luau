---@class ServerManagers
---@field diContainer DIContainer
local Managers = {}
Managers.__index = Managers

---@param diContainer DIContainer
---@return ServerManagers
function Managers.new(diContainer)
	local self = setmetatable({}, Managers)
	self.diContainer = diContainer
	return self
end

function Managers:init()
end



return Managers