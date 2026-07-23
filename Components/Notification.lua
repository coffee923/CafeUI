local Notification = {}

local Utility = require(script.Parent.Parent.Core.Utility)
local Animation = require(script.Parent.Parent.Core.Animation)

function Notification:Create(window, config)
	config = config or {}

	local title = config.Title or "CafeUI"
	local text = config.Content or ""
	local duration = config.Duration or 3

	local frame = Utility:Create("Frame", {
		Size = UDim2.fromOffset(300, 80),
		Position = UDim2.new(1, -320, 1, -100),
		BackgroundColor3 = window.Theme.Panel,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0
	})

	frame.Parent = window.ScreenGui

	Utility:AddCorner(frame, 12)
	Utility:AddStroke(
		frame,
		window.Theme.Accent,
		0.5
	)

	local titleLabel = Utility:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 25),
		Position = UDim2.fromOffset(10, 5),
		Text = title,
		BackgroundTransparency = 1,
		TextColor3 = window.Theme.Text,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	titleLabel.Parent = frame

	local contentLabel = Utility:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 35),
		Position = UDim2.fromOffset(10, 32),
		Text = text,
		BackgroundTransparency = 1,
		TextColor3 = window.Theme.Text,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	contentLabel.Parent = frame

	Animation:FadeIn(frame)

	task.delay(duration, function()
		Animation:FadeOut(frame)

		task.wait(Animation.Settings.Duration)

		frame:Destroy()
	end)
end

return Notification
