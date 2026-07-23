local Theme = {}

Theme.Current = "Coffee"

Theme.List = {
    Coffee = {
        Background = Color3.fromRGB(35, 22, 15),
        Panel = Color3.fromRGB(55, 35, 25),
        Accent = Color3.fromRGB(181, 125, 70),
        Text = Color3.fromRGB(245, 235, 220)
    },

    Mocha = {
        Background = Color3.fromRGB(30, 18, 15),
        Panel = Color3.fromRGB(65, 40, 30),
        Accent = Color3.fromRGB(150, 95, 55),
        Text = Color3.fromRGB(240, 225, 210)
    },

    Espresso = {
        Background = Color3.fromRGB(18, 12, 10),
        Panel = Color3.fromRGB(40, 25, 20),
        Accent = Color3.fromRGB(210, 160, 90),
        Text = Color3.fromRGB(250, 240, 225)
    },

    Caramel = {
        Background = Color3.fromRGB(45, 30, 20),
        Panel = Color3.fromRGB(90, 60, 35),
        Accent = Color3.fromRGB(220, 160, 80),
        Text = Color3.fromRGB(255, 240, 210)
    }
}

function Theme:Get(name)
    return self.List[name] or self.List.Coffee
end

function Theme:Set(name)
    if self.List[name] then
        self.Current = name
    end
end

return Theme
