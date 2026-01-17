local PlayerService = require(script.PlayerService)
local HuntingService = require(script.HuntingService)

---@class ServerAppServices
---@field playerService ServerPlayerService
---@field huntingService ServerHuntingService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerAppServices
function Services.new(diContainer)
    local self = setmetatable({}, Services)
    self.diContainer = diContainer
	self.playerService = PlayerService.new(self.diContainer)
    self.huntingService = HuntingService.new(self.diContainer)
    return self
end

function Services:init()
    self.playerService:init()
    self.huntingService:init()
end

return Services