---@class ClientQuestService
local QuestService = {}
QuestService.__index = QuestService

---@param diContainer DIContainer
---@return ClientQuestService
function QuestService.new(diContainer)
	local self = setmetatable({}, QuestService)
	self.diContainer = diContainer
	self.quests = {}
	return self
end

function QuestService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
end

---@param eventData table
function QuestService:onQuestUpdated(eventData)
	self.quests = eventData.data.quests or {}
	self.eventBus:fire(self.constants.REMOTE_EVENTS.QUEST_UPDATED, {
		quests = self.quests,
	})
end

---@return table
function QuestService:getQuests()
	return self.quests
end

return QuestService
