---@class ClientQuestController
local QuestController = {}
QuestController.__index = QuestController

---@param diContainer DIContainer
---@return ClientQuestController
function QuestController.new(diContainer)
	local self = setmetatable({}, QuestController)
	self.diContainer = diContainer
	return self
end

function QuestController:init() end

function QuestController:update() end

return QuestController
