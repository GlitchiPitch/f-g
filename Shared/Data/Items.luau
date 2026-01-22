local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Shared.Assets)

---@class ItemData
---@field name string
---@field image string
---@field model Model
---@field bonus table<string, number>
---@field price number

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
		model = Assets.Items.PurpleFlower,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	RedMushroom = {
		name = "Red Mushroom",
		image = "rbxassetid://1234567890",
		model = Assets.Items.RedMushroom,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	BlueMushroom = {
		name = "Blue Mushroom",
		image = "rbxassetid://1234567890",
		model = Assets.Items.BlueMushroom,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	Chamomile = {
		name = "Chamomile",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Chamomile,
		bonus = {
			health = 10,
		},
		price = 10,
	},
	PurpleMushroom = {
		name = "Purple Mushroom",
		image = "rbxassetid://1234567890",
		model = Assets.Items.PurpleMushroom,
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
		model = Assets.Items.MoonStone,
		bonus = {},
		price = 10,
	},
	Adurite = {
		name = "Adurite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Adurite,
		bonus = {},
		price = 10,
	},
	Aquamarine = {
		name = "Aquamarine",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Aquamarine,
		bonus = {},
		price = 10,
	},
	Calcite = {
		name = "Calcite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Calcite,
		bonus = {},
		price = 10,
	},
	Copper = {
		name = "Copper",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Copper,
		bonus = {},
		price = 10,
	},
	Crystal = {
		name = "Crystal",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Crystal,
		bonus = {},
		price = 10,
	},
	Emethyst = {
		name = "Emethyst",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Emethyst,
		bonus = {},
		price = 10,
	},
	Garnet = {
		name = "Garnet",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Garnet,
		bonus = {},
		price = 10,
	},
	Gold = {
		name = "Gold",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Gold,
		bonus = {},
		price = 10,
	},
	Iron = {
		name = "Iron",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Iron,
		bonus = {},
		price = 10,
	},
	Labrodorite = {
		name = "Labrodorite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Labrodorite,
		bonus = {},
		price = 10,
	},
	Magnetite = {
		name = "Magnetite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Magnetite,
		bonus = {},
		price = 10,
	},
	Obidian = {
		name = "Obidian",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Obidian,
		bonus = {},
		price = 10,
	},
	Ruby = {
		name = "Ruby",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Ruby,
		bonus = {},
		price = 10,
	},
	Sapphire = {
		name = "Sapphire",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Sapphire,
		bonus = {},
		price = 10,
	},
	Steel = {
		name = "Steel",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Steel,
		bonus = {},
		price = 10,
	},
	Stone = {
		name = "Stone",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Stone,
		bonus = {},
		price = 10,
	},
	Tanzanite = {
		name = "Tanzanite",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Tanzanite,
		bonus = {},
		price = 10,
	},
	Citrine = {
		name = "Citrine",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Citrine,
		bonus = {},
		price = 10,
	},
	Emerald = {
		name = "Emerald",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Emerald,
		bonus = {},
		price = 10,
	},
	Turquose = {
		name = "Turquose",
		image = "rbxassetid://1234567890",
		model = Assets.Items.Turquose,
		bonus = {},
		price = 10,
	},
}

return Items
