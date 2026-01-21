---@class ClientCraftService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants Constants
---@field cache Cache
---@field items table<string, Tool>
---@field inputService InputService
---@field playerService ClientPlayerService
---@field cameraController CameraController
---@field targetController TargetController
local CraftService = {}
CraftService.__index = CraftService

---@param diContainer DIContainer
---@return ClientCraftService
function CraftService.new(diContainer)
	local self = setmetatable({}, CraftService)
	self.diContainer = diContainer
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
	self.cache = shared.cache
	self.cameraController = application.controllers.cameraController
	self.inputService = application.services.inputService
	self.playerService = application.services.playerService
	self.targetController = application.controllers.targetController
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
		self.items[item.Name] = (self.items[item.Name] or 0) + 1
		self.cache:addObjectToCache(item)
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
	self.useCases:craftItem(self.items)
	self:closeCraft()
end

---@param item Tool
function CraftService:_animateAddItem(item)
	
end

return CraftService
