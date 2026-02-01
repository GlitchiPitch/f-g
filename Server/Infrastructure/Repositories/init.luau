local PlayerRepository = require(script.PlayerRepository)
local QuestRepository = require(script.QuestRepository)
---@class ServerRepositories
---@field playerRepository ServerPlayerRepository
---@field questRepository ServerQuestRepository

local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ServerRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.playerRepository = PlayerRepository.new(diContainer)
	self.questRepository = QuestRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.playerRepository:init()
	self.questRepository:init()
end


return Repositories
