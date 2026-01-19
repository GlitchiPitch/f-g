local Infrastructure = require(script.Infrastructure)
local Application = require(script.Application)
local Constants = require(script.Constants)
local Domain = require(script.Domain)
local Config = require(script.Config)
local Data = require(script.Data)
local Assets = require(script.Assets)

---@class Shared
---@field assets Assets
---@field data Data
---@field config Config
---@field constants Constants
---@field domain Domain
---@field infrastructure Infrastructure
---@field remoteEventService RemoteEventService
---@field diContainer DIContainer
---@field application Application
---@field eventBus EventBus
local Shared = {}
Shared.__index = Shared

---@return Shared
function Shared.new()
	local self = setmetatable({}, Shared)
	self.data = Data
	self.config = Config
	self.constants = Constants
	self.assets = Assets

	self.domain = Domain.new()
	self.infrastructure = Infrastructure.new()
	self.diContainer = self.infrastructure.diContainer
	self.remoteEventService = self.infrastructure.services.remoteEventService
	self.eventBus = self.infrastructure.eventBus

	self.application = Application.new(self.diContainer)

	return self
end

function Shared:init()
	self.infrastructure:init()
	self.application:init()
end

return Shared
