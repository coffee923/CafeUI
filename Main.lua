local CafeUI = {}

CafeUI.Version = "1.0"

function CafeUI:CreateWindow(config)
	local Window = require(script.Core.Window)

	return Window.new(config or {})
end

function CafeUI:GetTheme()
	return require(script.Core.Theme)
end

function CafeUI:Notify(window, config)
	local Notification = require(script.Components.Notification)

	Notification:Create(window, config)
end

return CafeUI
