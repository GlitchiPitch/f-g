--[[
    a room is filling with water, and behind oner door is a light bulb.
    thr qeustion is, which of the three tumblers turns on the bulb?
    while the door is closed, the tumblers can be toggled without limitsm but only once the dorr is open.
    entering the room woth the bulb is prohibited. the game continues until the water touches the live wires.
    
]]

---@class Lamp
local Lamp = {}
Lamp.__index = Lamp

---@param diContainer DIContainer
---@return Lamp
function Lamp.new(diContainer)
	local self = setmetatable({}, Lamp)
	self.diContainer = diContainer
	return self
end

return Lamp