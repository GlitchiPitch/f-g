---@class Cache
local Cache = {}
Cache.__index = Cache

---@return Cache
function Cache.new()
	local self = setmetatable({}, Cache)
	self.objects = {}
	return self
end

function Cache:addObjectToCache(object)
	self.objects[object.Name] = object
	object.Parent = script
end

function Cache:removeObjectFromCache(object)
	self.objects[object.Name] = nil
	object:Destroy()
end

function Cache:getObjectFromCache(name)
	local object = self.objects[name]
	self.objects[name] = nil
	return object
end

return Cache
