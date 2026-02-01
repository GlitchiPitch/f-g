---@class QuestDefinition
---@field id string
---@field name string
---@field description string
---@field goal number
---@field type "collect_food" | "kill_enemies" | "play_time"

---@type QuestDefinition[]
local Quest = {
	{
		id = "collect_food",
		name = "Collect Food",
		description = "Collect food",
		goal = 5,
		type = "collect_food",
	},
	{
		id = "kill_enemies",
		name = "Kill Enemies",
		description = "Kill enemies",
		goal = 5,
		type = "kill_enemies",
	},
	{
		id = "play_time",
		name = "Play Time",
		description = "Spend time in the game",
		goal = 60,
		type = "play_time",
	},
}

return Quest
