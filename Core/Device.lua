local Device = {}

local UserInputService = game:GetService("UserInputService")

function Device:GetType()
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		return "Mobile"
	end

	if UserInputService.TouchEnabled then
		return "Tablet"
	end

	return "PC"
end

function Device:GetScale()
	local device = self:GetType()

	if device == "Mobile" then
		return 0.75
	elseif device == "Tablet" then
		return 0.9
	end

	return 1
end

function Device:Apply(gui)
	local scale = Instance.new("UIScale")
	scale.Scale = self:GetScale()
	scale.Parent = gui

	return scale
end

return Device
