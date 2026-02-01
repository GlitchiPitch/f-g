---@class ServerQuestService
local QuestService = {}
QuestService.__index = QuestService

---@param diContainer DIContainer
---@return ServerQuestService
function QuestService.new(diContainer)
	local self = setmetatable({}, QuestService)
	self.diContainer = diContainer
	return self
end

function QuestService:init()
end

return QuestService