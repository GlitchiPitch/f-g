---@class ServerAlchemyService
local AlchemyService = {}
AlchemyService.__index = AlchemyService

---@return ServerAlchemyService
function AlchemyService.new()
    local self = setmetatable({}, AlchemyService)
    return self
end

function AlchemyService:init()
end

---@param player Player
---@param data table
function AlchemyService:tryBrew(player, data)
    
end

return AlchemyService