local Window = {}
Window.__index = Window

local Theme = require(script.Parent.Theme)
local Animation = require(script.Parent.Animation)
local Utility = require(script.Parent.Utility)

function Window.new(config)
	local self = setmetatable({}, Window)

	self.Title = config.Title or "CafeUI"
	self.Icon = config.Icon
	self.Theme = Theme:Get(config.Theme or "Coffee")
	self.Tabs = {}

	self.ScreenGui = Utility:Create("ScreenGui", {
		Name = "CafeUI",
		ResetOnSpawn = false
	})

	self.ScreenGui.Parent = game:GetService("CoreGui")

	self.Main = Utility:Create("Frame", {
		Size = UDim2.fromOffset(600, 400),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = self.Theme.Panel,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0
	})

	self.Main.Parent = self.ScreenGui

	Utility:AddCorner(self.Main, 12)
	Utility:AddStroke(
		self.Main,
		self.Theme.Accent,
		0.5
	)

	self.Top = Utility:Create("Frame", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1
	})

	self.Top.Parent = self.Main

	self.TitleLabel = Utility:Create("TextLabel", {
		Size = UDim2.new(1, -120, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		Text = self.Title,
		BackgroundTransparency = 1,
		TextColor3 = self.Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	self.TitleLabel.Parent = self.Top

	self.Minimize = self:CreateControl("-", 80)
	self.Maximize = self:CreateControl("+", 45)
	self.Close = self:CreateControl("x", 10)

	self.Close.MouseButton1Click:Connect(function()
		self:Destroy()
	end)

	self.Minimize.MouseButton1Click:Connect(function()
		self:MinimizeWindow()
	end)

	Utility:MakeDraggable(self.Main, self.Top)

	Animation:FadeIn(self.Main)

	return self
end


function Window:CreateControl(text, x)
	local button = Utility:Create("TextButton", {
		Size = UDim2.fromOffset(30, 30),
		Position = UDim2.new(1, -x, 0, 5),
		Text = text,
		BackgroundTransparency = 1,
		TextColor3 = self.Theme.Text,
		TextSize = 18
	})

	button.Parent = self.Top

	return button
end


function Window:CreateTab(name)
	local Tab = require(script.Parent.Parent.Layout.Tab)

	local tab = Tab.new(self, name)

	table.insert(self.Tabs, tab)

	return tab
end


function Window:Notify(config)
	local Notification = require(script.Parent.Parent.Components.Notification)

	Notification:Create(self, config)
end


function Window:MinimizeWindow()
	Animation:FadeOut(self.Main)
end


function Window:Destroy()
	self.ScreenGui:Destroy()
end


return Window
