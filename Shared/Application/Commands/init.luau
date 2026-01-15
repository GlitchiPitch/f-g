---@class Commands
local Commands = {}
Commands.__index = Commands

---@return Commands
function Commands.new()
	local self = setmetatable({}, Commands)
	return self
end

return Commands
