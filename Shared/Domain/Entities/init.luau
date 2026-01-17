---@class Entities
local Entities = {}
Entities.__index = Entities

---@return Entities
function Entities.new()
	local self = setmetatable({}, Entities)
	self.Player = require(script.Player)
	return self
end

return Entities
