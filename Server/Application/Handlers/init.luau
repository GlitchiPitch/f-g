---@class ServerHandlers
local Handlers = {}     
Handlers.__index = Handlers

---@param diContainer DIContainer
---@return ServerHandlers
function Handlers.new(diContainer)
	local self = setmetatable({}, Handlers)
	self.diContainer = diContainer
	return self
end

function Handlers:init()
end

return Handlers