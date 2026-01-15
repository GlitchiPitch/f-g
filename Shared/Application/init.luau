local Commands = require(script.Commands)
local Services = require(script.Services)

---@class Application
---@field commands Commands
---@field services Services
---@field diContainer DIContainer
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return Application
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.commands = Commands.new()
	self.services = Services.new(self.diContainer)
	return self
end

function Application:init() end

return Application
