local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local InventoryUI = require(script.InventoryUI)
---@class UI
---@field diContainer DIContainer
---@field foodPopup Frame
---@field playerService ClientPlayerService
---@field alchemyService ClientAlchemyService
---@field craftService ClientCraftService
---@field inventoryUI InventoryUI
---@field _secondActionButtonConn RBXScriptSignal
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return UI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	self.diContainer = diContainer
	self.inventoryUI = InventoryUI.new(self.diContainer)
	self._secondActionButtonConn = nil
	return self
end

function UI:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")

	self.alchemyService = application.services.alchemyService
	self.craftService = application.services.craftService

	self.mainUI = application.services.playerService.player.PlayerGui:WaitForChild("MainUI")
	self.diedUI = application.services.playerService.player.PlayerGui:WaitForChild("DiedUI")
	self.diedFrame = self.diedUI.Frame
	self.actionButton = self.mainUI.ActionButton
	self.secondActionButton = self.mainUI.SecondActionButton

	self.notification = self.mainUI.Notification
	self.foodPopup = self.mainUI.FoodPopup
	self.playerService = application.services.playerService

	self.inventoryUI:init()
end

function UI:showNotification(message)
	local label = self.notification.TextLabel:Clone()
	label.Parent = self.notification
	label.Visible = true
	label.Text = message
	Debris:AddItem(label, 5)
end

function UI:showFoodEaten()
	local foodPopup = self.foodPopup:Clone()
	foodPopup.Parent = self.mainUI
	foodPopup.Visible = true

	local tween = TweenService:Create(foodPopup, TweenInfo.new(3), {
		Position = UDim2.fromScale(0, 0.7),
	})

	tween.Completed:Connect(function()
		foodPopup:Destroy()
	end)

	tween:Play()
end

function UI:toggleDiedScreen(state)
	if state then
		self.diedFrame.Visible = true
		self.diedFrame.Transparency = 1
	end

	if state then
		local showTween = TweenService:Create(self.diedFrame, TweenInfo.new(2), {
			Transparency = 0,
		})

		showTween:Play()
	else
		local hideTween = TweenService:Create(self.diedFrame, TweenInfo.new(2), {
			Transparency = 1,
		})

		hideTween.Completed:Connect(function()
			self.diedFrame.Visible = false
			self.diedFrame.Transparency = 1
		end)
		hideTween:Play()
	end
end

function UI:toggleInventory()
	self.inventoryUI:toggle()
end

function UI:refreshInventory()
	self.inventoryUI:backpackRefresh()
end

function UI:toggleActionButton(state)
	if state then
		self.actionButton.Visible = true
	else
		self.actionButton.Visible = false
	end
end

function UI:toggleAlchemy(state)
	if self._secondActionButtonConn then
		self._secondActionButtonConn:Disconnect()
		self._secondActionButtonConn = nil
	end

	if state then
		self.inventoryUI:setMode("alchemy")
		self.inventoryUI:open()
		self.secondActionButton.Visible = true
		self._secondActionButtonConn = self.secondActionButton.MouseButton1Click:Connect(function()
			self.alchemyService:tryBrew()
			
		end)
	else
		self.inventoryUI:setMode("inventory")
		self.inventoryUI:close()
		self.secondActionButton.Visible = false
	end
end

function UI:toggleCraft(state)
	if self._secondActionButtonConn then
		self._secondActionButtonConn:Disconnect()
		self._secondActionButtonConn = nil
	end

	if state then
		self.inventoryUI:setMode("craft")
		self.inventoryUI:open()
		self.secondActionButton.Visible = true
		self._secondActionButtonConn = self.secondActionButton.MouseButton1Click:Connect(function()
			self.craftService:tryCraft()
		end)
	else
		self.inventoryUI:setMode("inventory")
		self.inventoryUI:close()
		self.secondActionButton.Visible = false
	end
end

return UI
