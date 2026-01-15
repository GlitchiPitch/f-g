local UseCases = require(script.UseCases)
local Services = require(script.Services)
---@class ServerApplication
---@field diContainer DIContainer
---@field services ServerAppServices
---@field useCases ServerUseCases
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerApplication
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.services = Services.new(diContainer)
	self.useCases = UseCases.new(diContainer)
	return self
end

function Application:init()
	self.services:init()
	self.useCases:init()
end

return Application
