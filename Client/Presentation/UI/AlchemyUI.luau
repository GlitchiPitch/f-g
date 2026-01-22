local _CraftableUI = require(script.Parent._CraftableUI)

---@class AlchemyUI : _CraftableUI
local AlchemyUI = setmetatable({}, _CraftableUI)
AlchemyUI.__index = AlchemyUI

---@return AlchemyUI
function AlchemyUI.new(diContainer)
	local self = setmetatable(_CraftableUI.new(diContainer), AlchemyUI)
	return self
end

function AlchemyUI:init()
	_CraftableUI.init(self, "alchemy")
end


return AlchemyUI
