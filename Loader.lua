local omni = loadstring(game:HttpGet("https://raw.githubusercontent.com/TweedLeak-LeakScripts/FriseX/main/UI-Library"))()
local Player = game.Players.LocalPlayer
local UI = omni.new({
    Name = "❤️ Ynx Rogue ❤️",
    Credit = "Created by Ynx",
    Color = Color3.fromRGB(225,0,0),
    Bind = "Insert",
    UseLoader = true,
    FullName = "Ynx Rogue v1.0",
    CheckKey = function(key)
        return key == "123"
    end,
    Discord = "discord.gg/example"
})

UI:Notify({
    Title = "Hello: " .. Player.DisplayName,
    Content = "Press Insert to toggle the UI"
})

local General = UI:CreatePage("🎮 Games 🎮")
local Gamessec = General:CreateSection("Sports")

Gamessec:CreateButton({
    Name = "Football Fusion 2",
    Callback = function()
        UI:Notify({
            Title = "Loading New Menu...",
            Content = "Please wait a second."
        })
        task.wait(1)
        UI:Destroy()
        task.wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ynxpi/Ynx-Rogue/main/Games/FF2"))()
    end
})
