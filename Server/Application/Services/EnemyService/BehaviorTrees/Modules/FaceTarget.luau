local FaceTarget = {}
FaceTarget.__index = FaceTarget

function FaceTarget.new()
	return setmetatable({}, FaceTarget)
end

function FaceTarget:Run(enemy, context)
	local targetPart = context and context.target
	if not targetPart or not enemy.model or not enemy.model.PrimaryPart then
		return "FAILURE"
	end

	local root = enemy.model.PrimaryPart
	local align = root:FindFirstChild("FaceTargetAlign")

	if not align then
		warn("No FaceTargetAlign Found")
		return "FAILURE"
	end

	align.Enabled = true

	-- Set target orientation (look at player on same Y level)
	local lookAt =
		CFrame.lookAt(root.Position, Vector3.new(targetPart.Position.X, root.Position.Y, targetPart.Position.Z))
	align.CFrame = lookAt

	return "SUCCESS"
end

return FaceTarget
