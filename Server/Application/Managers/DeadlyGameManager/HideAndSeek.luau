--[[
    Only works for nultiple players. one player is a wolf, everyone else is a sheep.
    The on the wolf finds becomes the next wolf, and the winner is the one who remains a wolf at the end of the game
]]

---@class HideAndSeek
local HideAndSeek = {}
HideAndSeek.__index = HideAndSeek

---@param diContainer DIContainer
---@return HideAndSeek
function HideAndSeek.new(diContainer)
	local self = setmetatable({}, HideAndSeek)
	self.diContainer = diContainer
	return self
end

return HideAndSeek