local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = require(ReplicatedStorage.Shared)
local Presentation = require(script.Presentation)
local Application = require(script.Application)
local Infrastructure = require(script.Infrastructure)

---@class ShopClient
---@field shared Shared
---@field application ClientApp
---@field presentation Presentation
---@field infrastructure ServerInfrastructure
local Client = {}
Client.__index = Client

---@return ShopClient
function Client.new()
	local self = setmetatable({}, Client)
	self.shared = Shared.new()
	self.application = Application.new(self.shared.diContainer)
	self.presentation = Presentation.new(self.shared.diContainer)
	self.infrastructure = Infrastructure.new(self.shared.diContainer)
	return self
end

function Client:init()
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
	
	self.shared.diContainer:singleton("Presentation", function()
		return self.presentation
	end)

	self.shared:init()
	self.infrastructure:init()
	self.application:init()
	self.presentation:init()
end

local client = Client.new()

if ReplicatedStorage:GetAttribute(client.shared.constants.INIT_SERVER) then
	client:init()
else
	ReplicatedStorage:GetAttributeChangedSignal(client.shared.constants.INIT_SERVER):Connect(function()
		client:init()
	end)
end
