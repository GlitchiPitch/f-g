local DeadOrAlive = require(script.DeadOrAlive)
local HideAndSeek = require(script.HideAndSeek)
local Tag = require(script.Tag)
local Bingo = require(script.Bingo)
local Lamp = require(script.Lamp)
---@class DeadlyGameManager
---@field deadOrAlive DeadOrAlive
---@field hideAndSeek HideAndSeek
---@field tag Tag
---@field bingo Bingo
---@field lamp Lamp
local DeadlyGameManager = {}
DeadlyGameManager.__index = DeadlyGameManager

---@param diContainer DIContainer
---@return DeadlyGameManager
function DeadlyGameManager.new(diContainer)
	local self = setmetatable({}, DeadlyGameManager)
	self.diContainer = diContainer
	self.deadOrAlive = DeadOrAlive.new(diContainer)
	self.hideAndSeek = HideAndSeek.new(diContainer)
	self.tag = Tag.new(diContainer)
	self.bingo = Bingo.new(diContainer)
	self.lamp = Lamp.new(diContainer)
	return self
end

function DeadlyGameManager:init()
	self.deadOrAlive:init()
	self.hideAndSeek:init()
	self.tag:init()
end

return DeadlyGameManager