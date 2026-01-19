local BehaviorTree = require(script.Parent.BehaviorTree)
local Selector = require(script.Parent.Modules.Selector)
local Sequence = require(script.Parent.Modules.Sequence)
local CanSeePlayer = require(script.Parent.Modules.CanSeePlayer)
local MoveTo = require(script.Parent.Modules.MoveTo)
local FaceTarget = require(script.Parent.Modules.FaceTarget)
local Attack = require(script.Parent.Modules.Attack)
local Idle = require(script.Parent.Modules.Idle)

return function(damage, attackRange, sightRange, attackAnimation)
	local root = Selector.new({
		Sequence.new({
			CanSeePlayer.new(sightRange),
			MoveTo.new(attackRange),
			FaceTarget.new(),
			Attack.new(damage, attackRange, 0.8, attackAnimation),
		}),
		Idle.new(),
	})
	return BehaviorTree.new(root)
end
