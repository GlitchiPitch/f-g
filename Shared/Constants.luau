---@class Constants
local Constants = {
	INIT_SERVER = "InitServer",
	REMOTE_EVENTS = {
		EQUIP_ITEM = "EquipItem",
		HUNTING_STARTED = "HuntingStarted",
		PECK = "Peck",
		FOOD_SPAWNED = "FoodSpawned",
		FOOD_EATEN = "FoodEaten",
		TOOL_ACTIVATED = "ToolActivated",
		PLAYER_DIED = "PlayerDied",
		PLAYER_UPDATED = "PlayerUpdated",

		BREW_POTION = "BrewPotion",
		CRAFT_ITEM = "CraftItem",
		ADD_ITEM_FOR_BREWING = "AddItemForBrewing",
		ADD_ITEM_FOR_CRAFTING = "AddItemForCrafting",
	},
	CLIENT_EVENTS = {
		TOGGLE_DIED_SCREEN = "toggleDiedScreen",
		INVENTORY_REFRESH = "inventoryRefresh",
		TOGGLE_ACTION_BUTTON = "toggleActionButton",
		TOGGLE_ALCHEMY = "toggleAlchemy",
		TOGGLE_INVENTORY = "toggleInventory",
		TOGGLE_CRAFT = "toggleCraft",
	},
	DAY_NIGHT = {
		-- Time constants (in minutes after midnight)
		DAWN_START = 6 * 60, -- 6:00 AM
		DAY_START = 7 * 60, -- 7:00 AM
		DUSK_START = 18 * 60, -- 6:00 PM
		NIGHT_START = 19 * 60, -- 7:00 PM

		-- Phase constants
		PHASES = {
			DAWN = "dawn",
			DAY = "day",
			DUSK = "dusk",
			NIGHT = "night",
		},

		-- Default cycle settings
		DEFAULT_DAY_LENGTH = 12, -- minutes
		DEFAULT_UPDATE_RATE = 1 / 15, -- seconds
	},

	TAGS = {
		INTERACT = "Interact",
	},
	ATTRIBUTES = {
		INTERACT_TYPE = "InteractType",
	},
}

return Constants
