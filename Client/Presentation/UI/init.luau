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

function UI:showDiedScreen()
	self.diedFrame.Visible = true
	self.diedFrame.Transparency = 1

	local showTween = TweenService:Create(self.diedFrame, TweenInfo.new(2), {
		Transparency = 0,
	})
	showTween.Completed:Connect(function()
		local hideTween = TweenService:Create(self.diedFrame, TweenInfo.new(2), {
			Transparency = 1,
		})
		
		hideTween.Completed:Connect(function()
			self.diedFrame.Visible = false
			self.diedFrame.Transparency = 1
		end)
		hideTween:Play()
	end)
	showTween:Play()
end

return UI
