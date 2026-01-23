local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedPlayerRepository = require(ReplicatedStorage.Shared.Infrastructure.Repositories.PlayerRepository)

---@class ClientPlayerRepository
---@field diContainer DIContainer
---@field _playerRepository SharedPlayerRepository
local PlayerRepository = setmetatable({}, SharedPlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(SharedPlayerRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	SharedPlayerRepository.init(self)
end

return PlayerRepository
