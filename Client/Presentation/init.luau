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

	local eventHandlers = {
		[shared.constants.REMOTE_EVENTS.HUNTING_STARTED] = function(eventData)
			self.ui:showNotification(eventData.data.targetBird)
		end,
		[shared.constants.REMOTE_EVENTS.FOOD_SPAWNED] = function(eventData)
			self.ui:showNotification(eventData.data.message)
		end,
		[shared.constants.REMOTE_EVENTS.FOOD_EATEN] = function(eventData)
			self.ui:showFoodEaten()
		end,
		[shared.constants.CLIENT_EVENTS.TOGGLE_DIED_SCREEN] = function(eventData)
			if eventData.state then
				shared.services.soundService:playSound("YouDied")
			end
			self.ui:toggleDiedScreen(eventData.state)
		end,
		[shared.constants.CLIENT_EVENTS.TOGGLE_INVENTORY] = function(eventData)
			self.ui:toggleInventory()
		end,
		[shared.constants.CLIENT_EVENTS.INVENTORY_REFRESH] = function(eventData)
			self.ui:refreshInventory()
		end,
		[shared.constants.CLIENT_EVENTS.TOGGLE_ACTION_BUTTON] = function(eventData)
			self.ui:toggleActionButton(eventData.state)
		end,
		[shared.constants.CLIENT_EVENTS.TOGGLE_ALCHEMY] = function(eventData)
			self.ui:toggleAlchemy(eventData.state)
		end,
		[shared.constants.CLIENT_EVENTS.TOGGLE_CRAFT] = function(eventData)
			self.ui:toggleCraft(eventData.state)
		end,
		[shared.constants.CLIENT_EVENTS.READ_RECIPE] = function(eventData)
			self.ui:toggleRecipe(eventData.recipe)
		end,
		[shared.constants.CLIENT_EVENTS.ADD_ITEM_FOR_CRAFTING] = function(eventData)
			self.ui:addItemForCrafting(eventData.item)
		end,
		[shared.constants.CLIENT_EVENTS.ADD_ITEM_FOR_BREWING] = function(eventData)
			self.ui:addItemForBrewing(eventData.item)
		end,
		[shared.constants.CLIENT_EVENTS.RESET_CRAFTING] = function(eventData)
			self.ui:resetCrafting()
		end,
	}

	for eventName, handler in pairs(eventHandlers) do
		shared.eventBus:connect(eventName, handler)
	end
end

return Presentation
