local UserInputService = game:GetService("UserInputService")
---@class InputService
---@field diContainer DIContainer
---@field config Config
---@field constants Constants
---@field eventBus EventBus
---@field playerService ClientPlayerService
---@field sprintController SprintController
---@field cameraController CameraController
---@field actionService ClientActionService
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return InputService
function InputService.new(diContainer)
	local self = setmetatable({}, InputService)
	self.diContainer = diContainer
	self._blockInput = false
	return self
end

function InputService:init()
	local function onInputBegan(input, gameProccessed)
		self:_inputBegan(input, gameProccessed)
	end

	local function onInputEnded(input, gameProccessed)
		self:_inputEnded(input, gameProccessed)
	end

	local function onInputChanged(input, gameProccessed)
		self:_inputChanged(input, gameProccessed)
	end

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.config = shared.config
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.playerService = application.services.playerService

	self.actionService = application.services.actionService
	self.sprintController = application.controllers.sprintController
	self.cameraController = application.controllers.cameraController

	self.toolService = application.services.toolService
	self._inputBeganConn = UserInputService.InputBegan:Connect(onInputBegan)
	self._inputEndedConn = UserInputService.InputEnded:Connect(onInputEnded)
	self._inputChangedConn = UserInputService.InputChanged:Connect(onInputChanged)
end

---@param state boolean
function InputService:blockInput(state)
	self._blockInput = state
end

---@param input InputObject
---@param gameProccessed any
function InputService:_inputBegan(input, gameProccessed)
	if gameProccessed or self._blockInput then
		return
	end

	local playerState = self.playerService:getPlayerState()
	if input.UserInputType == self.config.Client.Control.MainAction then
		if playerState == "Idle" then
			self.actionService:idleAction()
		elseif playerState == "Weapon" then
			self.toolService:activated()
		elseif playerState == "Interact" then
			self.actionService:interactAction()
		end
	elseif input.UserInputType == self.config.Client.Control.SecondAction then
		if playerState == "Weapon" then
			self.toolService:block(true)
		end
	end

	if input.KeyCode == self.config.Client.Control.RunKey then
		self.sprintController:run()
	end

	if input.KeyCode == self.config.Client.Control.InventoryKey then
		self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_INVENTORY, {})
	end

	-- if self.config.Client.Control.EquippmentKeys[input.KeyCode.Name] then
	-- 	self.equipmentService:pressEquipKey(input.KeyCode.Name)
	-- end
end

function InputService:_inputEnded(input, gameProccessed)
	if gameProccessed or self._blockInput then
		return
	end
	local playerState = self.playerService:getPlayerState()
	if input.UserInputType == self.config.Client.Control.SecondAction then
		if playerState == "Weapon" then
			self.toolService:block(false)
		end
	end

	if input.KeyCode == self.config.Client.Control.RunKey then
		self.sprintController:walk()
	end
end

function InputService:_inputChanged(input, gameProccessed)
	if gameProccessed then
		return
	end

	-- if input.UserInputType == Enum.UserInputType.MouseMovement then
	-- 	self.cameraController:onMouseMovement(input)
	-- end
end

function InputService:destroy()
	if self._inputBeganConn then
		self._inputBeganConn:Disconnect()
		self._inputBeganConn = nil
	end
	if self._inputEndedConn then
		self._inputEndedConn:Disconnect()
		self._inputEndedConn = nil
	end
	if self._inputChangedConn then
		self._inputChangedConn:Disconnect()
		self._inputChangedConn = nil
	end
end

return InputService
