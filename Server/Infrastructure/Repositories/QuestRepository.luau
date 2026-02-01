local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedQuestRepository = require(ReplicatedStorage.Shared.Infrastructure.Repositories.BaseQuestRepository)

---@class ServerQuestRepository : BaseQuestRepository
local QuestRepository = setmetatable({}, SharedQuestRepository)
QuestRepository.__index = QuestRepository

---@param diContainer DIContainer
---@return ServerQuestRepository
function QuestRepository.new(diContainer)
	local self = setmetatable(SharedQuestRepository.new(diContainer), QuestRepository)
	return self
end

function QuestRepository:init()
	SharedQuestRepository.init(self)
end

return QuestRepository