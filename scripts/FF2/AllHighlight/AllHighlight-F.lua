local player = game:GetService("Players").LocalPlayer
local pg = player:FindFirstChild("PlayerGui")
if pg and pg:FindFirstChild("AllHighlights") then
	pg.AllHighlights:Destroy()
	print("❌ All highlights removed")
end
