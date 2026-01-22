local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WeaponAssets = require(ReplicatedStorage.Shared.Assets).Weapons


local OneHanded = {
    Club = {
		name = "Club",
		image = "rbxassetid://108752402225500",
		model = WeaponAssets.OneHanded.Club,
		damage = 15,
		requirement = {
			stats = {
                strength = 10,
            },
            skills = {
                "swordFighter",
            },
			recipe = {
				Wood = 1,
			}
		},
		bonus = {},
		damageType = "hit",
		price = 10,
	},

	RustySword = {
		name = "Rusty Sword",
		image = "rbxassetid://107028418502150",
		model = WeaponAssets.OneHanded.RustySword,
		damage = 30,
		requirement = {
			stats = {
                strength = 60,
            },
			skills = {
				"swordFighter",
			},
			recipe = {
				Wood = 1,
				Iron = 1,
			}
		},
		bonus = {},
		damageType = "blade",
		price = 30,
	},

	AssassinDagger = {
		name = "Assassin's dagger",
		image = "rbxassetid://78093264551473",
		model = WeaponAssets.OneHanded.AssassinDagger,
		damage = 45,
		requirement = {
			stats = {
                strength = 90,
            },
			skills = {
				"swordFighter",
			},
			recipe = {
				Gold = 1,
				Iron = 2,
			}
		},
		bonus = {},
		damageType = "blade",
		price = 350,
	},

	Sword = {
		name = "Sword",
		image = "rbxassetid://76626568418896",
		model = WeaponAssets.OneHanded.Sword,
		damage = 50,
		requirement = {
			stats = {
                strength = 100,
            },
			skills = {
				"swordFighter",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		bonus = {},
		damageType = "blade",
		price = 50,
	},

	OrcSlayer = {
		name = "Orc Slayer",
		image = "rbxassetid://127955169217687",
		model = WeaponAssets.OneHanded.OrcSlayer,
		damage = 50,
		requirement = {
			stats = {
                strength = 100,
            },
			skills = {
				"swordFighter",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		bonus = {
			"orcSlayer",
		},
		damageType = "blade",
		price = 600,
	},

	Rapier = {
		name = "Rapier",
		image = "rbxassetid://87477214213303",
		model = WeaponAssets.OneHanded.Rapier,
		damage = 60,
		requirement = {
			stats = {
                dexterity = 120,
            },
			skills = {
				"swordFighter2",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		bonus = {},
		damageType = "blade",
		price = 800,
	},

	AssassinSword = {
		name = "Assassin's Sword",
		image = "rbxassetid://72367834015165",
		model = WeaponAssets.OneHanded.AssassinSword,
		damage = 70,
		requirement = {
			stats = {
                strength = 140,
            },
			skills = {
				"swordFighter2",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		bonus = {},
		damageType = "blade",
		price = 1250,
	},

	PaladinSword = {
		name = "Paladin's Sword",
		image = "rbxassetid://100950798211589",
		model = WeaponAssets.OneHanded.PaladinSword,
		damage = 80,
		requirement = {
			stats = {
                strength = 160,
            },
			skills = {
				"swordFighter2",
			},
		},
		bonus = {},
		damageType = "blade",
		price = 8000,
	},

	GreatSword = {
		name = "Great Sword",
		image = "rbxassetid://123341776606746",
		model = WeaponAssets.OneHanded.GreatSword,
		damage = 110,
		requirement = {
			stats = {
                strength = 220,
            },
			skills = {
				"swordFighter3",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		bonus = {},
		damageType = "blade",
		price = 30000,
	},
}
local TwoHanded = {
    BarbedClub = {
		name = "Barbed club",
		image = "rbxassetid://76964882407852",
		model = WeaponAssets.TwoHanded.BarbedClub,
		damage = 65,
		requirement = {
			stats = {
                strength = 130,
            },
			skills = {
				"heavyWeapon",
			},
		},
		damageType = "hit",
		price = 100,
	},

	Halberd = {
		name = "Halberd",
		image = "rbxassetid://133879961363701",
		model = WeaponAssets.TwoHanded.Halberd,
		damage = 70,
		requirement = {
			stats = {
                strength = 140,
            },
			skills = {
				"heavyWeapon",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		damageType = "blade",
		price = 700,
	},

	JaggedAxe = {
		name = "Jagged Axe",
		image = "rbxassetid://116080448306548",
		model = WeaponAssets.TwoHanded.JaggedAxe,
		damage = 80,
		requirement = {
			stats = {
                strength = 160,
            },
			skills = {
				"heavyWeapon",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		damageType = "blade",
		price = 7000,
	},

	Cleaver = {
		name = "Cleaver",
		image = "rbxassetid://83981418299449",
		model = WeaponAssets.TwoHanded.Cleaver,
		damage = 85,
		requirement = {
			stats = {
                strength = 170,
            },
			skills = {
				"heavyWeapon2",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		damageType = "blade",
		price = 10000,
	},

	Executioner = {
		name = "Executioner's Sword",
		image = "rbxassetid://131212985092577",
		model = WeaponAssets.TwoHanded.Executioner,
		damage = 110,
		requirement = {
			stats = {
                strength = 220,
            },
			skills = {
				"heavyWeapon2",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		damageType = "blade",
		price = 30000,
	},

	WarHammer = {
		name = "War Hammer",
		image = "rbxassetid://131910227086206",
		model = WeaponAssets.TwoHanded.WarHammer,
		damage = 120,
		requirement = {
			stats = {
                strength = 240,
            },
			skills = {
				"heavyWeapon3",
			},
			recipe = {
				Steel = 2,
				Iron = 2,
			}
		},
		damageType = "hit",
		price = 15000,
	},



	Mace = {
		name = "Mace",
		image = "rbxassetid://127068311362312",
		model = WeaponAssets.TwoHanded.Mace,
		damage = 259,
		requirement = {
			stats = {
                strength = 250,
            },
			skills = {
				"heavyWeapon3",
			},
			recipe = {
				Steel = 5,
				Iron = 10,
			}
		},
		bonus = {},
		damageType = "hit",
		price = 15000,
	},
}

---@class _requirement
---@field stats table<string, number>
---@field skills string[]

---@class WeaponData
---@field name string
---@field image string
---@field model Model
---@field damage number
---@field requirement _requirement
---@field bonus string[]
---@field damageType string
---@field price number

---@class WeaponsData
local Weapons = {
    OneHanded = OneHanded,
    TwoHanded = TwoHanded,
}

return Weapons