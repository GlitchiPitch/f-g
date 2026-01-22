local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedAlchemyService = require(ReplicatedStorage.Shared.Application.Services.AlchemyService)

---@class ClientAlchemyService : SharedAlchemyService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants Constants
---@field inputService InputService
---@field playerService ClientPlayerService
---@field cameraController CameraController
---@field targetController TargetController
---@field useCases ClientUseCases
local AlchemyService = setmetatable({}, SharedAlchemyService)
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return ClientAlchemyService
function AlchemyService.new(diContainer)
	local self = setmetatable(SharedAlchemyService.new(diContainer), AlchemyService)
	self.items = {}
	self._currentAlchemyTable = nil
	return self
end

function AlchemyService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
    ---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.useCases = application.useCases
    self.inputService = application.services.inputService
	self.playerService = application.services.playerService
	self.cameraController = application.controllers.cameraController
	self.targetController = application.controllers.targetController
	SharedAlchemyService.init(self)
end

---@param alchemyTable Model
function AlchemyService:openAlchemy(alchemyTable)
	self._currentAlchemyTable = alchemyTable
	local cameraCFrame = alchemyTable.CameraPart.CFrame
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_ALCHEMY, { state = true })
	self.inputService:blockInput(true)
	self.playerService:toggleRobloxControl(false)
	self.cameraController:setCameraMode("static", { cameraCFrame = cameraCFrame })
	self.targetController:blockTargetUpdate(true)
end

---@param item Tool
function AlchemyService:addItemToAlchemy(item)
	if item:HasTag("Alchemable") then
		
		self.useCases:addItemForBrewing(item)
		self:_animateAddItem(item:Clone())
		return true
	end
	return false
end

function AlchemyService:closeAlchemy()
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_ALCHEMY, { state = false })
	self.inputService:blockInput(false)
	self.playerService:toggleRobloxControl(true)
	self.cameraController:setCameraMode("isometric")
	self.targetController:blockTargetUpdate(false)
	self._currentAlchemyTable = nil
end

function AlchemyService:tryBrew()
	self.useCases:brewPotion()
	self:closeAlchemy()
end

---@param item Tool
function AlchemyService:_animateAddItem(item)
	item.Parent = self._currentAlchemyTable
	item:PivotTo(CFrame.new(self._currentAlchemyTable.IngredientSpawnPoint.CFrame.Position))
	Debris:AddItem(item, .5)
end

return AlchemyService
