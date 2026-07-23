local Button = {}
Button.__index = Button

local Utility = require(script.Parent.Parent.Core.Utility)
local Animation = require(script.Parent.Parent.Core.Animation)

function Button.new(section, config)
	local self = setmetatable({}, Button)

	self.Name = config.Name or "Button"
	self.Callback = config.Callback or function() end

	self.Frame = Utility:Create("TextButton", {
		Size = UDim2.new(1, -20, 0, 35),
		Position = UDim2.fromOffset(10, 0),
		Text = self.Name,
		BackgroundColor3 = section.Tab.Window.Theme.Panel,
		BackgroundTransparency = 0.25,
		TextColor3 = section.Tab.Window.Theme.Text,
		TextSize = 14,
		BorderSizePixel = 0
	})

	self.Frame.Parent = section.Frame

	Utility:AddCorner(self.Frame, 10)
	Utility:AddStroke(
		self.Frame,
		section.Tab.Window.Theme.Accent,
		0.5
	)

	self.Frame.MouseButton1Click:Connect(function()
		self.Callback()
	end)

	self.Frame.MouseEnter:Connect(function()
		Animation:FadeIn(self.Frame)
	end)

	section:Add(self)

	return self
end

return Button
