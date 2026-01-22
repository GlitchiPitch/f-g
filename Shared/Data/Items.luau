local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Shared.Assets)

---@class ItemData
---@field name string
---@field image string
---@field model Model
---@field bonus table<string, number>
---@field price number
---@field recipe table<string, number>?

---@class ItemsData
local Items = {
	Apple = {
		name = "Apple",
		image = "rbxassetid://1234567890",
		model = Assets.Food.Apple,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Meat = {
		name = "Meat",
		image = "rbxassetid://1234567890",
		model = Assets.Food.Meat,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Banana = {
		name = "Banana",
		image = "rbxassetid://1234567890",
		model = Assets.Food.Banana,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Ham = {
		name = "Ham",
		image = "rbxassetid://1234567890",
		model = Assets.Food.Ham,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Rice = {
		name = "Rice",
		image = "rbxassetid://1234567890",
		model = Assets.Food.Rice,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Fish = {
		name = "Fish",
		image = "rbxassetid://1234567890",
		model = Assets.Food.Fish,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	PurpleFlower = {
		name = "Purple Flower",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Herbs.PurpleFlower,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	RedMushroom = {
		name = "Red Mushroom",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Herbs.RedMushroom,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	BlueMushroom = {
		name = "Blue Mushroom",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Herbs.BlueMushroom,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Chamomile = {
		name = "Chamomile",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Herbs.Chamomile,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	PurpleMushroom = {
		name = "Purple Mushroom",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Herbs.PurpleMushroom,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Poop = {
		name = "Poop",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Poop,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Water = {
		name = "Water",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Water,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	MoonStone = {
		name = "Moon Stone",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.MoonStone,
		bonus = {},
		price = 10,
	},
	Adurite = {
		name = "Adurite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Adurite,
		bonus = {},
		price = 10,
	},
	Aquamarine = {
		name = "Aquamarine",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Aquamarine,
		bonus = {},
		price = 10,
	},
	Calcite = {
		name = "Calcite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Calcite,
		bonus = {},
		price = 10,
	},
	Copper = {
		name = "Copper",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Copper,
		bonus = {},
		price = 10,
	},
	Crystal = {
		name = "Crystal",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Crystal,
		bonus = {},
		price = 10,
	},
	Emethyst = {
		name = "Emethyst",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Emethyst,
		bonus = {},
		price = 10,
	},
	Garnet = {
		name = "Garnet",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Garnet,
		bonus = {},
		price = 10,
	},
	Gold = {
		name = "Gold",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Gold,
		bonus = {},
		price = 10,
	},
	Iron = {
		name = "Iron",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Iron,
		bonus = {},
		price = 10,
	},
	Labrodorite = {
		name = "Labrodorite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Labrodorite,
		bonus = {},
		price = 10,
	},
	Magnetite = {
		name = "Magnetite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Magnetite,
		bonus = {},
		price = 10,
	},
	Obidian = {
		name = "Obidian",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Obidian,
		bonus = {},
		price = 10,
	},
	Ruby = {
		name = "Ruby",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Ruby,
		bonus = {},
		price = 10,
	},
	Sapphire = {
		name = "Sapphire",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Sapphire,
		bonus = {},
		price = 10,
	},
	Steel = {
		name = "Steel",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Steel,
		bonus = {},
		price = 10,
	},
	Stone = {
		name = "Stone",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Stone,
		bonus = {},
		price = 10,
	},
	Tanzanite = {
		name = "Tanzanite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Tanzanite,
		bonus = {},
		price = 10,
	},
	Citrine = {
		name = "Citrine",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Citrine,
		bonus = {},
		price = 10,
	},
	Emerald = {
		name = "Emerald",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Emerald,
		bonus = {},
		price = 10,
	},
	Turquose = {
		name = "Turquose",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ores.Turquose,
		bonus = {},
		price = 10,
	},
	Wood = {
		name = "Wood",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Wood,
		bonus = {},
		price = 10,
	},

	-- Weapon Recipes
	ClubRecipe = {
		name = "Club Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.ClubRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Wood = 1,
		},
	},
	RustySwordRecipe = {
		name = "Rusty Sword Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.RustySwordRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Wood = 1,
			Iron = 1,
		},
	},
	AssassinDaggerRecipe = {
		name = "Assassin's Dagger Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.AssassinDaggerRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Gold = 1,
			Iron = 2,
		},
	},
	SwordRecipe = {
		name = "Sword Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.SwordRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 2,
			Iron = 2,
		},
	},
	OrcSlayerRecipe = {
		name = "Orc Slayer Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.OrcSlayerRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 2,
			Iron = 2,
		},
	},
	RapierRecipe = {
		name = "Rapier Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.RapierRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 2,
			Iron = 2,
		},
	},
	AssassinSwordRecipe = {
		name = "Assassin's Sword Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.AssassinSwordRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 3,
			Iron = 5,
			Gold = 1,
		},
	},
	PaladinSwordRecipe = {
		name = "Paladin's Sword Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.PaladinSwordRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 10,
			Iron = 15,
			Gold = 5,
			Ruby = 2,
			Sapphire = 2,
			Emerald = 1,
			Crystal = 3,
		},
	},
	GreatSwordRecipe = {
		name = "Great Sword Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.GreatSwordRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 15,
			Iron = 20,
			Gold = 3,
			Ruby = 1,
		},
	},
	BarbedClubRecipe = {
		name = "Barbed Club Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.BarbedClubRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Wood = 5,
			Stone = 3,
			Iron = 2,
		},
	},
	HalberdRecipe = {
		name = "Halberd Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.HalberdRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 2,
			Iron = 2,
		},
	},
	JaggedAxeRecipe = {
		name = "Jagged Axe Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.JaggedAxeRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 8,
			Iron = 12,
			Stone = 5,
		},
	},
	CleaverRecipe = {
		name = "Cleaver Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.CleaverRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 10,
			Iron = 15,
			Gold = 2,
		},
	},
	ExecutionerRecipe = {
		name = "Executioner's Sword Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.ExecutionerRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 15,
			Iron = 20,
			Gold = 3,
			Ruby = 1,
			Obidian = 2,
		},
	},
	WarHammerRecipe = {
		name = "War Hammer Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.WarHammerRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 25,
			Iron = 30,
			Gold = 8,
			Ruby = 3,
			Sapphire = 3,
			Emerald = 2,
			Crystal = 5,
		},
	},
	MaceRecipe = {
		name = "Mace Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.MaceRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Steel = 12,
			Iron = 18,
			Gold = 3,
			Ruby = 1,
		},
	},

	-- Potion Recipes
	HealthPotionRecipe = {
		name = "Health Potion Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.HealthPotionRecipe,
		bonus = {},
		price = 0,
		recipe = {
			PurpleFlower = 1,
			Water = 1,
		},
	},
	ManaPotionRecipe = {
		name = "Mana Potion Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.ManaPotionRecipe,
		bonus = {},
		price = 0,
		recipe = {
			RedMushroom = 1,
			Water = 1,
		},
	},
	StaminaPotionRecipe = {
		name = "Stamina Potion Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.StaminaPotionRecipe,
		bonus = {},
		price = 0,
		recipe = {
			BlueMushroom = 1,
			Water = 1,
		},
	},
	SpeedPotionRecipe = {
		name = "Speed Potion Recipe",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Recipes.SpeedPotionRecipe,
		bonus = {},
		price = 0,
		recipe = {
			Chamomile = 1,
			Water = 1,
		},
	},
}

return Items
