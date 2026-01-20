---@class Constants
local Constants = {
	INIT_SERVER = "InitServer",
	REMOTE_EVENTS = {
		HUNTING_STARTED = "HuntingStarted",
		PECK = "Peck",
		FOOD_SPAWNED = "FoodSpawned",
		FOOD_EATEN = "FoodEaten",
		TOOL_ACTIVATED = "ToolActivated",
		PLAYER_DIED = "PlayerDied",
		PLAYER_UPDATED = "PlayerUpdated",
		BREW_POTION = "BrewPotion",
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
}

return Constants
