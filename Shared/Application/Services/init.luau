local SoundService = require(script.SoundService)

---@class Services
---@field diContainer DIContainer
---@field soundService CustomSoundService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return Services
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.diContainer = diContainer
	self.soundService = SoundService.new()
	return self
end

function Services:init()
end

return Services
