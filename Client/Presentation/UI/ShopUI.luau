local _BaseUI = require(script.Parent._BaseUI)

---@class ShopUI : _BaseUI
---@field shopService ClientShopService
local ShopUI = setmetatable({}, _BaseUI)
ShopUI.__index = ShopUI

---@return ShopUI
function ShopUI.new(diContainer)
	local self = setmetatable(_BaseUI.new(diContainer), ShopUI)
	self.closePosition = UDim2.fromScale(0.5, 2)
	self.openPosition = UDim2.fromScale(0.5, 1)
	return self
end

function ShopUI:init()
	_BaseUI.init(self)

    ---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.shopService = application.services.shopService

	self.shopFrame = self.mainUI.Shop
	self.closeButton = self.shopFrame.CloseButton
	self.shopContainer = self.shopFrame.Handler
	self.shopTemplate = self.shopContainer.Template

	self:_setup()
end

function ShopUI:open()
    warn("open")
	self.shopFrame:TweenPosition(self.openPosition, "Out", "Quint", 1, true)
end

function ShopUI:close()
	self.shopFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true)
end

function ShopUI:_setup()
	self.closeButton.MouseButton1Click:Connect(function()
		self.shopService:closeShop()
	end)
end

return ShopUI
