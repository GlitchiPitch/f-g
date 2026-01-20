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
---@field craftService ClientCraftService
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
	self.craftService = application.services.craftService
	self.mainFrame = inventoryUI.Main
	self.player = playerService.player
	self.character = self.player.Character
	self.handler = self.mainFrame.Handler
	self.itemTemplate = self.handler.Template
	self.closeButton = self.mainFrame.CloseButton

	-- Disable the default backpack GUI
	-- game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

	-- Initialize inventory refresh

	self:_setup()
end

---@param mode "inventory" | "alchemy" | "craft"
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

function InventoryUI:_setup()
	self:backpackRefresh()
	
	self.closeButton.MouseButton1Click:Connect(function()
		if self._mode == "alchemy" then
			self.alchemyService:closeAlchemy()
		elseif self._mode == "craft" then
			self.craftService:closeCraft()
		elseif self._mode == "inventory" then
			self:close()
		end
	end)
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
				if self.alchemyService:addItemToAlchemy(item) then
					print("Item added to alchemy")
					button.Visible = false
				else
					print("Item not added to alchemy")
				end
			elseif self._mode == "craft" then
				if self.craftService:addItemToCraft(item) then
					print("Item added to craft")
					button.Visible = false
				else
					print("Item not added to craft")
				end
			elseif self._mode == "inventory" then
				self.useCases:equipItem(item)
			end
		end)
	end
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
