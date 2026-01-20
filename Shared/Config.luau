---@class Config
local Config = {
	Client = {
		Control = {
			MainAction = Enum.UserInputType.MouseButton1,
			SecondAction = Enum.UserInputType.MouseButton2,
			RunKey = Enum.KeyCode.LeftShift,
			InventoryKey = Enum.KeyCode.E,
		},
		Camera = {
			zoom = 140,
			isometricFOV = 8,
			defaultFOV = 80,
		},
		TargetController = {
			range = 15, -- The range of the lock on
			speed = 20, -- The speed of which the lock on camera is moving
			offset = Vector3.new(3, 4, -9), -- The camera offset when using lock on
			lockOnPlayers = true, -- Lock on player in the world
			requiresLineOfSight = true, -- If the characer needs line of sight with target to use lock on.
		},
	},
}

return Config
