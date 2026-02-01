---@class BaseQuestRepository
---@field diContainer DIContainer
local QuestRepository = {}
QuestRepository.__index = QuestRepository

---@param diContainer DIContainer
---@return BaseQuestRepository
function QuestRepository.new(diContainer)
	local self = setmetatable({}, QuestRepository)
	self.diContainer = diContainer
	return self
end

function QuestRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.questData = shared.data.Quest
end

---@return QuestDefinition[]
function QuestRepository:getQuests()
	return self.questData
end

---@param questId string
---@return QuestDefinition?
function QuestRepository:getQuestById(questId)
	for _, quest in self.questData do
		if quest.id == questId then
			return quest
		end
	end

	return nil
end

return QuestRepository