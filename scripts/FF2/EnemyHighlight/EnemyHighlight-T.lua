local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local enemyFolder = Instance.new("Folder")
enemyFolder.Name = "EnemyHighlights"
enemyFolder.Parent = player:WaitForChild("PlayerGui")

local HIGHLIGHT_COLOR = Color3.fromRGB(255, 0, 0) -- 🔴 red highlight for enemies
local OUTLINE_COLOR = Color3.fromRGB(0, 0, 0)
local FILL_TRANSPARENCY = 0.5

-- 🧹 Cleanup function
local function clearHighlights()
	for _, h in ipairs(enemyFolder:GetChildren()) do
		h:Destroy()
	end
end

-- 🧱 Create a highlight for a given player
local function createHighlight(target)
	if not target.Character then return end
	local h = Instance.new("Highlight")
	h.Name = "Highlight_" .. target.Name
	h.Adornee = target.Character
	h.FillColor = HIGHLIGHT_COLOR
	h.OutlineColor = OUTLINE_COLOR
	h.FillTransparency = FILL_TRANSPARENCY
	h.Parent = enemyFolder
end

-- 🔍 Check if the local player has the football
local function hasFootball()
	if not player.Character then return false end
	return player.Character:FindFirstChild("Football") ~= nil
end

-- 🔍 Refresh all highlights
local function refreshHighlights()
	clearHighlights()
	if not hasFootball() then return end -- Only highlight if we have the ball
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Team and player.Team then
			if p.Team ~= player.Team then
				createHighlight(p)
			end
		end
	end
end

-- 🔁 Auto-update when players or teams change
Players.PlayerAdded:Connect(function(p)
	p:GetPropertyChangedSignal("Team"):Connect(refreshHighlights)
	p.CharacterAdded:Connect(refreshHighlights)
	refreshHighlights()
end)

Players.PlayerRemoving:Connect(refreshHighlights)
player:GetPropertyChangedSignal("Team"):Connect(refreshHighlights)
RunService.Heartbeat:Connect(refreshHighlights)

print("✅ EnemyHighlight system loaded (client-side only, football-aware)")
