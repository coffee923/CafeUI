local Slider = {}
Slider.__index = Slider

local Utility = require(script.Parent.Parent.Core.Utility)

local UserInputService = game:GetService("UserInputService")

function Slider.new(section, config)
	local self = setmetatable({}, Slider)

	self.Name = config.Name or "Slider"
	self.Min = config.Min or 0
	self.Max = config.Max or 100
	self.Value = config.Default or self.Min
	self.Callback = config.Callback or function() end

	self.Frame = Utility:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 55),
		BackgroundColor3 = section.Tab.Window.Theme.Panel,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0
	})

	self.Frame.Parent = section.Frame

	Utility:AddCorner(self.Frame, 10)
	Utility:AddStroke(
		self.Frame,
		section.Tab.Window.Theme.Accent,
		0.5
	)

	self.Label = Utility:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 25),
		Position = UDim2.fromOffset(10, 5),
		Text = self.Name .. ": " .. self.Value,
		BackgroundTransparency = 1,
		TextColor3 = section.Tab.Window.Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	self.Label.Parent = self.Frame

	self.Bar = Utility:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 6),
		Position = UDim2.fromOffset(10, 38),
		BackgroundColor3 = section.Tab.Window.Theme.Accent,
		BorderSizePixel = 0
	})

	self.Bar.Parent = self.Frame
	Utility:AddCorner(self.Bar, 10)

	self.Knob = Utility:Create("Frame", {
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new(0, 0, 0.5, -8),
		BackgroundColor3 = section.Tab.Window.Theme.Text,
		BorderSizePixel = 0
	})

	self.Knob.Parent = self.Bar
	Utility:AddCorner(self.Knob, 20)

	self.Dragging = false

	local function update(input)
		local percent = math.clamp(
			(input.Position.X - self.Bar.AbsolutePosition.X) / self.Bar.AbsoluteSize.X,
			0,
			1
		)

		self:Set(
			math.floor(
				self.Min + ((self.Max - self.Min) * percent)
			)
		)

		self.Knob.Position = UDim2.new(
			percent,
			-8,
			0.5,
			-8
		)
	end

	self.Knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			self.Dragging = true
		end
	end)

	self.Bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			self.Dragging = true
			update(input)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if self.Dragging and (
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then
			update(input)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			self.Dragging = false
		end
	end)

	section:Add(self)

	return self
end

function Slider:Set(value)
	self.Value = math.clamp(value, self.Min, self.Max)

	self.Label.Text = self.Name .. ": " .. self.Value

	self.Callback(self.Value)
end

return Slider
