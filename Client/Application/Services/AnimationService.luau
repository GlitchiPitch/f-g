---@class ClientAnimationService
---@field diContainer DIContainer
---@field animTracks table<string, AnimationTrack>
local AnimationService = {}
AnimationService.__index = AnimationService

---@param diContainer DIContainer
---@return ClientAnimationService
function AnimationService.new(diContainer)
	local self = setmetatable({}, AnimationService)
	self.diContainer = diContainer
	self.animTracks = {}
	return self
end

function AnimationService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	local player = application.services.playerService.player
	local animator = player.Character:WaitForChild("Humanoid"):WaitForChild("Animator")

	local oneHandedAnimations = {
		shared.assets.Animations.OneHandednSlash4,
		shared.assets.Animations.OneHandednSlash3,
		shared.assets.Animations.OneHandednSlash2,
		shared.assets.Animations.OneHandednSlash1,
	}

	self.animTracks.peck = animator:LoadAnimation(shared.assets.Animations.Peck)
	self.animTracks.peck.Priority = Enum.AnimationPriority.Action

	self.animTracks.oneHandedIdle = animator:LoadAnimation(shared.assets.Animations.OneHandedIdle) :: AnimationTrack
	self.animTracks.oneHandedIdle.Looped = true
	self.animTracks.oneHandedIdle.Priority = Enum.AnimationPriority.Action

	for i, animation in oneHandedAnimations do
		self.animTracks["oneHanded" .. i] = animator:LoadAnimation(animation) :: AnimationTrack
		self.animTracks["oneHanded" .. i].Looped = false
		self.animTracks["oneHanded" .. i].Priority = Enum.AnimationPriority.Action2
	end
end

---@param animationName '"peck"'
function AnimationService:playAnimation(animationName)
	if not self.animTracks[animationName] then
		warn(`Animation {animationName} not found`)
		return
	end

	self.animTracks[animationName]:Play()
end

---@param animationName '"peck"'
function AnimationService:stopAnimation(animationName)
	if not self.animTracks[animationName] then
		warn(`Animation {animationName} not found`)
		return
	end

	self.animTracks[animationName]:Stop()
end
return AnimationService
