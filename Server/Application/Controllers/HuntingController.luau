---@class ServerHuntingController
---@field diContainer DIContainer
---@field huntingService ServerHuntingService
---@field _deltaTime number
---@field _updateTime number
---@field _hunter FarmerEntity
---@field mainWorld Model
local HuntingController = {}
HuntingController.__index = HuntingController

-- Settings
local DETECTION_DISTANCE = 100

---@param diContainer DIContainer
---@return ServerHuntingController
function HuntingController.new(diContainer)
	local self = setmetatable({}, HuntingController)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._updateTime = 0.3
	self._hunter = nil
	self._spawnHunterTime = 0
	self._spawnHunterInterval = 5
	self._updateHunterInterval = 0.1
	self._updateHunterTime = 0
	return self
end

function HuntingController:init()
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	self.huntingService = application.services.huntingService
	self.mainWorld = workspace.Worlds.MainWorld
end

---@param deltaTime number
function HuntingController:update(deltaTime)
	self._deltaTime += deltaTime

	if self._hunter then
		self._updateHunterTime += deltaTime
		if self._updateHunterTime >= self._updateHunterInterval then
			self:_updateHunter()
			self._updateHunterTime = 0
		end
	end

	if self._deltaTime < self._updateTime then
		return
	end

	self._spawnHunterTime += self._deltaTime
	if self._spawnHunterTime >= self._spawnHunterInterval then
		-- self._spawnHunterTime = 0

		if self.huntingService.isActive then
			-- self.huntingService:stop()
			-- self._hunter = nil
		else
			self.huntingService:start()
			self._hunter = self.huntingService.hunter
		end
	end

	self._deltaTime = 0
end

function HuntingController:_updateHunter()
	if not self._hunter then
		return
	end

	local target = self:_findTarget()

	if not target then
		return
	end
	local distance = (self._hunter.model.PrimaryPart.Position - target.PrimaryPart.Position).Magnitude
	if distance > self._hunter.attackDistance then
		self._hunter:moveTo(target.PrimaryPart.Position)
	else
		self._hunter:attack(target)
	end
end

function HuntingController:_findTarget()
	if not self._hunter then
		return nil
	end

	local hunterPosition = self._hunter.model.PrimaryPart.Position
	local target = nil
	local targetDistance = DETECTION_DISTANCE

	for _, v in self.mainWorld.Players:GetChildren() do
		local distance = (v.PrimaryPart.Position - hunterPosition).Magnitude
		if distance < targetDistance then
			target = v
			targetDistance = distance
		end
	end
	return target
end

return HuntingController
