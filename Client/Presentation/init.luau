local UI = require(script.UI)

---@class Presentation
---@field ui UI
---@field diContainer DIContainer
local Presentation = {}
Presentation.__index = Presentation

---@param diContainer DIContainer
---@return Presentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
	self.diContainer = diContainer
	self.ui = UI.new(self.diContainer)
	return self
end

function Presentation:init()
	self.ui:init()

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	shared.eventBus:connect(shared.constants.REMOTE_EVENTS.HUNTING_STARTED, function(eventData)
		self.ui:showNotification(eventData.data.targetBird)
	end)
	shared.eventBus:connect(shared.constants.REMOTE_EVENTS.FOOD_SPAWNED, function(eventData)
		self.ui:showNotification(eventData.data.message)
	end)
	shared.eventBus:connect(shared.constants.REMOTE_EVENTS.FOOD_EATEN, function(eventData)
		self.ui:showFoodEaten()
	end)
	shared.eventBus:connect(shared.constants.REMOTE_EVENTS.PLAYER_DIED, function(eventData)
		self.ui:showDiedScreen()
	end)
	shared.eventBus:connect("toggleInventory", function(eventData)
		self.ui:toggleInventory()
	end)

	shared.eventBus:connect("inventoryRefresh", function(eventData)
		self.ui:refreshInventory()
	end)
end

return Presentation
