local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedAlchemyService = require(ReplicatedStorage.Shared.Application.Services.AlchemyService)

---@class ClientAlchemyService : SharedAlchemyService
---@field diContainer DIContainer
---@field cache Cache
---@field items table<string, Tool>
---@field eventBus EventBus
---@field constants Constants
---@field inputService InputService
---@field playerService ClientPlayerService
---@field cameraController CameraController
---@field targetController TargetController
local AlchemyService = setmetatable({}, SharedAlchemyService)
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return ClientAlchemyService
function AlchemyService.new(diContainer)
	local self = setmetatable(SharedAlchemyService.new(diContainer), AlchemyService)
	self.items = {}
	return self
end

function AlchemyService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
    ---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
    self.cache = shared.cache
    self.inputService = application.services.inputService
	self.playerService = application.services.playerService
	self.cameraController = application.controllers.cameraController
	self.targetController = application.controllers.targetController
	SharedAlchemyService.init(self)
end

---@param cameraCFrame CFrame
function AlchemyService:openAlchemy(cameraCFrame)
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_ALCHEMY, { state = true })
	self.inputService:blockInput(true)
	self.playerService:toggleRobloxControl(false)
	self.cameraController:setCameraMode("alchemy", { cameraCFrame = cameraCFrame })
	self.targetController:blockTargetUpdate(true)
end

---@param item Tool
function AlchemyService:addItemToAlchemy(item)
	if item:HasTag("Alchemable") then
		self.items[item.Name] = item
		self.cache:addObjectToCache(item)
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
end


return AlchemyService
