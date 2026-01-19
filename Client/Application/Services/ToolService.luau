local Players = game:GetService("Players")
---@class ClientToolService
---@field _currentTool Tool
---@field diContainer DIContainer
---@field debounce boolean
---@field attackIndex number
---@field lastTime number
---@field playerService ClientPlayerService
---@field animationService ClientAnimationService
---@field constants Constants
---@field isEquipped boolean
---@field useCases ClientUseCases
local ToolService = {}
ToolService.__index = ToolService

---@param diContainer DIContainer
---@return ClientToolService
function ToolService.new(diContainer)
	local self = setmetatable({}, ToolService)
	self.diContainer = diContainer
	self._currentTool = nil
	self.player = Players.LocalPlayer
	self.isEquipped = false
	self.debounce = false
	self.attackIndex = 1
	self.lastTime = nil
	self.maxCombo = 4 -- @TODO: get value from animationService

	return self
end

function ToolService:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.constants = shared.constants
	self.useCases = application.useCases
	self.playerService = application.services.playerService
	self.animationService = application.services.animationService
end

function ToolService:checkCharacterTool()
	local character = self.player.Character
	---@param child Instance
	local function _onChildAdded(child)
		if child:IsA("Tool") and child:HasTag("Weapon") then
			self.playerService:setPlayerState("Weapon")
			self:_setupTool(child)
		end
	end
	---@param child Instance
	local function _onChildRemoved(child)
		if child:IsA("Tool") and child:HasTag("Weapon") then
			self.playerService:setPlayerState("Idle")
			self:_removeTool()
		end
	end
	character.ChildAdded:Connect(_onChildAdded)
	character.ChildRemoved:Connect(_onChildRemoved)
end

function ToolService:_setupTool(currentTool)
	self.isEquipped = true
	self._currentTool = currentTool
	if currentTool:GetAttribute("WeaponType") == "OneHanded" then
		self.animationService:playAnimation("oneHandedIdle")
	elseif currentTool:GetAttribute("WeaponType") == "TwoHanded" then
		self.animationService:playAnimation("twoHandedIdle")
	end
end

function ToolService:_removeTool()
	self._currentTool = nil
	self.lastTime = nil
	self.isEquipped = false
	self.animationService:stopAllAnimations()
end

function ToolService:activated()
	if not self.isEquipped then
		return
	end

	if self.debounce then
		return
	end

	self.debounce = true

	self.useCases:toolActivated()

	local weaponType = self._currentTool:GetAttribute("WeaponType")
	if weaponType == "OneHanded" or weaponType == "TwoHanded" then
		self:_activeWeapon(weaponType)
		-- elseif self._currentTool:HasTag("Food") then
		-- 	self:_activeFood()
	end

	self.debounce = false
end

---@param setBlock boolean
function ToolService:block(setBlock)
	if setBlock then
		self.animationService:playAnimation("block")
	else
		self.animationService:stopAnimation("block")
	end
end

---@param weaponType string
function ToolService:_activeWeapon(weaponType)
	local animationPrefix = weaponType == "OneHanded" and "oneHanded" or "twoHanded"

	if self.lastTime == nil then
		print("First Time")
	elseif os.time() - 2 > self.lastTime then
		self.attackIndex = 1
	else
		if self.attackIndex == self.maxCombo then
			self.attackIndex = 1
		else
			self.attackIndex = math.min(self.attackIndex + 1, self.maxCombo)
		end
	end

	self.lastTime = os.time()

	local animationName = animationPrefix .. self.attackIndex
	if self.animationService.animTracks[animationName] then
		self.animationService.animTracks[animationName]:Play()
		task.wait(self.animationService.animTracks[animationName].Length)
	else
		task.wait(0.5)
	end
end

-- function ToolService:_activeFood()
-- 	self.animationService.animTracks.Eat:Play()
-- 	task.wait(self.animationService.animTracks.Eat.Length)
-- end

function ToolService:destroy()
	self._currentTool = nil
	self.isEquipped = false
	self.debounce = false
end

return ToolService
