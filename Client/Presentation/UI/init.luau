local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
---@class UI
---@field diContainer DIContainer
---@field foodPopup Frame
---@field playerService ClientPlayerService
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
	self.diedUI = application.services.playerService.player.PlayerGui:WaitForChild("DiedUI")
	self.diedFrame = self.diedUI.Frame

	self.notification = self.mainUI.Notification
	self.foodPopup = self.mainUI.FoodPopup
	self.playerService = application.services.playerService
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

---@param state boolean
function UI:showDiedScreen(state)
	if not state then
		self.diedUI.Enabled = state
	end

	if state then
		local tween = TweenService:Create(self.diedFrame, TweenInfo.new(2), {
			Transparency = 1,
		})
		tween:Play()
	else
		local tween = TweenService:Create(self.diedFrame, TweenInfo.new(2), {
			Transparency = 0,
		})
		tween.Completed:Connect(function()
			self.diedUI.Enabled = state
		end)
		tween:Play()
	end
end

return UI
