-- 🛑 Ynx Rogue - Rusher Alert Disable Script

local player = game:GetService("Players").LocalPlayer
local gui = player:FindFirstChild("PlayerGui")

-- 1️⃣ Remove any leftover highlights
if gui and gui:FindFirstChild("RusherHighlights") then
	gui.RusherHighlights:Destroy()
end

-- 2️⃣ Stop the Heartbeat connection if it exists
if getgenv and getgenv().RusherAlertConnection then
	getgenv().RusherAlertConnection:Disconnect()
	getgenv().RusherAlertConnection = nil
end

print("🛑 [Ynx Rogue] Rusher Alert system disabled successfully")
