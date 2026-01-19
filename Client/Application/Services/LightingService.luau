local Lighting = game:GetService("Lighting")
---@class LightingService
local LightingService = {}
LightingService.__index = LightingService

---@param diContainer DIContainer
---@return LightingService
function LightingService.new(diContainer)
	local self = setmetatable({}, LightingService)
	self.diContainer = diContainer
	return self
end

function LightingService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.butcheryLighting = shared.assets.Lighting.Butchery
	self.hellLighting = shared.assets.Lighting.Hell
end

---@param mode "Butchery" | "Hell"
function LightingService:setMode(mode)
	Lighting:ClearAllChildren()
	if mode == "Butchery" then
		for _, v in self.butcheryLighting:GetChildren() do
			v:Clone().Parent = Lighting
		end
	elseif mode == "Hell" then
		for _, v in self.hellLighting:GetChildren() do
			v:Clone().Parent = Lighting
		end
	end
end

return LightingService
