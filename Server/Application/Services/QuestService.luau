---@class ServerQuestService
local QuestService = {}
QuestService.__index = QuestService

---@param diContainer DIContainer
---@return ServerQuestService
function QuestService.new(diContainer)
	local self = setmetatable({}, QuestService)
	self.diContainer = diContainer
	self.playerQuests = {}
	self.timeAccumulators = {}
	return self
end

function QuestService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.constants = shared.constants
	self.eventBus = shared.infrastructure.eventBus
	self.remoteEventService = shared.remoteEventService
	self.questRepository = infrastructure.repositories.questRepository
	self.players = game:GetService("Players")

	self:_setupPlayerListeners()
	self:_setupEventListeners()
end

function QuestService:_setupPlayerListeners()
	self.players.PlayerAdded:Connect(function(player)
		self:_initPlayerQuests(player.UserId)
		self.timeAccumulators[player.UserId] = 0
		self:_syncPlayerQuests(player.UserId)
	end)

	self.players.PlayerRemoving:Connect(function(player)
		self.playerQuests[player.UserId] = nil
		self.timeAccumulators[player.UserId] = nil
	end)

	for _, player in self.players:GetPlayers() do
		self:_initPlayerQuests(player.UserId)
		self.timeAccumulators[player.UserId] = 0
		self:_syncPlayerQuests(player.UserId)
	end
end

function QuestService:_setupEventListeners()
	self.eventBus:connect(self.constants.EVENTS.FOOD_EATEN, function(data)
		if data.playerEntity then
			self:_incrementQuest(data.playerEntity.player.UserId, "collect_food", 1)
		end
	end)

	self.eventBus:connect(self.constants.EVENTS.ENEMY_DIED, function(data)
		if data.lastDamagerUserId then
			self:_incrementQuest(data.lastDamagerUserId, "kill_enemies", 1)
		end
	end)
end

function QuestService:_initPlayerQuests(userId)
	if self.playerQuests[userId] then
		return
	end

	self.playerQuests[userId] = {}
	for _, quest in self.questRepository:getQuests() do
		self.playerQuests[userId][quest.id] = {
			id = quest.id,
			name = quest.name,
			description = quest.description,
			goal = quest.goal,
			progress = 0,
			completed = false,
			type = quest.type,
		}
	end
end

---@param userId number
---@param questId string
---@param amount number
function QuestService:_incrementQuest(userId, questId, amount)
	local questState = self:_getQuestState(userId, questId)
	if not questState or questState.completed then
		return
	end

	local newProgress = math.min(questState.progress + amount, questState.goal)
	if newProgress == questState.progress then
		return
	end

	questState.progress = newProgress
	if questState.progress >= questState.goal then
		questState.completed = true
	end

	self:_syncPlayerQuests(userId)
end

---@param userId number
---@param questId string
---@return QuestState?
function QuestService:_getQuestState(userId, questId)
	if not self.playerQuests[userId] then
		self:_initPlayerQuests(userId)
	end

	return self.playerQuests[userId] and self.playerQuests[userId][questId]
end

---@param userId number
function QuestService:_syncPlayerQuests(userId)
	local player = self.players:GetPlayerByUserId(userId)
	if not player then
		return
	end

	local quests = {}
	for _, quest in self.questRepository:getQuests() do
		local state = self.playerQuests[userId][quest.id]
		if state then
			table.insert(quests, state)
		end
	end

	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.QUEST_UPDATED,
		data = {
			quests = quests,
		},
	})
end

---@param deltaTime number
function QuestService:tick(deltaTime)
	for userId, _ in self.playerQuests do
		self.timeAccumulators[userId] = (self.timeAccumulators[userId] or 0) + deltaTime
		if self.timeAccumulators[userId] >= 1 then
			local wholeSeconds = math.floor(self.timeAccumulators[userId])
			self.timeAccumulators[userId] = self.timeAccumulators[userId] - wholeSeconds
			self:_incrementQuest(userId, "play_time", wholeSeconds)
		end
	end
end

return QuestService
