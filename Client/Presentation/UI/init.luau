local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local InventoryUI = require(script.InventoryUI)
local RecipeUI = require(script.RecipeUI)
local AlchemyUI = require(script.AlchemyUI)
local CraftUI = require(script.CraftUI)
local ShopUI = require(script.ShopUI)	
---@class UI
---@field diContainer DIContainer
---@field foodPopup Frame
---@field playerService ClientPlayerService
---@field alchemyService ClientAlchemyService
---@field craftService ClientCraftService
---@field inventoryUI InventoryUI
---@field recipeUI RecipeUI
---@field alchemyUI AlchemyUI
---@field craftUI CraftUI
---@field shopUI ShopUI
---@field _secondActionButtonConn RBXScriptSignal
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return UI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	self.diContainer = diContainer
	self.inventoryUI = InventoryUI.new(self.diContainer)
	self.recipeUI = RecipeUI.new(self.diContainer)
	self.alchemyUI = AlchemyUI.new(self.diContainer)
	self.craftUI = CraftUI.new(self.diContainer)
	self.shopUI = ShopUI.new(self.diContainer)
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
	self.recipeUI:init()
	self.craftUI:init()
	self.alchemyUI:init()
	self.shopUI:init()
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
		self.alchemyUI:open()
		self.secondActionButton.Visible = true
		self._secondActionButtonConn = self.secondActionButton.MouseButton1Click:Connect(function()
			self.alchemyService:tryBrew()
		end)
	else
		self.alchemyUI:close()
		self.secondActionButton.Visible = false
	end
end

function UI:toggleCraft(state)
	if self._secondActionButtonConn then
		self._secondActionButtonConn:Disconnect()
		self._secondActionButtonConn = nil
	end

	if state then
		self.craftUI:open()
		self.secondActionButton.Visible = true
		self._secondActionButtonConn = self.secondActionButton.MouseButton1Click:Connect(function()
			self.craftService:tryCraft()
		end)
	else
		self.craftUI:close()
		self.secondActionButton.Visible = false
	end
end

function UI:toggleRecipe(recipe)
	self.recipeUI:toggle(recipe)
end

function UI:addItemForCrafting(item)
	self.craftUI:addItem(item)
end

function UI:addItemForBrewing(item)
	self.alchemyUI:addItem(item)
end

function UI:resetCrafting()
	self.craftUI:clearItems()
end

---@param state boolean
function UI:toggleShop(state)
	if state then
		self.shopUI:open()
	else
		self.shopUI:close()
	end
end

return UI
