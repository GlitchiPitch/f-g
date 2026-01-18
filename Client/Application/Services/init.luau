local PlayerService = require(script.PlayerService)
local ActionService = require(script.ActionService)
local AnimationService = require(script.AnimationService)
local InputService = require(script.InputService)
local FarmService = require(script.FarmService)
local ToolService = require(script.ToolService)
---@class ClientAppServices
---@field diContainer DIContainer
---@field playerService ClientPlayerService
---@field actionService ClientActionService
---@field animationService ClientAnimationService
---@field inputService InputService
---@field farmService ClientFarmService
---@field toolService ClientToolService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.diContainer = diContainer
	self.playerService = PlayerService.new(self.diContainer)
	self.actionService = ActionService.new(self.diContainer)
	self.animationService = AnimationService.new(self.diContainer)
	self.inputService = InputService.new(self.diContainer)
	self.farmService = FarmService.new(self.diContainer)
	self.toolService = ToolService.new(self.diContainer)
	return self
end

function Services:init()
	self.playerService:init()
	self.actionService:init()
	self.inputService:init()
	self.farmService:init()
	self.toolService:init()
end

return Services
