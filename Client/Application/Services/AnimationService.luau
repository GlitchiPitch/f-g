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

    self.animTracks.peck = animator:LoadAnimation(shared.assets.Animations.Peck)
    self.animTracks.peck.Priority = Enum.AnimationPriority.Action
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