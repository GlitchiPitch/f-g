local _BaseUI = require(script.Parent._BaseUI)

---@class _CraftableUI : _BaseUI
---@field diContainer DIContainer
---@field actionButton ImageButton
---@field ingredientsFrame Frame
---@field inventoryUI InventoryUI
---@field ingerientsContainer Frame
---@field ingerientsTemplate ImageButton
---@field craftService ClientCraftService
---@field _actionButtonConnect RBXScriptSignal
---@field mainUI ScreenGui
---@field mode string
local _CraftableUI = setmetatable({}, _BaseUI)
_CraftableUI.__index = _CraftableUI

---@param diContainer DIContainer
---@return _CraftableUI
function _CraftableUI.new(diContainer)
	local self = setmetatable(_BaseUI.new(diContainer), _CraftableUI)
	self.closePosition = UDim2.fromScale(-1, 0.5)
	self.openPosition = UDim2.fromScale(0, 0.5)
	self._actionButtonConnect = nil
	return self
end

function _CraftableUI:init(mode)
	_BaseUI.init(self)

	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.craftService = application.services.craftService
	self.mode = mode
	self.ingredientsFrame = self.mainUI.IngredientsFrame
	self.inventoryUI = presentation.ui.inventoryUI
	self.ingerientsContainer = self.ingredientsFrame.Handler
	self.ingerientsTemplate = self.ingerientsContainer.Template
	self.actionButton = self.ingredientsFrame.ActionButton
	self.ingredientsFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true)
end

function _CraftableUI:close()
	if self._actionButtonConnect then
		self._actionButtonConnect:Disconnect()
	end

	self.actionButton.Visible = false
	self.ingredientsFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true)
	
	self.inventoryUI:setMode("inventory")
	self.inventoryUI:close()
	self:clearItems()
end

function _CraftableUI:clearItems()
	for _, child in self.ingerientsContainer:GetChildren() do
		if child:IsA("ImageButton") and child.Name ~= "Template" then
			child:Destroy()
		end
	end
end

---@param item Tool
function _CraftableUI:addItem(item)
    local itemButton = self.ingerientsTemplate:Clone()
	itemButton.Name = item.Name
	itemButton.Image = item.TextureId
	itemButton.Parent = self.ingerientsContainer
	itemButton.Visible = true
end
function _CraftableUI:open()
	self.ingredientsFrame:TweenPosition(self.openPosition, "Out", "Quint", 1, true)
	self.inventoryUI:setMode(self.mode)
	self.inventoryUI:open()

	if self.mode == "craft" then
		self.actionButton.Visible = true
		self._actionButtonConnect = self.actionButton.MouseButton1Click:Connect(function()
			self.craftService:resetCraft()
		end)
	end
end

return _CraftableUI
