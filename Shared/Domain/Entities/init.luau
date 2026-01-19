---@class Entities
---@field Player PlayerEntity
---@field Farmer FarmerEntity
---@field Enemy EnemyEntity
local Entities = {}
Entities.__index = Entities

---@return Entities
function Entities.new()
	local self = setmetatable({}, Entities)
	self.Player = require(script.Player)
	self.Farmer = require(script.Farmer)
	self.Enemy = require(script.Enemy)
	return self
end

return Entities
