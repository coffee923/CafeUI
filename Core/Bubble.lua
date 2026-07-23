local Bubble = {}
Bubble.__index = Bubble

local Utility = require(script.Parent.Utility)
local Animation = require(script.Parent.Animation)

function Bubble.new(window)
	local self = setmetatable({}, Bubble)

	self.Window = window

	self.Frame = Utility:Create("ImageButton", {
		Size = UDim2.fromOffset(55, 55),
		Position = UDim2.new(1, -80, 1, -100),
		BackgroundColor3 = window.Theme.Panel,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		Image = window.Icon or ""
	})

	self.Frame.Parent = window.ScreenGui

	Utility:AddCorner(self.Frame, 50)
	Utility:AddStroke(
		self.Frame,
		window.Theme.Accent,
		0.5
	)

	Utility:MakeDraggable(self.Frame, self.Frame)

	self.Frame.MouseButton1Click:Connect(function()
		self:Restore()
	end)

	self.Frame.Visible = false

	return self
end

function Bubble:Show()
	self.Frame.Visible = true
	Animation:FadeIn(self.Frame)
end

function Bubble:Hide()
	Animation:FadeOut(self.Frame)
end

function Bubble:Restore()
	self:Hide()

	task.wait(Animation.Settings.Duration)

	self.Window.Main.Visible = true
	Animation:FadeIn(self.Window.Main)
end

return Bubble
