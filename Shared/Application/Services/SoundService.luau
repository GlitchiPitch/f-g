local SoundService = game:GetService("SoundService")

---@class CustomSoundService
local CustomSoundService = {}
CustomSoundService.__index = CustomSoundService

---@return CustomSoundService
function CustomSoundService.new()
	local self = setmetatable({}, CustomSoundService)
	return self
end

function CustomSoundService:playSound(soundName)
    local sound = SoundService:FindFirstChild(soundName)
    if not sound then
        warn(`Sound {soundName} not found`)
        return
    end
    
    sound:Play()
end

return CustomSoundService
