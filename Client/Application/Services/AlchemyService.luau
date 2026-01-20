local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedAlchemyService = require(ReplicatedStorage.Shared.Application.Services.AlchemyService)

---@class ClientAlchemyService : SharedAlchemyService
---@field diContainer DIContainer
local AlchemyService = setmetatable({}, SharedAlchemyService)
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return ClientAlchemyService
function AlchemyService.new(diContainer)
    local self = setmetatable(SharedAlchemyService.new(diContainer), AlchemyService)
    self.items = {}
    return self
end

function AlchemyService:init()
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    self.eventBus = shared.eventBus
    self.constants = shared.constants

    SharedAlchemyService.init(self)
end

function AlchemyService:openAlchemy()
    self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_ALCHEMY, { state = true })

end

function AlchemyService:addItemToAlchemy(item)
    self.items[item.Name] = item
end

return AlchemyService