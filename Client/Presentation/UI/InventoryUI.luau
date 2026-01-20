---@class InventoryUI
---@field diContainer DIContainer
---@field isOpen boolean
---@field mainFrame Frame
---@field player Player
---@field character Model
---@field items Tool[]
---@field _equippedItem Tool | nil
---@field buttons table<TextButton, RBXScriptConnection>
---@field useCases ClientUseCases
---@field alchemyService ClientAlchemyService
---@field _mode "inventory" | "alchemy" | "crafting"
local InventoryUI = {}

InventoryUI.__index = InventoryUI

---@param diContainer DIContainer
---@return InventoryUI
function InventoryUI.new(diContainer)
	local self = setmetatable({}, InventoryUI)
	self.diContainer = diContainer
	self.isOpen = false
	self.closePosition = UDim2.fromScale(2, 0)
	self.openPosition = UDim2.fromScale(1, 0)
	self.items = {}
	self.buttons = {}
	self._equippedItem = nil

	self._mode = "inventory"
	return self
end

function InventoryUI:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	local playerService = application.services.playerService
	local inventoryUI = playerService.player.PlayerGui:WaitForChild("InventoryUI")
	self.useCases = application.useCases
	self.alchemyService = application.services.alchemyService

	self.mainFrame = inventoryUI.Main
	self.player = playerService.player
	self.character = self.player.Character
	self.handler = self.mainFrame.Handler
	self.itemTemplate = self.handler.Template

	-- Disable the default backpack GUI
	-- game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

	-- Initialize inventory refresh
	self:backpackRefresh()
end

function InventoryUI:_refresh()
	-- Create new buttons for each item
	for i, item in self.items do
		local button = self.itemTemplate:Clone() :: ImageButton
		button.Name = item.Name
		button.LayoutOrder = i
		button.Visible = true
		button.Parent = self.handler
		button.Image = item.TextureId

		if item == self._equippedItem then
			button.BackgroundColor3 = Color3.fromRGB(28, 135, 42)
		end

		self.buttons[button] = button.MouseButton1Click:Connect(function()
			if self._mode == "alchemy" then
				self.alchemyService:addItemToAlchemy(item)
			elseif self._mode == "inventory" then
				self.useCases:equipItem(item)
			end
		end)
	end
end

---@param mode "inventory" | "alchemy" | "crafting"
function InventoryUI:setMode(mode)
	self._mode = mode
end

function InventoryUI:backpackRefresh()
	self:_clear()

	if self.character then
		self._equippedItem = self.character:FindFirstChildOfClass("Tool")
		if self._equippedItem then
			table.insert(self.items, self._equippedItem)
		end
	end

	for _, child in self.player.Backpack:GetChildren() do
		table.insert(self.items, child)
	end

	self:_refresh()
end

function InventoryUI:open()
	self.mainFrame:TweenPosition(self.openPosition, "Out", "Quint", 1, true) -- Same X Position, Change Y's Scale to negative then change Y's Offset to negative the size of the frame in y
	self.isOpen = true
end

function InventoryUI:close()
	self.mainFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true) -- Same X Position, Change Y's Scale to negative then change Y's Offset to negative the size of the frame in y
	self.isOpen = false
end

function InventoryUI:_clear()
	for button, buttonConnect in self.buttons do
		buttonConnect:Disconnect()
		button:Destroy()
	end

	self.buttons = {}
	self.items = {}
	self._equippedItem = nil
end

return InventoryUI
