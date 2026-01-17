---@class EventBus
---@field _events table<string, BindableEvent>
local EventBus = {}
EventBus.__index = EventBus

---@return EventBus
function EventBus.new()
	local self = setmetatable({}, EventBus)
	self._events = {}
	return self
end

---@param eventName string
---@return BindableEvent
function EventBus:getEvent(eventName)
	if not self._events[eventName] then
		self._events[eventName] = Instance.new("BindableEvent")
	end
	return self._events[eventName]
end


---@alias eventName string

---@param eventName eventName
---@param data any
function EventBus:fire(eventName, data)
	local event = self:getEvent(eventName)
	event:Fire(data)
end

---@param eventName eventName
---@param callback function
---@return RBXScriptConnection
function EventBus:connect(eventName, callback)
	local event = self:getEvent(eventName)
	return event.Event:Connect(callback)
end

---@param eventName string
function EventBus:disconnect(eventName)
	if self._events[eventName] then
		self._events[eventName]:Destroy()
		self._events[eventName] = nil
	end
end

return EventBus
