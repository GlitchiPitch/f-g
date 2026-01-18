local Debris = game:GetService("Debris")
---@class ServerActionService
---@field diContainer DIContainer
---@field peckHitbox Model
---@field farmService ServerFarmService
local ActionService = {}
ActionService.__index = ActionService

---@param diContainer DIContainer
---@return ServerActionService
function ActionService.new(diContainer)
	local self = setmetatable({}, ActionService)
	self.diContainer = diContainer
	return self
end

function ActionService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
    ---@type ServerApp
    local application = self.diContainer:resolve("Application")
    self.farmService = application.services.farmService
	self.peckHitbox = shared.assets.PeckHitbox
end

---@param playerEntity PlayerEntity
function ActionService:peck(playerEntity)
	local character = playerEntity.player.Character
	local lookVector = character.HumanoidRootPart.CFrame.LookVector
	local hitboxPosition = character.HumanoidRootPart.CFrame.Position + lookVector * 5
	local hitbox = self.peckHitbox:Clone()
	hitbox.Parent = workspace
	hitbox.CFrame = CFrame.new(hitboxPosition)
	local partsInRadius = workspace:GetPartBoundsInBox(hitbox.CFrame, hitbox.Size)
	for _, part in partsInRadius do
		if part.Parent.Name == "Food" then
			self.farmService:eatFood(playerEntity, part.Parent)
		end
	end

	Debris:AddItem(hitbox, 0.2)
end

---@param playerEntity PlayerEntity
function ActionService:toolActivated(playerEntity)
	local character = playerEntity.player.Character
	local lookVector = character.HumanoidRootPart.CFrame.LookVector
	local hitboxPosition = character.HumanoidRootPart.CFrame.Position + lookVector * 5
	local hitbox = self.peckHitbox:Clone()
	hitbox.Parent = workspace
	hitbox.CFrame = CFrame.new(hitboxPosition)
	local partsInRadius = workspace:GetPartBoundsInBox(hitbox.CFrame, hitbox.Size)
	for _, part in partsInRadius do
		if part.Parent:FindFirstChild("Humanoid") then
			print("Hit a player")
		end
	end

	Debris:AddItem(hitbox, 0.2)
end

return ActionService
