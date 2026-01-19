---@class Assets
local Assets = {
	Lighting = require(script.Lighting),
	Animations = require(script.Animations),
	Weapons = require(script.Weapons),
	Food = require(script.Food),
	Hunter = script:FindFirstChild("Hunter"),
	PeckHitbox = script:FindFirstChild("PeckHitbox"),
	Seed = script:FindFirstChild("Seed"),
}

return Assets
