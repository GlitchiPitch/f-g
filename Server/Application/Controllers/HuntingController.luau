---@class ServerHuntingController
---@field diContainer DIContainer
---@field huntingService ServerHuntingService
---@field _deltaTime number
---@field _updateTime number
---@field _hunter FarmerEntity
---@field mainWorld Model
local HuntingController = {}
HuntingController.__index = HuntingController

---@param diContainer DIContainer
---@return ServerHuntingController
function HuntingController.new(diContainer)
	local self = setmetatable({}, HuntingController)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._updateTime = 0.3
	self._hunter = nil
	self._spawnHunterTime = 0
	self._spawnHunterInterval = 10
	return self
end

function HuntingController:init()
	---@type ServerApp
	local application = self.diContainer:resolve("Application")
	self.huntingService = application.services.huntingService
	self.mainWorld = workspace.MainWorld
end

---@param deltaTime number
function HuntingController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime < self._updateTime then
		return
	end

	self._spawnHunterTime += deltaTime
	if self._spawnHunterTime >= self._spawnHunterInterval then
		self._spawnHunterTime = 0
		if self.huntingService.isActive then
			self.huntingService:stop()
			self._hunter = nil
		else
			self.huntingService:start()
			self._hunter = self.huntingService.hunter
		end
	end

	if self._hunter then
		self._hunter:update(deltaTime)
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

	if
		self._hunter.attackDistance > (self._hunter.model.PrimaryPart.Position - target.PrimaryPart.Position).Magnitude
	then
		self._hunter:moveTo(target.PrimaryPart.Position)
	else
		self._hunter:attack(target)
	end
end

function HuntingController:_findTarget()
	if not self._hunter then
		return nil
	end

	local target = nil
	local targetDistance = math.huge
	for _, v in self.mainWorld.Players:GetChildren() do
		local distance = (v.PrimaryPart.Position - self._hunter.model.PrimaryPart.Position).Magnitude
		if distance < targetDistance then
			target = v
			targetDistance = distance
		end
	end
	return target
end

return HuntingController
