-- ❌ Disable Team Highlight System (Client-Side Cleanup)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Try to find and remove the highlight folder
local gui = player:FindFirstChild("PlayerGui")
if gui then
    local folder = gui:FindFirstChild("TeamHighlights")
    if folder then
        folder:Destroy()
        print("🗑️ Removed TeamHighlights folder.")
    end
end

-- Optional: Remove any lingering highlight instances in workspace (just in case)
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("Highlight") and obj.Name:find("Highlight_") then
        obj:Destroy()
    end
end

print("❌ Team highlight system disabled (client-side).")
