-- ✅ AllHighlight.lua
-- Highlights BOTH teammates (green) and enemies (red)
-- Client-side only, no replication, safe visual feature

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Create folder for all highlights
local highlightFolder = Instance.new("Folder")
highlightFolder.Name = "AllHighlights"
highlightFolder.Parent = player:WaitForChild("PlayerGui")

-- Configurable colors
local TEAM_COLOR = Color3.fromRGB(0, 255, 0)  -- 🟢 Teammates
local ENEMY_COLOR = Color3.fromRGB(255, 0, 0) -- 🔴 Enemies
local OUTLINE_COLOR = Color3.fromRGB(0, 0, 0)
local FILL_TRANSPARENCY = 0.5

-- 🧹 Clear all highlights
local function clearHighlights()
	for _, h in ipairs(highlightFolder:GetChildren()) do
		h:Destroy()
	end
end

-- 🧱 Create highlight for a player
local function createHighlightForPlayer(target)
	if not target.Character then return end

	local color = ENEMY_COLOR
	if target.Team and player.Team and target.Team == player.Team then
		color = TEAM_COLOR
	end

	local h = Instance.new("Highlight")
	h.Name = "Highlight_" .. target.Name
	h.Adornee = target.Character
	h.FillColor = color
	h.OutlineColor = OUTLINE_COLOR
	h.FillTransparency = FILL_TRANSPARENCY
	h.Parent = highlightFolder
end

-- 🔍 Refresh highlights for all players
local function refreshHighlights()
	clearHighlights()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			createHighlightForPlayer(p)
		end
	end
end

-- 🔁 Auto-update hooks
Players.PlayerAdded:Connect(function(p)
	p:GetPropertyChangedSignal("Team"):Connect(refreshHighlights)
	p.CharacterAdded:Connect(refreshHighlights)
	refreshHighlights()
end)

Players.PlayerRemoving:Connect(refreshHighlights)
player:GetPropertyChangedSignal("Team"):Connect(refreshHighlights)

-- Refresh every few seconds (failsafe)
RunService.Heartbeat:Connect(function()
	refreshHighlights()
end)

-- Initial load
refreshHighlights()
print("✅ AllHighlight system loaded: Teammates (green), Enemies (red)")
