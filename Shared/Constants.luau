---@class Constants
local Constants = {
	INIT_SERVER = "InitServer",
	EVENTS = {
		-- Controller → Service events
		FARM_SPAWN_FOOD = "farm_spawn_food",
		HUNTING_START = "hunting_start",
		HUNTING_STOP = "hunting_stop",
		LOOT_DESTROYED = "loot_destroyed",
		SPAWN_LOOT = "spawn_loot",

		-- Service → Controller events
		ENEMY_SPAWNED = "enemy_spawned",
		ENEMY_DIED = "enemy_died",
		ENEMY_UPDATE = "enemy_update",
		FOOD_EATEN = "food_eaten",
		PLAYER_UPDATE = "player_update",

		-- Service → Service events
		FARM_FOOD_CONSUMED = "farm_food_consumed",
		HUNTING_STATUS_CHANGED = "hunting_status_changed",
	},
	REMOTE_EVENTS = {
		USE_WEAPON = "UseWeapon",
		EQUIP_ITEM = "EquipItem",
		HUNTING_STARTED = "HuntingStarted",
		PECK = "Peck",
		FOOD_SPAWNED = "FoodSpawned",
		FOOD_EATEN = "FoodEaten",
		PLAYER_DIED = "PlayerDied",
		PLAYER_UPDATED = "PlayerUpdated",

		BREW_POTION = "BrewPotion",
		DRINK_POTION = "DrinkPotion",
		READ_RECIPE = "ReadRecipe",
		EAT_FOOD = "EatFood",
		CRAFT_ITEM = "CraftItem",
		ADD_ITEM_FOR_BREWING = "AddItemForBrewing",
		ADD_ITEM_FOR_CRAFTING = "AddItemForCrafting",
		RESET_CRAFTING = "ResetCrafting",
		QUEST_UPDATED = "QuestUpdated",
	},
	CLIENT_EVENTS = {
		TOGGLE_DIED_SCREEN = "toggleDiedScreen",
		INVENTORY_REFRESH = "inventoryRefresh",
		TOGGLE_ACTION_BUTTON = "toggleActionButton",
		TOGGLE_ALCHEMY = "toggleAlchemy",
		TOGGLE_INVENTORY = "toggleInventory",
		TOGGLE_CRAFT = "toggleCraft",
		READ_RECIPE = "readRecipe",
		ADD_ITEM_FOR_CRAFTING = "addItemForCrafting",
		ADD_ITEM_FOR_BREWING = "addItemForBrewing",
		RESET_CRAFTING = "resetCrafting",
		TOGGLE_SHOP = "ToggleShop",
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
		LAST_DAMAGER_USER_ID = "LastDamagerUserId",
	},
}

return Constants
