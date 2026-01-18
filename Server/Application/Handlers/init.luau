local TeleportHandler = require(script.TeleportHandler)
---@class ServerHandlers
---@field diContainer DIContainer
---@field teleportHandler TeleportHandler
local Handlers = {}
Handlers.__index = Handlers

---@return ServerHandlers
function Handlers.new(diContainer)
	local self = setmetatable({}, Handlers)
	self.diContainer = diContainer
	self.teleportHandler = TeleportHandler.new(diContainer)
	return self
end

function Handlers:init()
	self.teleportHandler:init()
end


return Handlers