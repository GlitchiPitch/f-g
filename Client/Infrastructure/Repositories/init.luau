local PlayerRepository = require(script.PlayerRepository)
local QuestRepository = require(script.QuestRepository)
---@class ClientRepositories
---@field playerRepository ClientPlayerRepository
---@field questRepository ClientQuestRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ClientRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.diContainer = diContainer
	self.playerRepository = PlayerRepository.new(diContainer)
	self.questRepository = QuestRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.playerRepository:init()
	self.questRepository:init()
end

return Repositories