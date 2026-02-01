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
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	self.questService = application.services.questService
end

function QuestController:update(deltaTime)
	if self.questService then
		self.questService:tick(deltaTime)
	end
end

return QuestController
