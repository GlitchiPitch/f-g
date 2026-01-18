local OneHanded = {
	Club = script.OneHanded:FindFirstChild("Club"),
	RustySword = script.OneHanded:FindFirstChild("RustySword"),
	AssassinDagger = script.OneHanded:FindFirstChild("AssassinDagger"),
	Sword = script.OneHanded:FindFirstChild("Sword"),
	OrcSlayer = script.OneHanded:FindFirstChild("OrcSlayer"),
	Rapier = script.OneHanded:FindFirstChild("Rapier"),
	AssassinSword = script.OneHanded:FindFirstChild("AssassinSword"),
	PaladinSword = script.OneHanded:FindFirstChild("PaladinSword"),
	GreatSword = script.OneHanded:FindFirstChild("GreatSword"),
}

local TwoHanded = {
	BarbedClub = script.TwoHanded:FindFirstChild("BarbedClub"),
	Halberd = script.TwoHanded:FindFirstChild("Halberd"),
	JaggedAxe = script.TwoHanded:FindFirstChild("JaggedAxe"),
	Cleaver = script.TwoHanded:FindFirstChild("Cleaver"),
	Executioner = script.TwoHanded:FindFirstChild("Executioner"),
	WarHammer = script.TwoHanded:FindFirstChild("WarHammer"),
	Mace = script.TwoHanded:FindFirstChild("Mace"),
}

local Weapons = {
	OneHanded = OneHanded,
	TwoHanded = TwoHanded,
}

---@param weaponName string
---@return Tool?
function Weapons:getWeaponTool(weaponName)
	local weapon = self.OneHanded[weaponName] or self.TwoHanded[weaponName]
	if weapon then
		return weapon:Clone()
	end
	return
end

return Weapons
