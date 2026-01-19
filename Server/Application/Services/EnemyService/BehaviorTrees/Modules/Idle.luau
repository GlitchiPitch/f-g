local Idle = {}
Idle.__index = Idle

function Idle.new()
	return setmetatable({}, Idle)
end

function Idle:Run(npc)
	-- Do nothing, maybe play an idle animation
	return "SUCCESS"
end

return Idle
