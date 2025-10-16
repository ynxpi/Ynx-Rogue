-- ✅ Client-side Team Highlight Script
-- Highlights all teammates when holding a tool named "Football"

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local highlightFolder = Instance.new("Folder")
highlightFolder.Name = "TeamHighlights"
highlightFolder.Parent = player:WaitForChild("PlayerGui") -- purely client-side visuals

-- Utility: Clear existing highlights
local function clearHighlights()
	for _, h in ipairs(highlightFolder:GetChildren()) do
		h:Destroy()
	end
end

-- Utility: Create highlight around a player's character
local function createHighlight(target)
	if target:FindFirstChildOfClass("Highlight") then return end -- prevent duplicates

	local h = Instance.new("Highlight")
	h.Name = "Highlight_" .. target.Name
	h.Adornee = target
	h.FillColor = Color3.fromRGB(0, 255, 0) -- teammate color (green)
	h.OutlineColor = Color3.fromRGB(0, 0, 0)
	h.FillTransparency = 0.5
	h.OutlineTransparency = 0
	h.Parent = highlightFolder
end

-- Refresh highlights for current teammates
local function refreshHighlights()
	clearHighlights()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Team == player.Team and p.Character then
			createHighlight(p.Character)
		end
	end
end

-- Handle character added / tool equip-unequip logic
local function onCharacterAdded(char)
	local function toolCheck()
		local equipped = char:FindFirstChildOfClass("Tool")
		if equipped and equipped.Name == "Football" then
			refreshHighlights()
		else
			clearHighlights()
		end
	end

	char.ChildAdded:Connect(toolCheck)
	char.ChildRemoved:Connect(toolCheck)

	-- Run once on spawn
	task.delay(1, toolCheck)
end

-- Setup character listener
player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
	onCharacterAdded(player.Character)
end

print("✅ Team highlight system loaded (client-side).")
