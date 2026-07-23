local Animation = {}

Animation.Enabled = true

Animation.Settings = {
    Duration = 0.25,
    Style = Enum.EasingStyle.Quad,
    Direction = Enum.EasingDirection.Out
}

function Animation:FadeIn(object)
    if not object then return end

    object.Visible = true
    object.BackgroundTransparency = 1

    local TweenService = game:GetService("TweenService")

    TweenService:Create(
        object,
        TweenInfo.new(
            self.Settings.Duration,
            self.Settings.Style,
            self.Settings.Direction
        ),
        {
            BackgroundTransparency = 0
        }
    ):Play()
end

function Animation:FadeOut(object)
    if not object then return end

    local TweenService = game:GetService("TweenService")

    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            self.Settings.Duration,
            self.Settings.Style,
            self.Settings.Direction
        ),
        {
            BackgroundTransparency = 1
        }
    )

    tween:Play()

    tween.Completed:Connect(function()
        object.Visible = false
    end)
end

return Animation
