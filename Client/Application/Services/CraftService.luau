local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedCraftService = require(ReplicatedStorage.Shared.Application.Services.CraftService)

---@class ClientCraftService : SharedCraftService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants Constants
---@field inputService InputService
---@field playerService ClientPlayerService
---@field cameraController CameraController
---@field targetController TargetController
---@field useCases ClientUseCases
local CraftService = setmetatable({}, SharedCraftService)
CraftService.__index = CraftService

---@param diContainer DIContainer
---@return ClientCraftService
function CraftService.new(diContainer)
	local self = setmetatable(SharedCraftService.new(diContainer), CraftService)
	self.items = {}
	self._currentCraftTable = nil
	return self
end

function CraftService:init()
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
	SharedCraftService.init(self)
end

---@param craftTable Model
function CraftService:openCraft(craftTable)
	self._currentCraftTable = craftTable
	local cameraCFrame = craftTable.CameraPart.CFrame
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_CRAFT, { state = true })
	self.inputService:blockInput(true)
	self.playerService:toggleRobloxControl(false)
	self.cameraController:setCameraMode("craft", { cameraCFrame = cameraCFrame })
	self.targetController:blockTargetUpdate(true)
end

---@param item Tool
function CraftService:addItemToCraft(item)
	if item:HasTag("Craftable") then
		self.useCases:addItemForCrafting(item)
		self:_animateAddItem(item:Clone())
		return true
	end
	return false
end

function CraftService:closeCraft()
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_CRAFT, { state = false })
	self.inputService:blockInput(false)
	self.playerService:toggleRobloxControl(true)
	self.cameraController:setCameraMode("isometric")
	self.targetController:blockTargetUpdate(false)
end

function CraftService:tryCraft()
	self.useCases:craftItem()
	self:closeCraft()
end

---@param item Tool
function CraftService:_animateAddItem(item)
	item.Parent = self._currentCraftTable
	item:PivotTo(CFrame.new(self._currentCraftTable.IngredientSpawnPoint.CFrame.Position))
	Debris:AddItem(item, 0.5)
end

return CraftService
