local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.Shared)
local ServerInfrastructure = require(script.Infrastructure)
local ServerApplication = require(script.Application)

---@class Server
---@field shared Shared
---@field infrastructure ServerInfrastructure
---@field application ServerApp
local Server = {}
Server.__index = Server

---@return Server
function Server.new()
	local self = setmetatable({}, Server)
	self.shared = Shared.new()
	self.infrastructure = ServerInfrastructure.new(self.shared.diContainer)
	self.application = ServerApplication.new(self.shared.diContainer)
	return self
end

function Server:init()
	self.shared.diContainer:singleton("Infrastructure", function()
		return self.infrastructure
	end)

	self.shared.diContainer:singleton("Application", function()
		return self.application
	end)

	self.shared.diContainer:singleton("Shared", function()
		return self.shared
	end)

	self.shared.diContainer:singleton("Domain", function()
		return self.shared.domain
	end)

	self.shared:init()
	self.infrastructure:init()
	self.application:init()

	ReplicatedStorage:SetAttribute(self.shared.constants.INIT_SERVER, true)
end

local server = Server.new()
server:init()
