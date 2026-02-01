---@class ServerQuestController
local QuestController = {}
QuestController.__index = QuestController

---@param diContainer DIContainer
---@return ServerQuestController
function QuestController.new(diContainer)
	local self = setmetatable({}, QuestController)
	self.diContainer = diContainer
	return self
end

function QuestController:init()
end

function QuestController:update(deltaTime)
end

return QuestController