local Players = game:GetService("Players")
---@class ClientPlayerService
---@field diContainer DIContainer
---@field player Player
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.player = Players.LocalPlayer
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
    ---@param character Model
	local function onCharacterAdded(character)
		self:_onCharacterAdded(character)
	end

	if self.player.Character then
		onCharacterAdded(self.player.Character)
	else
		self.player.CharacterAdded:Connect(onCharacterAdded)
	end
end

---@param character Model
function PlayerService:_onCharacterAdded(character) end

return PlayerService
