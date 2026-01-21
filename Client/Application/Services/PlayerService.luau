local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedPlayerService = require(ReplicatedStorage.Shared.Application.Services.PlayerService)

---@class ClientPlayerService : SharedPlayerService
---@field player Player
---@field character Model
---@field cameraController CameraController
---@field sprintController SprintController
---@field _currentState "Idle" | "Weapon" | "NPC"
---@field _weapon Tool
---@field _npc Model
---@field toolService ClientToolService
---@field lightingService LightingService
---@field _connections table<string, RBXScriptSignal>
---@field animationService ClientAnimationService
local PlayerService = setmetatable({}, SharedPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedPlayerService.new(diContainer), PlayerService)
	self.player = Players.LocalPlayer
	self._currentState = "Idle" :: "Idle" | "Weapon" | "NPC"
	self._weapon = nil
	self._npc = nil
	self._connections = {}
	return self
end

function PlayerService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	---@param character Model
	local function onCharacterAdded(character)
		self:_onCharacterAdded(character)
	end

	SharedPlayerService.init(self)

	self.eventBus = shared.eventBus

	self.animationService = application.services.animationService
	self.toolService = application.services.toolService
	self.cameraController = application.controllers.cameraController
	self.sprintController = application.controllers.sprintController
	self.lightingService = application.services.lightingService


	local playerModule = require(self.player.PlayerScripts:WaitForChild("PlayerModule"))
	self.robloxControl = playerModule:GetControls()

	if self.player.Character then
		onCharacterAdded(self.player.Character)
	else
		self.player.CharacterAdded:Connect(onCharacterAdded)
	end
end

function PlayerService:getPlayerState()
	return self._currentState
end

function PlayerService:setPlayerState(state)
	self._currentState = state
end

function PlayerService:_onCharacterAdded(character)
	local playerRepository = self:_getPlayerRepository()
	local playerEntity = playerRepository:getPlayerEntity(self.player)
	local currentWorldName = playerEntity:getCurrentWorld()
	local humanoid = character:FindFirstChild("Humanoid")
	local function _inventoryRefresh()
		self.eventBus:fire(self.constants.CLIENT_EVENTS.INVENTORY_REFRESH, {})
	end

	if humanoid then
		humanoid.Died:Connect(function()
			self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_DIED_SCREEN, { state = true })
		end)
	end

	character.ChildAdded:Connect(_inventoryRefresh)
	character.ChildRemoved:Connect(_inventoryRefresh)
	playerEntity.player.Backpack.ChildAdded:Connect(_inventoryRefresh)
	playerEntity.player.Backpack.ChildRemoved:Connect(_inventoryRefresh)
	
	_inventoryRefresh()

	if currentWorldName == "Butchery" then
		self.cameraController:setCameraMode("standard")
		self.lightingService:setMode("Butchery")
	elseif currentWorldName == "Hell" then
		self.lightingService:setMode("Hell")
	else
		self.cameraController:setCameraMode("isometric")
	end

	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_DIED_SCREEN, { state = false })

	self.animationService:init()
	self.cameraController:onCharacterAdded()
	self.toolService:checkCharacterTool()
	self.sprintController:onCharacterAdded()
end

function PlayerService:isAlive()
	return self:_isAlive(self.player)
end

---@param state boolean
function PlayerService:toggleRobloxControl(state)
	if state then
		self.robloxControl:Enable()
	else
		self.robloxControl:Disable()
	end
end

---@return ClientPlayerRepository
function PlayerService:_getPlayerRepository()
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	return infrastructure.repositories.playerRepository
end

return PlayerService
