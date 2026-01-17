local Controllers = require(script.Controllers)
local Services = require(script.Services)
local UseCases = require(script.UseCases)
---@class ClientApplication
---@field controllers ClientControllers
---@field services ClientAppServices
---@field useCases ClientUseCases
---@field diContainer DIContainer
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ClientApplication
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.services = Services.new(self.diContainer)
	self.useCases = UseCases.new(self.diContainer)
	self.controllers = Controllers.new(self.diContainer)
	return self
end

function Application:init()
	self.services:init()
	self.useCases:init()
	self.controllers:init()
end

return Application
