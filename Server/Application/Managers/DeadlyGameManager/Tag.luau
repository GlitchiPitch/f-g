--[[
    if a single player is in the game, an NPC appears who must kill the player
    The player's task is to find an open room in the building within a time limit.
    Onve the time limit expires, the entire building explodes.

    if there are multiple players, they are divided into two teams: hunters and survivors
]]

---@class Tag
local Tag = {}
Tag.__index = Tag

---@param diContainer DIContainer
---@return Tag
function Tag.new(diContainer)
	local self = setmetatable({}, Tag)
	self.diContainer = diContainer
	return self
end

return Tag