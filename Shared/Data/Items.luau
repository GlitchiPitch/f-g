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
}

return Items
