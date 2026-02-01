local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedQuestRepository = require(ReplicatedStorage.Shared.Infrastructure.Repositories.BaseQuestRepository)

---@class ClientQuestRepository : BaseQuestRepository
local QuestRepository = setmetatable(SharedQuestRepository, {})
QuestRepository.__index = QuestRepository

---@param diContainer DIContainer
---@return ClientQuestRepository
function QuestRepository.new(diContainer)
	local self = setmetatable(SharedQuestRepository.new(diContainer), QuestRepository)
	return self
end

return QuestRepository
