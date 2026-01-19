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
	local hitboxPosition = character.HumanoidRootPart.CFrame.Position
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

	local hitboxPosition = character.HumanoidRootPart.CFrame.Position
	local hitbox = self.peckHitbox:Clone()
	hitbox.Parent = workspace
	hitbox.CFrame = CFrame.new(hitboxPosition)
	local partsInRadius = workspace:GetPartBoundsInBox(hitbox.CFrame, hitbox.Size)
	for _, part in partsInRadius do
		local humanoid = part.Parent:FindFirstChild("Humanoid")

		if humanoid then
			local isPlayer = humanoid == playerEntity.player.Character.Humanoid
			if not isPlayer then
				humanoid:TakeDamage(10)
				-- if player has one handed use break for one damaged person
				-- if two handed not use break
				
				-- break 
			end
		end
	end

	Debris:AddItem(hitbox, 0.2)
end

return ActionService
