-- place this in StarterPlayerScripts or run via your local UI system
local player = game.Players.LocalPlayer
local highlightFolder = Instance.new("Folder")
highlightFolder.Name = "TeamHighlights"
highlightFolder.Parent = player:WaitForChild("PlayerGui") -- purely client-side

local function clearHighlights()
	for _, h in ipairs(highlightFolder:GetChildren()) do
		h:Destroy()
	end
end

local function createHighlight(target)
	local h = Instance.new("Highlight")
	h.Name = "Highlight_" .. target.Name
	h.Adornee = target
	h.FillColor = Color3.fromRGB(0, 255, 0) -- teammate color
	h.OutlineColor = Color3.fromRGB(0, 0, 0)
	h.FillTransparency = 0.5
	h.Parent = highlightFolder
end

-- check for teammate characters and highlight them
local function refreshHighlights()
	clearHighlights()
	for _, p in ipairs(game.Players:GetPlayers()) do
		if p ~= player and p.Team == player.Team and p.Character then
			createHighlight(p.Character)
		end
	end
end

-- listen for tool equip/unequip
local function onCharacterAdded(char)
	local backpack = player:WaitForChild("Backpack")

	local function toolCheck()
		local equipped = char:FindFirstChildOfClass("Tool")
		if equipped and equipped.Name == "Football" then
			refreshHighlights()
		else
			clearHighlights()
		end
	end

	-- trigger when tools are equipped or unequipped
	char.ChildAdded:Connect(toolCheck)
	char.ChildRemoved:Connect(toolCheck)

	-- also run initial check
	toolCheck()
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
	onCharacterAdded(player.Character)
end

print("✅ Team highlight system loaded (client-side).")
