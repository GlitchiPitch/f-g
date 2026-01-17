local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

---@class SprintController
---@field diContainer DIContainer
---@field playerService ClientPlayerService
---@field commands SharedCommands
---@field useCases ClientUseCases
local SprintController = {}
SprintController.__index = SprintController

---@param diContainer DIContainer
---@return SprintController
function SprintController.new(diContainer)
	local self = setmetatable({}, SprintController)
	self.player = Players.LocalPlayer
	self.diContainer = diContainer
	return self
end

function SprintController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local application = self.diContainer:resolve("Application")

	local function onRender()
		if self.humanoid.MoveDirection.Magnitude > 0 then
			self.walking = true
		else
			self.walking = false
			-- Don't automatically stop running when not moving
			-- Player can hold run key to run in place
		end
	end

	self.canRun = true -- If the player is able to run

	self.commands = shared.application.commands
	self.useCases = application.useCases
	self.playerService = application.services.playerService
	self.character = self.player.Character
	self.humanoid = self.character:WaitForChild("Humanoid")
	-- self.animator = self.humanoid:WaitForChild("Animator")

	-- self.runAnimation = shared.assets.Animations.Run

	-- self.runTrack = self.animator:LoadAnimation(self.runAnimation)
	-- self.runTrack.Priority = Enum.AnimationPriority.Action

	RunService.RenderStepped:Connect(onRender)
end

function SprintController:run()
	local playerEntity = self.playerService:getPlayerEntity()
	self.canRun = playerEntity.stats.stamina.current > 0

	if self.walking and self.canRun then
		self.running = true
		self.useCases.toggleSprint:execute(self.commands.ToggleSprintCommand.new(self.running))
		--FovTween:Play()
		self.runTrack:Play()
	end
end

function SprintController:walk()
	self.running = false
	self.useCases.toggleSprint:execute(self.commands.ToggleSprintCommand.new(self.running))
	--fovTween:Play()
	self.runTrack:Stop()
end

function SprintController:destroy()
	if self.runTrack then
		self.runTrack:Stop()
	end
end

return SprintController
