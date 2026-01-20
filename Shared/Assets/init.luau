---@class Assets
local Assets = {
	Lighting = require(script.Lighting),
	Potions = require(script.Potions),
	Animations = require(script.Animations),
	Enemies = require(script.Enemies),
	Weapons = require(script.Weapons),
	Food = require(script.Food),
	Items = require(script.Items),
	Hunter = script:FindFirstChild("Hunter"),
	PeckHitbox = script:FindFirstChild("PeckHitbox"),
	Seed = script:FindFirstChild("Seed"),
}

return Assets
