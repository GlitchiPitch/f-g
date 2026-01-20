local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedAlchemyService = require(ReplicatedStorage.Shared.Application.Services.AlchemyService)

---@class ClientAlchemyService : SharedAlchemyService
---@field diContainer DIContainer
local AlchemyService = setmetatable({}, SharedAlchemyService)
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return ClientAlchemyService
function AlchemyService.new(diContainer)
    return setmetatable(SharedAlchemyService.new(diContainer), AlchemyService)
end

function AlchemyService:init()
    SharedAlchemyService.init(self)
end

return AlchemyService