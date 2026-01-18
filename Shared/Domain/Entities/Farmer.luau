local ReplicatedStorage = game:GetService("ReplicatedStorage")

---@class FarmerEntity
---@field model Model
---@field connections table<string, RBXScriptSignal>
---@field attackDistance number
---@field _humanoid Humanoid
local FarmerEntity = {}
FarmerEntity.__index = FarmerEntity

---@param model Model
---@return FarmerEntity
function FarmerEntity.new(model)
	local self = setmetatable({}, FarmerEntity)
	self.model = model
	self._humanoid = self.model.Humanoid
	self.connections = {}
	self.attackDistance = 10
	return self
end

function FarmerEntity:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.animationTracks = {}
end

---@param state boolean
function FarmerEntity:setState(state)
	if state then
		self.model.Parent = workspace
	else
		self.model.Parent = ReplicatedStorage
	end
end

function FarmerEntity:moveTo(position)
	self._humanoid:MoveTo(position)
end

---@param playerEntity PlayerEntity
function FarmerEntity:attack(playerEntity) 
	
end

function FarmerEntity:destroy() end

return FarmerEntity
