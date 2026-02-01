local _BaseUI = require(script.Parent._BaseUI)

---@class QuestUI : _BaseUI
local QuestUI = setmetatable({}, _BaseUI)
QuestUI.__index = QuestUI

---@param diContainer DIContainer
---@return QuestUI
function QuestUI.new(diContainer)
	local self = setmetatable(_BaseUI.new(diContainer), QuestUI)

	self.closePosition = UDim2.fromScale(2, 0)
	self.openPosition = UDim2.fromScale(1, 0)
	return self
end

function QuestUI:init()
	_BaseUI.init(self)

	self.mainFrame = self.mainUI.Quest
	self.closeButton = self.mainFrame.CloseButton
	self.questButton = self.mainUI.QuestButton

	self.questContainer = self.mainFrame.Handler
	self.questTemplate = self.questContainer.Template
	self.quests = {}
	self:_setup()
end

function QuestUI:open()
	self.mainFrame:TweenPosition(self.openPosition, "Out", "Quint", 1, true)
	self.questButton.Visible = false
end

function QuestUI:close()
	self.mainFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true)
	self.questButton.Visible = true
end

---@param quests table
function QuestUI:render(quests)
	self.quests = quests or {}
	self:_fillQuests(self.quests)
end

function QuestUI:_setup()
	self.questButton.MouseButton1Click:Connect(function()
		if self.isOpen then
			self:close()
		else
			self:open()
		end
		self.isOpen = not self.isOpen
	end)

	self.closeButton.MouseButton1Click:Connect(function()
		if self.isOpen then
			self:close()
			self.isOpen = false
		end
	end)
end

---@param quests table
function QuestUI:_fillQuests(quests)
	for _, child in self.questContainer:GetChildren() do
		if child:IsA("ImageButton") and child.Name ~= "Template" then
			child:Destroy()
		end
	end

	for _, quest in quests do
		local questFrame = self.questTemplate:Clone()
		local label = questFrame:FindFirstChildWhichIsA("TextLabel", true)
		if label then
			if quest.id == "kill_enemies" then
				label.Text = string.format("Kill enemies %d/%d.", quest.progress, quest.goal)
			elseif quest.id == "collect_food" then
				label.Text = string.format("Collect food %d/%d.", quest.progress, quest.goal)
			elseif quest.id == "play_time" then
				label.Text = string.format("Play time %d/%d sec.", quest.progress, quest.goal)
			else
				label.Text = string.format("%s %d/%d.", quest.name, quest.progress, quest.goal)
			end
		end
        
		questFrame.Name = quest.id or quest.name
		questFrame.Parent = self.questContainer
		questFrame.Visible = true
	end
end

return QuestUI
