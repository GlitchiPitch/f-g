local ReplicatedStorage = game:GetService("ReplicatedStorage")
---@class ServerHuntingService
---@field isActive boolean
---@field targetBird string
---@field remoteEventService RemoteEventService
---@field constants Constants
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
	self.remoteEventService = shared.infrastructure.services.remoteEventService
	self.constants = shared.constants
	self.hunter = shared.assets.Hunter
	self.hunterSpawn = workspace.HunterSpawn
end

function HuntingService:start()
	if self.isActive then
		return
	end

	self.isActive = true
	self.hunter.Parent = workspace
	self.hunter:PivotTo(self.hunterSpawn.CFrame)
	self:_chooseTargetBirdType()
	self:_notifyPlayers()
end

function HuntingService:stop()
	self.isActive = false
	self.hunter.Parent = ReplicatedStorage
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

	self.targetBird = birdTypes[math.random(#birdTypes)]
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
