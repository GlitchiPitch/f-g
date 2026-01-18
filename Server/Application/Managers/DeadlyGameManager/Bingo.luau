--[[
    the player must find numbers in 24 unlit rooms with 9 torches, the goal is to collect bingo
]]
---@class Bingo
local Bingo = {}
Bingo.__index = Bingo

---@param diContainer DIContainer
---@return Bingo
function Bingo.new(diContainer)
	local self = setmetatable({}, Bingo)
	self.diContainer = diContainer
	return self
end

return Bingo