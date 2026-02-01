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
    error("must be implemented in subclass")
end

return QuestRepository