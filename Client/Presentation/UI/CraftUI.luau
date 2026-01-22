local _CraftableUI = require(script.Parent._CraftableUI)

---@class CraftUI : _CraftableUI
local CraftUI = setmetatable({}, _CraftableUI)
CraftUI.__index = CraftUI

---@return CraftUI
function CraftUI.new(diContainer)
	local self = setmetatable(_CraftableUI.new(diContainer), CraftUI)
	return self
end

function CraftUI:init()
	_CraftableUI.init(self, "craft")
end

return CraftUI
