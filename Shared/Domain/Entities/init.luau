---@class Entities
---@field Player PlayerEntity
---@field Farmer FarmerEntity
local Entities = {}
Entities.__index = Entities

---@return Entities
function Entities.new()
	local self = setmetatable({}, Entities)
	self.Player = require(script.Player)
	self.Farmer = require(script.Farmer)
	return self
end

return Entities
