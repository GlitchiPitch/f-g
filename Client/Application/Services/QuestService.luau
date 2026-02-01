---@class ClientQuestService
local QuestService = {}
QuestService.__index = QuestService

---@param diContainer DIContainer
---@return ClientQuestService
function QuestService.new(diContainer)
	local self = setmetatable({}, QuestService)
	self.diContainer = diContainer
	return self
end

function QuestService:init()
end

return QuestService