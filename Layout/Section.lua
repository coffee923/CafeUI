local Section = {}
Section.__index = Section

local Utility = require(script.Parent.Parent.Core.Utility)

function Section.new(tab, name)
	local self = setmetatable({}, Section)

	self.Tab = tab
	self.Name = name
	self.Elements = {}

	self.Frame = Utility:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 45),
		BackgroundColor3 = tab.Window.Theme.Panel,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0
	})

	self.Frame.Parent = tab.Container

	Utility:AddCorner(self.Frame, 12)
	Utility:AddStroke(
		self.Frame,
		tab.Window.Theme.Accent,
		0.5
	)

	self.Title = Utility:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 25),
		Position = UDim2.fromOffset(10, 5),
		Text = name,
		BackgroundTransparency = 1,
		TextColor3 = tab.Window.Theme.Text,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	self.Title.Parent = self.Frame

	return self
end


function Section:Add(element)
	table.insert(self.Elements, element)
end


function Section:CreateButton(config)
	local Button = require(script.Parent.Parent.Components.Button)

	return Button.new(self, config)
end


function Section:CreateToggle(config)
	local Toggle = require(script.Parent.Parent.Components.Toggle)

	return Toggle.new(self, config)
end


function Section:CreateSlider(config)
	local Slider = require(script.Parent.Parent.Components.Slider)

	return Slider.new(self, config)
end


function Section:CreateDropdown(config)
	local Dropdown = require(script.Parent.Parent.Components.Dropdown)

	return Dropdown.new(self, config)
end


return Section
