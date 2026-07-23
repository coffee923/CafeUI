local CafeUI = {}

CafeUI.Version = "1.0"

CafeUI.Theme = require(script.Core.Theme)
CafeUI.Animation = require(script.Core.Animation)
CafeUI.Utility = require(script.Core.Utility)
CafeUI.Device = require(script.Core.Device)

CafeUI.Components = require(script.Components.Init)
CafeUI.Layout = require(script.Layout.Init)

function CafeUI:CreateWindow(config)
	local Window = require(script.Core.Window)

	return Window.new(config or {})
end

function CafeUI:SetTheme(theme)
	self.Theme:Set(theme)
end

function CafeUI:GetTheme(theme)
	return self.Theme:Get(theme)
end

function CafeUI:Notify(window, config)
	if window then
		local Notification = self.Components.Notification
		Notification:Create(window, config)
	end
end

return CafeUI
