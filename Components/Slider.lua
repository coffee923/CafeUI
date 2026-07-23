local Slider = {}
Slider.__index = Slider

local Utility = require(script.Parent.Parent.Core.Utility)

function Slider.new(section, config)
	local self = setmetatable({}, Slider)

	self.Name = config.Name or "Slider"
	self.Min = config.Min or 0
	self.Max = config.Max or 100
	self.Value = config.Default or self.Min
	self.Callback = config.Callback or function() end

	self.Frame = Utility:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 55),
		Position = UDim2.fromOffset(10, 0),
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

	section:Add(self)

	return self
end

function Slider:Set(value)
	self.Value = math.clamp(value, self.Min, self.Max)

	self.Label.Text = self.Name .. ": " .. self.Value

	self.Callback(self.Value)
end

return Slider
