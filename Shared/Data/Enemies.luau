local ss = game:GetService("ServerStorage")
local enemyFolder = ss:WaitForChild("Enemies")

local enemyTemplates = {
	Dummy = {
		health = 100,
		speed = 16,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		--attackAnimation = 115067823846471, (Uncomment this an add your own attack aninamation)
		
		model = enemyFolder.Dummy
	},
	
	Orc = {
		health = 80,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		--attackAnimation = 115067823846471, (Uncomment this an add your own attack aninamation)

		model = enemyFolder.Orc
	},
	
	StrongOrc = {
		health = 80,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		--attackAnimation = 115067823846471, (Uncomment this an add your own attack aninamation)

		model = enemyFolder["Strong Orc"],
	},
	
	Goblin = {
		health = 80,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		--attackAnimation = 115067823846471, (Uncomment this an add your own attack aninamation)

		model = enemyFolder.Goblin,
	},
	
	GoblinCommander = {
		health = 80,
		speed = 12,
		damage = 5,
		attackRange = 5,
		sightRange = 50,
		respawnTime = 20, -- To prevent it from respawning, remove this line
		--attackAnimation = 115067823846471, (Uncomment this an add your own attack aninamation)

		model = enemyFolder["Goblin Commander"],
	},
}

return enemyTemplates
