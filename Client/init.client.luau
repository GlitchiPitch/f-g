local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = require(ReplicatedStorage.Shared)
local Presentation = require(script.Presentation)
local Application = require(script.Application)

---@class ShopClient
---@field shared Shared
---@field application Application
---@field presentation Presentation
local Client = {}
Client.__index = Client

---@return ShopClient
function Client.new()
	local self = setmetatable({}, Client)
	self.shared = Shared.new()
	self.application = Application.new(self.shared.diContainer)
	self.presentation = Presentation.new(self.shared.diContainer)
	return self
end

function Client:init()
	self.shared:init()
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
