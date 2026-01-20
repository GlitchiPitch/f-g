---@class InventoryUI
---@field diContainer DIContainer
---@field isOpen boolean
---@field mainFrame Frame
---@field player Player
---@field character Model
---@field items table
---@field buttons table
---@field _equippedItem Tool | nil
---@field _selectedItem Tool | nil
local InventoryUI = {}

InventoryUI.__index = InventoryUI

---@param diContainer DIContainer
---@return InventoryUI
function InventoryUI.new(diContainer)
	local self = setmetatable({}, InventoryUI)
	self.diContainer = diContainer
	self.isOpen = false
	self.closePosition = UDim2.fromScale(1.95, 0.05)
	self.openPosition = UDim2.fromScale(0.95, 0.05)
	self.items = {}
	self.buttons = {}
	self._equippedItem = nil
	self._selectedItem = nil
	return self
end

function InventoryUI:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	local playerService = application.services.playerService
	local inventoryUI = playerService.player.PlayerGui:WaitForChild("InventoryUI")
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

function InventoryUI:search(location)
	for _, child in pairs(location:GetChildren()) do
		if child:IsA("Tool") then
			table.insert(self.items, child)
		end
	end
end

function InventoryUI:refresh()
	-- Destroy existing buttons
	for _, button in pairs(self.buttons) do
		button:Destroy()
	end
	self.buttons = {}

	-- Create new buttons for each item
	for i, item in pairs(self.items) do
		local button = self.itemTemplate:Clone()
		button.Name = item.Name
		button.LayoutOrder = i
        button.Visible = true
		button.Parent = self.handler
		button.Image = item.TextureId
		table.insert(self.buttons, button)

		button.MouseButton1Click:Connect(function()
			if self.handler.Selected.Value == nil or self.handler.Selected.Value ~= item then
				self.mainFrame.Frame.ItemName.Text = item.Name
				self.mainFrame.Frame.ImageLabel.Image = item.TextureId
				self.handler.Selected.Value = item

				if self.handler.Selected.Value ~= self.handler.Equipped.Value then
					self.handler.Location.Value = item.Parent
					self.mainFrame.Frame.Equip.Text = "Equip"
				elseif self.handler.Selected.Value == self.handler.Equipped.Value then
					self.handler.Location.Value = item.Parent
					self.handler.Equip.Text = "Unequip"
				end
			end
		end)
	end
end

function InventoryUI:backpackRefresh()
	self.items = {}
	if self.character then
		self:search(self.character)
	end
	self:search(self.player.Backpack)
	self:refresh()
end

function InventoryUI:update() end

function InventoryUI:open()
	self.mainFrame:TweenPosition(self.openPosition, "Out", "Quint", 1, true) -- Same X Position, Change Y's Scale to negative then change Y's Offset to negative the size of the frame in y
	self.isOpen = true
end

function InventoryUI:close()
	self.mainFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true) -- Same X Position, Change Y's Scale to negative then change Y's Offset to negative the size of the frame in y
	self.isOpen = false
end

return InventoryUI
