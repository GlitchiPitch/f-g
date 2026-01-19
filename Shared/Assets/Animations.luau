local Animations = {
	-- OneHandedIdle2 = "rbxassetid://128930183986958",
	-- TwoHandedIdle = "rbxassetid://106578561265820",
	OneHandedIdle = "rbxassetid://100181506747690",
	-- OneHandedBlock = "rbxassetid://136984402984617",
	
	OneHandednSlash4 = "rbxassetid://126196507780353",
	OneHandednSlash3 = "rbxassetid://81015824428875",
	OneHandednSlash2 = "rbxassetid://104768333882922",
	OneHandednSlash1 = "rbxassetid://139584385828298", -- old "rbxassetid://75685844155538",
	EquipOneHanded = "rbxassetid://87631037703929",
	Peck = "rbxassetid://89696184559939",
	-- Eat = "rbxassetid://115354805353614",
	-- Walk = "rbxassetid://138456918929926",
	Run = "rbxassetid://180426354",
	Idle = "rbxassetid://180435571",
}

for i, v in Animations do
	local animation = Instance.new("Animation")
	animation.AnimationId = v
	Animations[i] = animation
end

return Animations
