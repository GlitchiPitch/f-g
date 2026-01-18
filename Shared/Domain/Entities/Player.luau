---@class playerStats
---@field level number
---@field seeds number

---@class PlayerEntity
---@field player Player
---@field stats playerStats
local PlayerEntity = {}
PlayerEntity.__index = PlayerEntity

---@param player Player
---@return PlayerEntity
function PlayerEntity.new(player)
	local self = setmetatable({}, PlayerEntity)
	self.player = player
	self.stats = {
		level = 1,
		seeds = 0,
	}
	return self
end

function PlayerEntity:fromData(data)
	self.stats = if data.stats then data.stats else self.stats
end

function PlayerEntity:getData()
	return {
		stats = self.stats,
	}
end

return PlayerEntity
