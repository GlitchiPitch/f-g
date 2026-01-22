local _BaseUI = require(script.Parent._BaseUI)

---@class _CraftableUI : _BaseUI
---@field diContainer DIContainer
---@field mainUI ScreenGui
local _CraftableUI = setmetatable({}, _BaseUI)
_CraftableUI.__index = _CraftableUI

---@param diContainer DIContainer
---@return _CraftableUI
function _CraftableUI.new(diContainer)
	local self = setmetatable(_BaseUI.new(diContainer), _CraftableUI)
	self.closePosition = UDim2.fromScale(-1, 0.5)
	self.openPosition = UDim2.fromScale(0, 0.5)
	return self
end

function _CraftableUI:init(mode)
	_BaseUI.init(self)

	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")

	self.mode = mode
	self.ingredientsFrame = self.mainUI.IngredientsFrame
	self.inventoryUI = presentation.ui.inventoryUI

	self.ingredientsFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true)
	
end

function _CraftableUI:close()

	self.ingredientsFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true)
	self.inventoryUI:setMode("inventory")
	self.inventoryUI:close()
end

function _CraftableUI:open()
	self.ingredientsFrame:TweenPosition(self.openPosition, "Out", "Quint", 1, true)
	self.inventoryUI:setMode(self.mode)
	self.inventoryUI:open()
end

return _CraftableUI
