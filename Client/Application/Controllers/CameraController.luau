local RunService = game:GetService("RunService")

---@class CameraController
local CameraController = {}
CameraController.__index = CameraController

---@param diContainer DIContainer
---@return CameraController
function CameraController.new(diContainer)
	local self = setmetatable({}, CameraController)
	self.diContainer = diContainer
	self.zoom = 140
	self.fieldOfView = 7

	--//Do not edit unless you know what you're doing//--
	self.player = game.Players.LocalPlayer
	self.mouse = self.player:GetMouse()
	self.camera = workspace.CurrentCamera

	-- Occlusion transparency properties
	self.transparentParts = {} -- Parts currently made transparent
	self.lastTransparencyCheck = 0
	self.transparencyCheckInterval = 0.1 -- Check every 100ms for performance

	return self
end

function CameraController:init()
	local function onRender()
		self:_onRender()
	end

	self.camera.CameraType = Enum.CameraType.Custom
	self.character = self.player.Character or self.player.CharacterAdded:Wait()

	RunService.RenderStepped:Connect(onRender)
end

function CameraController:_onRender(_)
	self.camera.FieldOfView = self.fieldOfView
	if self.character then
		if self.character:FindFirstChild("Head") then
			game:GetService("SoundService"):SetListener(Enum.ListenerType.ObjectCFrame, self.character.Head)
			local cameraPos = Vector3.new(
				self.character.Head.Position.X + self.zoom,
				self.character.Head.Position.Y + self.zoom,
				self.character.Head.Position.Z + self.zoom
			)
			self.camera.CFrame = CFrame.new(cameraPos, self.character.Head.Position)

			-- Handle occlusion transparency
			self:_handleOcclusionTransparency(cameraPos, self.character.Head.Position)
		end
	end
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
	raycastParams.FilterDescendantsInstances = { self.character } -- Ignore player's own character
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude

	local raycastResult = workspace:Raycast(cameraPos, direction * distance, raycastParams)

	if raycastResult then
		local currentPos = cameraPos
		local stepSize = 4 -- Check every 4 studs for performance
		local currentlyOccludingParts = {}

		-- Cast multiple rays along the path to find all occluding parts
		while (targetPos - currentPos).Magnitude > stepSize do
			local segmentDirection = (targetPos - currentPos).Unit
			local segmentDistance = math.min(stepSize, (targetPos - currentPos).Magnitude)
			local segmentResult = workspace:Raycast(currentPos, segmentDirection * segmentDistance, raycastParams)

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
					part.Transparency = 0.5
				else
					-- Update last occluding time
					self.transparentParts[part].lastOccludingTime = currentTime
					-- Ensure it stays semitransparent while occluding
					if part.Transparency > 0.5 then
						part.Transparency = 0.5
					end
				end
			end

			currentPos = currentPos + segmentDirection * segmentDistance
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
