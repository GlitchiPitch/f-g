local Lighting = game:GetService("Lighting")

---@class DayNightController
---@field diContainer DIContainer
---@field config DayNightConfig
---@field isRunning boolean
---@field isPaused boolean
---@field cycleTime number
---@field timeRatio number
---@field startTime number
---@field endTime number
---@field currentPhase "day" | "night"
---@field onPhaseChanged RBXScriptSignal
---@field onTimeUpdated RBXScriptSignal
---@field _heartbeatConnection RBXScriptConnection?
local DayNightService = {}
DayNightService.__index = DayNightService

---@class DayNightConfig
---@field dayLength number -- Length of a full day cycle in minutes (default: 12)
---@field startTime number -- Starting time in minutes after midnight (default: current lighting time)
---@field updateRate number -- How often to update time in seconds (default: 1/15)
local DEFAULT_CONFIG = {
	dayLength = 12,
	startTime = nil, -- Will be set to current lighting time if nil
	updateRate = 1 / 15,
}

---@param diContainer DIContainer
---@param config? DayNightConfig
---@return DayNightController
function DayNightService.new(diContainer, config)
	local self = setmetatable({}, DayNightService)
	self.diContainer = diContainer
	self.config = config or DEFAULT_CONFIG

	-- Set defaults for missing config values
	for key, value in DEFAULT_CONFIG do
		if self.config[key] == nil then
			self.config[key] = value
		end
	end

	self.isRunning = false
	self.isPaused = false
	self.currentPhase = "day"

	-- Create events
	self.onPhaseChanged = Instance.new("BindableEvent")
	self.onTimeUpdated = Instance.new("BindableEvent")

	

	return self
end

---@private
function DayNightService:_initializeCycle()
	local lighting = game:GetService("Lighting")
	local minutesInADay = 24 * 60

	-- Prevent division by zero
	if self.config.dayLength <= 0 then
		self.config.dayLength = 1
	end

	self.cycleTime = self.config.dayLength * 60
	self.timeRatio = minutesInADay / self.cycleTime

	-- Set initial time
	local initialMinutes = self.config.startTime or lighting:GetMinutesAfterMidnight()
	self.startTime = tick() - (initialMinutes / minutesInADay) * self.cycleTime
	self.endTime = self.startTime + self.cycleTime
end

function DayNightService:init()
	self:_initializeCycle()
end

function DayNightService:update()
	if self.isRunning then
		return
	end

	self.isRunning = true
	self.isPaused = false

	if self._heartbeatConnection then
		self._heartbeatConnection:Disconnect()
	end

	self:_updateTime()
end

function DayNightService:stop()
	self.isRunning = false
	self.isPaused = false

	if self._heartbeatConnection then
		self._heartbeatConnection:Disconnect()
		self._heartbeatConnection = nil
	end
end

function DayNightService:pause()
	self.isPaused = true
end

function DayNightService:resume()
	if self.isRunning then
		self.isPaused = false
	end
end

---@private
function DayNightService:_updateTime()
	local currentTime = tick()
	

	-- Check if we need to cycle to the next day
	if currentTime > self.endTime then
		self.startTime = self.endTime
		self.endTime = self.startTime + self.cycleTime
	end

	local minutesAfterMidnight = (currentTime - self.startTime) * self.timeRatio
	Lighting:SetMinutesAfterMidnight(minutesAfterMidnight)

	-- Check for phase changes (day/night)
	local newPhase = self:_getCurrentPhase(minutesAfterMidnight)
	if newPhase ~= self.currentPhase then
		local oldPhase = self.currentPhase
		self.currentPhase = newPhase
		self.onPhaseChanged:Fire(newPhase, oldPhase, minutesAfterMidnight)
	end

	-- Fire time update event
	self.onTimeUpdated:Fire(minutesAfterMidnight, self.currentPhase)
end

---@private
---@param minutesAfterMidnight number
---@return "day" | "night"
function DayNightService:_getCurrentPhase(minutesAfterMidnight)
	-- Consider it night between 6 PM (18:00) and 6 AM (6:00)
	local hour = minutesAfterMidnight / 60
	return (hour >= 18 or hour < 6) and "night" or "day"
end

---@return boolean
function DayNightService:isDay()
	return self.currentPhase == "day"
end

---@return boolean
function DayNightService:isNight()
	return self.currentPhase == "night"
end

---@return number
function DayNightService:getCurrentTime()
	local currentTime = tick()
	return (currentTime - self.startTime) * self.timeRatio
end

---@param minutesAfterMidnight number
function DayNightService:setTime(minutesAfterMidnight)
	local lighting = game:GetService("Lighting")
	lighting:SetMinutesAfterMidnight(minutesAfterMidnight)

	-- Recalculate cycle timing
	local minutesInADay = 24 * 60
	self.startTime = tick() - (minutesAfterMidnight / minutesInADay) * self.cycleTime
	self.endTime = self.startTime + self.cycleTime
end

function DayNightService:destroy()
	self:stop()
	self.onPhaseChanged:Destroy()
	self.onTimeUpdated:Destroy()
end

return DayNightService
