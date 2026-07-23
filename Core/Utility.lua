local Utility = {}

function Utility:Create(className, properties)
	local object = Instance.new(className)

	for property, value in pairs(properties or {}) do
		object[property] = value
	end

	return object
end

function Utility:AddCorner(object, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 12)
	corner.Parent = object

	return corner
end

function Utility:AddStroke(object, color, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(255, 255, 255)
	stroke.Transparency = transparency or 0.5
	stroke.Parent = object

	return stroke
end

function Utility:IsMobile()
	local UserInputService = game:GetService("UserInputService")

	return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

function Utility:GetScale()
	if self:IsMobile() then
		return 0.75
	end

	return 1
end

function Utility:MakeDraggable(frame, dragObject)
	local UserInputService = game:GetService("UserInputService")

	local dragging = false
	local dragStart
	local startPosition

	dragObject = dragObject or frame

	dragObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
			
			dragging = true
			dragStart = input.Position
			startPosition = frame.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (
			input.UserInputType == Enum.UserInputType.MouseMovement 
			or input.UserInputType == Enum.UserInputType.Touch
		) then

			local delta = input.Position - dragStart

			frame.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

return Utility
