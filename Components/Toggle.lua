local Toggle = {}
Toggle.__index = Toggle

local Utility = require(script.Parent.Parent.Core.Utility)

function Toggle.new(section, config)
	local self = setmetatable({}, Toggle)

	self.Name = config.Name or "Toggle"
	self.Value = config.Default or false
	self.Callback = config.Callback or function() end

	self.Frame = Utility:Create("TextButton", {
		Size = UDim2.new(1, -20, 0, 35),
		Position = UDim2.fromOffset(10, 0),
		Text = "",
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
		Size = UDim2.new(1, -60, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		Text = self.Name,
		BackgroundTransparency = 1,
		TextColor3 = section.Tab.Window.Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	self.Label.Parent = self.Frame

	self.Switch = Utility:Create("Frame", {
		Size = UDim2.fromOffset(35, 18),
		Position = UDim2.new(1, -45, 0.5, -9),
		BackgroundColor3 = section.Tab.Window.Theme.Accent,
		BorderSizePixel = 0
	})

	self.Switch.Parent = self.Frame

	Utility:AddCorner(self.Switch, 20)

	self.Frame.MouseButton1Click:Connect(function()
		self:Set(not self.Value)
	end)

	section:Add(self)

	return self
end

function Toggle:Set(value)
	self.Value = value

	self.Callback(value)
end

return Toggle
