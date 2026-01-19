local Attack = {}
Attack.__index = Attack

function Attack.new(damage, range, cooldown, animationId)
	return setmetatable({
		damage = damage or 10,
		range = range or 5,
		cooldown = cooldown or 0.5,
		_lastAttackTime = 0,
		animationId = animationId, -- optional attack animation
	}, Attack)
end

---@param enemy EnemyEntity
---@param context table
---@return table
function Attack:Run(enemy, context)
	local currentTime = tick()
	local timeSinceLastAttack = currentTime - self._lastAttackTime

	-- Check if still in cooldown
	if timeSinceLastAttack < self.cooldown then
		return { status = "RUNNING", target = context and context.target }
	end

	local targetPart = context and context.target
	if not targetPart then
		return { status = "FAILURE" }
	end

	local char = targetPart.Parent
	local humanoid = char and char:FindFirstChild("Humanoid")
	if humanoid then
		local dist = (enemy.model.PrimaryPart.Position - targetPart.Position).Magnitude
		if dist <= self.range then
			-- Deal damage
			humanoid:TakeDamage(self.damage)
			enemy:attack()

			-- Set cooldown timer
			self._lastAttackTime = currentTime

			return { status = "SUCCESS", target = targetPart }
		end
	end

	return { status = "FAILURE", target = targetPart }
end

return Attack
