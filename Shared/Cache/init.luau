---@class Cache
local Cache = {}
Cache.__index = Cache

---@return Cache
function Cache.new()
	local self = setmetatable({}, Cache)
	self.objects = {}
	return self
end

---@param object Instance
function Cache:addObjectToCache(object)
	self.objects[object.Name] = object
	object.Parent = script
end

---@param objectName string
function Cache:removeObjectFromCache(objectName)
	local _object = self.objects[objectName]
	if _object then
		self.objects[objectName] = nil
		_object:Destroy()
	end
end

---@param objectNames string[]
function Cache:removeObjectsFromCache(objectNames)
	warn("removeObjectsFromCache", objectNames)
	for _, objectName in objectNames do
		self:removeObjectFromCache(objectName)
	end
end

---@param objectName string
function Cache:getObjectFromCache(objectName)
	local object = self.objects[objectName]
	if object then
		self.objects[objectName] = nil
		return object
	end
	return nil
end

return Cache
