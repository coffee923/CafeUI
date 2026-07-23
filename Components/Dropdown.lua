local Dropdown = {}
Dropdown.__index = Dropdown

local Utility = require(script.Parent.Parent.Core.Utility)

function Dropdown.new(section, config)
	local self = setmetatable({}, Dropdown)

	self.Name = config.Name or "Dropdown"
	self.Options = config.Options or {}
	self.Value = config.Default or self.Options[1]
	self.Callback = config.Callback or function() end

	self.Open = false

	self.Frame = Utility:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 40),
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

	self.Button = Utility:Create("TextButton", {
		Size = UDim2.fromScale(1, 1),
		Text = self.Name .. ": " .. tostring(self.Value),
		BackgroundTransparency = 1,
		TextColor3 = section.Tab.Window.Theme.Text,
		TextSize = 14
	})

	self.Button.Parent = self.Frame

	self.List = Utility:Create("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.fromOffset(0, 42),
		BackgroundColor3 = section.Tab.Window.Theme.Panel,
		BackgroundTransparency = 0.25,
		ClipsDescendants = true,
		BorderSizePixel = 0
	})

	self.List.Parent = section.Frame

	Utility:AddCorner(self.List, 10)

	for _, option in ipairs(self.Options) do
		local item = Utility:Create("TextButton", {
			Size = UDim2.new(1, 0, 0, 30),
			Text = option,
			BackgroundTransparency = 1,
			TextColor3 = section.Tab.Window.Theme.Text,
			TextSize = 14
		})

		item.Parent = self.List

		item.MouseButton1Click:Connect(function()
			self:Set(option)
			self:Close()
		end)
	end

	self.Button.MouseButton1Click:Connect(function()
		self.Open = not self.Open
		self.List.Size = self.Open 
			and UDim2.new(1, 0, 0, #self.Options * 30)
			or UDim2.new(1, 0, 0, 0)
	end)

	section:Add(self)

	return self
end

function Dropdown:Set(value)
	self.Value = value
	self.Button.Text = self.Name .. ": " .. tostring(value)

	self.Callback(value)
end

function Dropdown:Close()
	self.Open = false
	self.List.Size = UDim2.new(1, 0, 0, 0)
end

return Dropdown
