--[[
    several rooms with two doors in each room
    players should move to one door
    the timer is running
]]

---@class DeadOrAlive
local DeadOrAlive = {}
DeadOrAlive.__index = DeadOrAlive

---@param diContainer DIContainer
---@return DeadOrAlive
function DeadOrAlive.new(diContainer)
	local self = setmetatable({}, DeadOrAlive)
	self.diContainer = diContainer
	return self
end

function DeadOrAlive:init()
    
end

function DeadOrAlive:update()
end

function DeadOrAlive:start()
end

function DeadOrAlive:stop()
end

function DeadOrAlive:destroy()
end

return DeadOrAlive