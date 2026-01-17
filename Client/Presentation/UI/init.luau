local Debris = game:GetService("Debris")
---@class UI
---@field diContainer DIContainer
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return UI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	self.diContainer = diContainer
	return self
end

function UI:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.mainUI = application.services.playerService.player.PlayerGui:WaitForChild("MainUI")
	self.notification = self.mainUI.Notification
end

function UI:showNotification(message)
	local label = self.notification.TextLabel:Clone()
	label.Parent = self.notification
	label.Visible = true
	label.Text = `start hunting to {message}`
	Debris:AddItem(label, 5)
end

return UI
