local Tab = {}
Tab.__index = Tab

local Utility = require(script.Parent.Parent.Core.Utility)

function Tab.new(window, name)
	local self = setmetatable({}, Tab)

	self.Window = window
	self.Name = name

	self.Button = Utility:Create("TextButton", {
		Size = UDim2.fromOffset(120, 35),
		Text = name,
		BackgroundTransparency = 1,
		TextColor3 = window.Theme.Text,
		TextSize = 14
	})

	self.Button.Parent = window.Main

	self.Container = Utility:Create("Frame", {
		Size = UDim2.new(1, -20, 1, -70),
		Position = UDim2.fromOffset(10, 55),
		BackgroundTransparency = 1
	})

	self.Container.Parent = window.Main

	return self
end

function Tab:CreateSection(name)
	local Section = require(script.Parent.Section)

	return Section.new(self, name)
end

return Tab
