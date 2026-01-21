local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Shared.Assets)

---@class potionBonus
---@field health number
---@field mana number
---@field stamina number
---@field speed number

---@class potionRequirements
---@field skills string[]
---@field recipe table<string, number>

---@class PotionData
---@field name string
---@field image string
---@field bonus potionBonus
---@field model Model
---@field requirements potionRequirements

---@class PotionsData
local Potions = {
	HealthPotion = {
		name = "Health Potion",
		image = "rbxassetid://1234567890",
		bonus = {
			health = 10,
		},

		requirements = {
			skills = {
				"Alchemy",
			},
			recipe = {
				PurpleFlower = 1,
				Water = 1,
			},
		},
		model = Assets.Potions.HealthPotion,
	},
	ManaPotion = {
		name = "Mana Potion",
		image = "rbxassetid://1234567890",
		bonus = {
			mana = 10,
		},
		requirements = {
			skills = {
				"Alchemy",
			},
			recipe = {
				RedMushroom = 1,
				Water = 1,
			},
		},
		model = Assets.Potions.ManaPotion,
	},
	StaminaPotion = {
		name = "Stamina Potion",
		image = "rbxassetid://1234567890",
		bonus = {
			stamina = 10,
		},
		requirements = {
			skills = {
				"Alchemy",
			},
			recipe = {
				BlueMushroom = 1,
				Water = 1,
			},
		},
		model = Assets.Potions.StaminaPotion,
	},
	SpeedPotion = {
		name = "Speed Potion",
		image = "rbxassetid://1234567890",
		bonus = {
			speed = 10,
		},
		requirements = {
			skills = {
				"Alchemy",
			},
			recipe = {
				Chamomile = 1,
				Water = 1,
			},
		},

		model = Assets.Potions.SpeedPotion,
	},
}

return Potions
