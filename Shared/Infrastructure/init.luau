local DIContainer = require(script.DIContainer)
local Services = require(script.Services)
local EventBus = require(script.EventBus)
local Repositories = require(script.Repositories)

---@class Infrastructure
---@field diContainer DIContainer
---@field services Services
---@field eventBus EventBus
---@field repositories SharedRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@return Infrastructure
function Infrastructure.new()
	local self = setmetatable({}, Infrastructure)
	self.diContainer = DIContainer.new()
	self.services = Services.new()
	self.eventBus = EventBus.new()
	self.repositories = Repositories.new(self.diContainer)
	return self
end

function Infrastructure:init()
	self.repositories:init()
end

return Infrastructure
