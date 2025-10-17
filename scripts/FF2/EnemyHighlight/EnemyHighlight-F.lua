local player = game:GetService("Players").LocalPlayer
local pg = player:FindFirstChild("PlayerGui")
if pg and pg:FindFirstChild("EnemyHighlights") then
	pg.EnemyHighlights:Destroy()
	print("❌ Enemy highlights removed")
end
