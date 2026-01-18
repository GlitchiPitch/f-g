local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

---@class ServerHuntingService
---@field isActive boolean
---@field targetBird string
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field playerRepository ServerPlayerRepository
---@field hunter Model
---@field hunterSpawn Part
local HuntingService = {}
HuntingService.__index = HuntingService

---@param diContainer DIContainer
---@return ServerHuntingService
function HuntingService.new(diContainer)
	local self = setmetatable({}, HuntingService)
	self.diContainer = diContainer
	self.isActive = false
	self.targetBird = ""
	return self
end

function HuntingService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.hunter = shared.domain.Entities.Farmer.new(shared.assets.Hunter)
	self.hunterSpawn = workspace.Worlds.MainWorld.HunterSpawn
end

function HuntingService:start()
	if self.isActive then
		return
	end

	self.isActive = true
	self.hunter:setState(true)
	self.hunter:PivotTo(self.hunterSpawn.CFrame)
	self:_chooseTargetBirdType()
	self:_notifyPlayers()
end

function HuntingService:stop()
	self.isActive = false
	self.hunter:setState(false)
end

function HuntingService:_chooseTargetBirdType()
	local birdTypes = {
		"Chicken",
		"Turkey",
		"Duck",
		"Pheasant",
		"Goose",
		"Ostrich",
		"Vulture",
	}

	local players = {}

	---@param i number
	---@param v PlayerEntity
	for _, v in self.playerRepository:getPlayers() do
		local playerData = v:getData()
		players[playerData.stats.level] = (players[playerData.stats.level] or 0) + 1
	end

	local _players = {}
	for level, count in players do
		table.insert(_players, {
			level = level,
			count = count,
		})
	end

	table.sort(_players, function(a, b)
		return a.count > b.count
	end)

	local targetLevel = _players[1].level
	self.targetBird = birdTypes[targetLevel]
end

function HuntingService:_notifyPlayers()
	self.remoteEventService:fireAllClients({
		eventName = self.constants.REMOTE_EVENTS.HUNTING_STARTED,
		data = {
			targetBird = self.targetBird,
		},
	})
end

return HuntingService
