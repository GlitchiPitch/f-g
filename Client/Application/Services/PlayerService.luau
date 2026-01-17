local Players = game:GetService("Players")
---@class ClientPlayerService
---@field diContainer DIContainer
---@field player Player
---@field _currentState "Idle" | "Weapon" | "NPC"
---@field _weapon Tool
---@field _npc Model
---@field _connections table<string, RBXScriptSignal>
---@field animationService ClientAnimationService
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.player = Players.LocalPlayer
	self.diContainer = diContainer
	self._currentState = "Idle" :: "Idle" | "Weapon" | "NPC"
	self._weapon = nil
	self._npc = nil
	self._connections = {}
	return self
end

function PlayerService:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.animationService = application.services.animationService
	---@param character Model
	local function onCharacterAdded(character)
		self:_onCharacterAdded(character)
	end

	if self.player.Character then
		onCharacterAdded(self.player.Character)
	else
		self.player.CharacterAdded:Connect(onCharacterAdded)
	end
end

---@param character Model
function PlayerService:_onCharacterAdded(character)
	self.animationService:init()
	local function _onChildAdded(child)
		if child:IsA("Tool") and child:HasTag("Weapon") then
			self:setPlayerState("Weapon")
			self._weapon = child
		end
	end

	local function _onChildRemoved(child)
		if child:IsA("Tool") and child:HasTag("Weapon") then
			self:setPlayerState("Idle")
			self._weapon = nil
		end
	end

	self._connections.childAdded = character.ChildAdded:Connect(_onChildAdded)
	self._connections.childRemoved = character.ChildRemoved:Connect(_onChildRemoved)
end

function PlayerService:getPlayerState()
	return self._currentState
end

function PlayerService:setPlayerState(state)
	self._currentState = state
end

return PlayerService
