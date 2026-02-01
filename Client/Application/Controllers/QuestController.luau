---@class ClientQuestController
local QuestController = {}
QuestController.__index = QuestController

---@param diContainer DIContainer
---@return ClientQuestController
function QuestController.new(diContainer)
	local self = setmetatable({}, QuestController)
	self.diContainer = diContainer
	self.pendingQuests = nil
	return self
end

function QuestController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")

	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.questService = application.services.questService
	self.questUI = presentation.ui.questUI
	self.pendingQuests = self.questService:getQuests()

	self.eventBus:connect(self.constants.REMOTE_EVENTS.QUEST_UPDATED, function(eventData)
		self.pendingQuests = eventData.quests or {}
		if self:_isUiReady() then
			self.questUI:render(self.pendingQuests)
			self.pendingQuests = nil
		end
	end)
end

function QuestController:update()
	if self.pendingQuests and self:_isUiReady() then
		self.questUI:render(self.pendingQuests)
		self.pendingQuests = nil
	end
end

---@return boolean
function QuestController:_isUiReady()
	return self.questUI and self.questUI.questContainer ~= nil
end

return QuestController
