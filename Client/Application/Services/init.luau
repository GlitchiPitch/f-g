local PlayerService = require(script.PlayerService)
local ActionService = require(script.ActionService)
local AnimationService = require(script.AnimationService)
local InputService = require(script.InputService)
local FarmService = require(script.FarmService)
local ToolService = require(script.ToolService)
local LightingService = require(script.LightingService)
local AlchemyService = require(script.AlchemyService)
local CraftService = require(script.CraftService)
local ShopService = require(script.ShopService)
local QuestService = require(script.QuestService)
---@class ClientAppServices
---@field diContainer DIContainer
---@field playerService ClientPlayerService
---@field actionService ClientActionService
---@field animationService ClientAnimationService
---@field inputService InputService
---@field farmService ClientFarmService
---@field toolService ClientToolService
---@field lightingService LightingService
---@field alchemyService ClientAlchemyService
---@field craftService ClientCraftService
---@field shopService ClientShopService
---@field questService ClientQuestService
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
	self.lightingService = LightingService.new(self.diContainer)
	self.alchemyService = AlchemyService.new(self.diContainer)
	self.craftService = CraftService.new(self.diContainer)
	self.shopService = ShopService.new(self.diContainer)
	self.questService = QuestService.new(self.diContainer)
	return self
end

function Services:init()
	self.playerService:init()
	self.actionService:init()
	self.inputService:init()
	self.farmService:init()
	self.toolService:init()
	self.lightingService:init()
	self.alchemyService:init()
	self.craftService:init()
	self.shopService:init()
	self.questService:init()
end

return Services
