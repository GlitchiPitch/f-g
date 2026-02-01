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

end

function QuestUI:open()
	self.mainFrame:TweenPosition(self.openPosition, "Out", "Quint", 1, true)
	self.questButton.Visible = false
end

function QuestUI:close()
	self.mainFrame:TweenPosition(self.closePosition, "Out", "Quint", 1, true)
	self.questButton.Visible = true
end

function QuestUI:_fillQuests()
    --[[

    ]]
end

return QuestUI
