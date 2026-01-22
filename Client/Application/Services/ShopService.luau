---@class ClientShopService
local ShopService = {}
ShopService.__index = ShopService

---@param diContainer DIContainer
---@return ClientShopService
function ShopService.new(diContainer)
	local self = setmetatable({}, ShopService)
	self.diContainer = diContainer
	self._currentShop = nil
	return self
end

function ShopService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.playerService = application.services.playerService
	self.inputService = application.services.inputService
	self.cameraController = application.controllers.cameraController
	self.targetController = application.controllers.targetController
end

function ShopService:openShop(shop)
	self._currentShop = shop
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_SHOP, { state = true })
	self.inputService:blockInput(true)
	self.playerService:toggleRobloxControl(false)
	self.cameraController:setCameraMode("static", { cameraCFrame = shop.CameraPart.CFrame })
	self.targetController:blockTargetUpdate(true)
end

function ShopService:closeShop()
	self._currentShop = nil
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_SHOP, { state = false })
	self.inputService:blockInput(false)
	self.playerService:toggleRobloxControl(true)
	self.cameraController:setCameraMode("isometric")
	self.targetController:blockTargetUpdate(false)
end

return ShopService
