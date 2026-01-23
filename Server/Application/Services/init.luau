local PlayerService = require(script.PlayerService)
local HuntingService = require(script.HuntingService)
local ActionService = require(script.ActionService)
local FarmService = require(script.FarmService)
local TeleportService = require(script.TeleportService)
local EnemyService = require(script.EnemyService)
local AlchemyService = require(script.AlchemyService)
local CraftService = require(script.CraftService)
local LootService = require(script.LootService)
---@class ServerAppServices
---@field playerService ServerPlayerService
---@field huntingService ServerHuntingService
---@field actionService ServerActionService
---@field farmService ServerFarmService
---@field teleportService TeleportService
---@field enemyService EnemyService
---@field alchemyService ServerAlchemyService
---@field craftService ServerCraftService
---@field lootService ServerLootService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerAppServices
function Services.new(diContainer)
    local self = setmetatable({}, Services)
    self.diContainer = diContainer
	self.playerService = PlayerService.new(self.diContainer)
    self.huntingService = HuntingService.new(self.diContainer)
    self.actionService = ActionService.new(self.diContainer)
    self.farmService = FarmService.new(self.diContainer)
    self.teleportService = TeleportService.new(self.diContainer)
    self.enemyService = EnemyService.new(self.diContainer)
    self.alchemyService = AlchemyService.new(self.diContainer)
    self.craftService = CraftService.new(self.diContainer)
    self.lootService = LootService.new(self.diContainer)
    return self
end

function Services:init()
    self.playerService:init()
    self.huntingService:init()
    self.actionService:init()
    self.farmService:init()
    self.teleportService:init()
    self.enemyService:init()
    self.alchemyService:init()
    self.craftService:init()
    self.lootService:init()
end

return Services