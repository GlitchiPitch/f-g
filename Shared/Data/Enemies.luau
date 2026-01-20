local ReplicatedStorage = game:GetService("ReplicatedStorage")

local enemyAssets = require(ReplicatedStorage.Shared.Assets).Enemies

local enemyTemplates = {
	Dummy = {
		health = 100,
		speed = 16,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		attackAnimation = 115067823846471,

		model = enemyAssets.Dummy,
	},

	Orc = {
		health = 300,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 5, -- To prevent it from respawning, remove this line
		attackAnimation = 115067823846471,

		model = enemyAssets.Orc,
	},

	StrongOrc = {
		health = 80,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		attackAnimation = 115067823846471,

		model = enemyAssets.StrongOrc,
	},

	Goblin = {
		health = 80,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		attackAnimation = 115067823846471,

		model = enemyAssets.Goblin,
	},

	GoblinCommander = {
		health = 80,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		attackAnimation = 115067823846471,

		model = enemyAssets.GoblinCommander,
	},
}

return enemyTemplates
