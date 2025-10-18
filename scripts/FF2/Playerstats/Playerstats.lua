------------------------------------------------
-- 📋 PLAYERS TAB - Live Player Stats
------------------------------------------------
local Players = game:GetService("Players")

local PlayerStatsSec = PlayersPage:CreateSection("Player Stats")

-- Table to keep track of labels so we can update them
local playerLabels = {}

-- 🧹 Clear old labels
local function clearPlayerLabels()
	for _, label in pairs(playerLabels) do
		label:Destroy()
	end
	playerLabels = {}
end

-- 🔁 Refresh player list
local function refreshPlayerStats()
	clearPlayerLabels()

	for _, p in ipairs(Players:GetPlayers()) do
		-- Create label with basic info first
		local ovr = "?"
		local passer = "?"
		local catches = "?"
		local team = (p.Team and p.Team.Name) or "No Team"

		-- Try to grab their real leaderstats
		local ls = p:FindFirstChild("leaderstats")
		if ls then
			if ls:FindFirstChild("OVR") then
				ovr = ls.OVR.Value
			end
			if ls:FindFirstChild("Passer Rating") then
				passer = ls["Passer Rating"].Value
			end
			if ls:FindFirstChild("Catches") then
				catches = ls.Catches.Value
			end
		end

		local display = string.format("%s [%s] | OVR: %s | Passer: %s | Catches: %s", 
			p.DisplayName, team, ovr, passer, catches)

		local label = PlayerStatsSec:CreateLabel(display)
		playerLabels[p.UserId] = label

		-- 🧩 Auto-update when leaderstats change
		if ls then
			for _, stat in pairs(ls:GetChildren()) do
				stat:GetPropertyChangedSignal("Value"):Connect(function()
					refreshPlayerStats()
				end)
			end
		end
	end
end

-- 👥 Listen for players joining/leaving
Players.PlayerAdded:Connect(refreshPlayerStats)
Players.PlayerRemoving:Connect(refreshPlayerStats)

-- 🔁 Refresh every few seconds (failsafe)
task.spawn(function()
	while task.wait(5) do
		refreshPlayerStats()
	end
end)

-- 🧠 Initial load
refreshPlayerStats()
