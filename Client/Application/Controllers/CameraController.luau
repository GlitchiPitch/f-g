local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

---@class CameraController
---@field player Player
---@field camera Camera
---@field _defaultCamera boolean
local CameraController = {}
CameraController.__index = CameraController

---@param diContainer DIContainer
---@return CameraController
function CameraController.new(diContainer)
	local self = setmetatable({}, CameraController)
	self.diContainer = diContainer

	--//Do not edit unless you know what you're doing//--
	self.player = game.Players.LocalPlayer
	-- self.mouse = self.player:GetMouse()
	self.camera = workspace.CurrentCamera
	self._mode = "isometric"
	-- First person camera attributes
	-- you can mess with these settings
	-- self.sensitivity = 0.6 -- anything higher would make looking up and down harder; recommend anything between 0~1
	-- self.smoothness = 0.05 -- recommend anything between 0~1
	-- self.headOffset = CFrame.new(-1, 0.7, 10) -- how far your camera is from your head

	-- self.angleX, self.targetAngleX = 0, 0
	-- self.angleY, self.targetAngleY = 0, 0

	-- self.camPos = Vector3.new(0, 0, 0)
	-- self.targetCamPos = Vector3.new(0, 0, 0)

	-- Occlusion transparency properties
	self.transparentParts = {} -- Parts currently made transparent
	self.lastTransparencyCheck = 0
	self.transparencyCheckInterval = 0.3 -- Check every 100ms for performance

	return self
end

function CameraController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.zoom = shared.config.Client.Camera.zoom
	self._isometricFOV = shared.config.Client.Camera.isometricFOV
	self._defaultFOV = shared.config.Client.Camera.defaultFOV

	self.camera.CameraType = Enum.CameraType.Custom
	self.character = self.player.Character or self.player.CharacterAdded:Wait()
	self.head = self.character:FindFirstChild("Head")
end

---@param mode "standard" | "static" | "isometric"
---@param data table
function CameraController:setCameraMode(mode, data)
	self._mode = mode

	if mode == "standard" then
		self.camera.CameraType = Enum.CameraType.Custom
	elseif mode == "static" then
		self:_setStaticCamera(data.cameraCFrame)
	elseif mode == "isometric" then
		self.camera.CameraType = Enum.CameraType.Scriptable
	end
end

function CameraController:onCharacterAdded()
	self.character = self.player.Character or self.player.CharacterAdded:Wait()
	self.head = self.character:FindFirstChild("Head")
end

function CameraController:onMouseMovement(input)
	local delta = Vector2.new(input.Delta.x / self.sensitivity, input.Delta.y / self.sensitivity) * self.smoothness

	local X = self.targetAngleX - delta.y
	self.targetAngleX = (X >= 80 and 80) or (X <= -80 and -80) or X
	self.targetAngleY = (self.targetAngleY - delta.x) % 360
end

function CameraController:update()
	if self.character then
		-- Only update camera for isometric mode; other modes have locked update loops
		if self._mode == "isometric" then
			self:_isometricCamera()
		end
	end
end

-- function CameraController:_firstPersonCamera()
-- 	self.camPos = self.camPos + (self.targetCamPos - self.camPos) * 0.2
-- 	self.angleX = self.angleX + (self.targetAngleX - self.angleX) * 0.3
-- 	local dist = self.targetAngleY - self.angleY
-- 	dist = math.abs(dist) > 180 and dist - (dist / math.abs(dist)) * 360 or dist
-- 	self.angleY = (self.angleY + dist * 0.3) % 360

-- 	self.camera.CFrame = CFrame.new(self.head.Position)
-- 		* CFrame.Angles(0, math.rad(self.angleY), 0)
-- 		* CFrame.Angles(math.rad(self.angleX), 0, 0)
-- 		* self.headOffset -- offset

-- end

function CameraController:_isometricCamera()
	if self.character:FindFirstChild("Head") then
		game:GetService("SoundService"):SetListener(Enum.ListenerType.ObjectCFrame, self.character.Head)
		local cameraPos = Vector3.new(
			self.character.Head.Position.X + self.zoom,
			self.character.Head.Position.Y + self.zoom,
			self.character.Head.Position.Z + self.zoom
		)
		self.camera.FieldOfView = self._isometricFOV
		self.camera.CFrame = CFrame.new(cameraPos, self.character.Head.Position)
		-- Handle occlusion transparency
		self:_handleOcclusionTransparency(cameraPos, self.character.Head.Position)
	end
end

---@param cameraCFrame CFrame
function CameraController:_setStaticCamera(cameraCFrame)
	self.camera.CameraType = Enum.CameraType.Scriptable

	local tween =
		TweenService:Create(self.camera, TweenInfo.new(0.5), { CFrame = cameraCFrame, FieldOfView = self._defaultFOV })
	tween:Play()
end

function CameraController:_handleOcclusionTransparency(cameraPos, targetPos)
	local currentTime = tick()
	if currentTime - self.lastTransparencyCheck < self.transparencyCheckInterval then
		return
	end

	self.lastTransparencyCheck = currentTime

	-- Cast ray from camera to player
	local direction = (targetPos - cameraPos).Unit
	local distance = (targetPos - cameraPos).Magnitude
	local raycastParams = RaycastParams.new()
	local ignoreInstances = { self.character }
	if workspace:FindFirstChild("Hunter") then
		table.insert(ignoreInstances, workspace.Hunter)
	end

	raycastParams.FilterDescendantsInstances = ignoreInstances -- Ignore player's own character
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude

	local raycastResult = workspace:Raycast(cameraPos, direction * distance, raycastParams)

	if raycastResult then
		local stepSize = 4 -- Check every 4 studs for performance
		local numSamples = math.ceil(distance / stepSize)
		local currentlyOccludingParts = {}

		-- Cast multiple rays along the path to find all occluding parts
		for i = 1, numSamples do
			local t = (i - 1) / (numSamples - 1) -- Interpolation parameter (0 to 1)
			local samplePos = cameraPos:Lerp(targetPos, t)
			local rayDirection = (targetPos - samplePos).Unit
			local rayDistance = math.min(stepSize, (targetPos - samplePos).Magnitude)
			local segmentResult = workspace:Raycast(samplePos, rayDirection * rayDistance, raycastParams)

			if
				segmentResult
				and segmentResult.Instance:IsA("BasePart")
				and not segmentResult.Instance:IsDescendantOf(self.character)
			then
				local part = segmentResult.Instance
				currentlyOccludingParts[part] = true

				if not self.transparentParts[part] then
					-- First time detecting this part as occluding - store its current transparency
					self.transparentParts[part] = {
						desiredTransparency = part.Transparency, -- Store what transparency should be when not occluding
						lastOccludingTime = currentTime,
					}
					-- Make part semitransparent
					part.Transparency = 0.8
				else
					-- Update last occluding time
					self.transparentParts[part].lastOccludingTime = currentTime
				end
			end
		end

		-- Restore transparency for parts that are no longer occluding
		for part, data in pairs(self.transparentParts) do
			if not currentlyOccludingParts[part] then
				-- Part is no longer occluding, restore its desired transparency
				if part:IsA("BasePart") then
					part.Transparency = data.desiredTransparency
				end
				self.transparentParts[part] = nil
			end
		end
	end
end

return CameraController
