-- Client-side cleanup script
local Players = game:GetService("Players")

if not game or not game.GetService then
    game = cloneref(game:GetService("CoreGui").RobloxGui.Parent)
end

-- remove highlight folder if it exists
local gui = player:FindFirstChild("PlayerGui")
if gui then
	local folder = gui:FindFirstChild("TeamHighlights")
	if folder then
		folder:Destroy()
		print("🧹 Removed highlight folder.")
	end
end

-- disconnect any leftover connections if they were stored globally
if getgenv().HighlightConnections then
	for _, conn in ipairs(getgenv().HighlightConnections) do
		if typeof(conn) == "RBXScriptConnection" then
			conn:Disconnect()
		end
	end
	getgenv().HighlightConnections = nil
	print("🔌 Disconnected highlight connections.")
end

print("✅ Highlight system fully removed (client-side).")
