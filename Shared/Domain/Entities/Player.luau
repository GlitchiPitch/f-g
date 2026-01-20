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
	self.currentWorld = "Lobby"
	self._vars = {}
	return self
end

function PlayerEntity:fromData(data)
	self.currentWorld = if data.currentWorld then data.currentWorld else self.currentWorld
	self.stats = if data.stats then data.stats else self.stats
end

---@param vars table<string, ValueBase>
function PlayerEntity:addVars(vars)
	for name, var in vars do
		self._vars[name] = var
	end
end

function PlayerEntity:getVars()
	return self._vars
end

function PlayerEntity:getData()
	return {
		stats = self.stats,
		currentWorld = self.currentWorld,
	}
end

function PlayerEntity:setCurrentWorld(world)
	self.currentWorld = world
end

function PlayerEntity:getCurrentWorld()
	return self.currentWorld
end
	
function PlayerEntity:isAlive()
	local character = self.player.Character
	if not character then
		return false
	end
	
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then
		return false
	end
	
	if humanoid.Health <= 0 then
		return false
	end
	
	return true
end

return PlayerEntity
