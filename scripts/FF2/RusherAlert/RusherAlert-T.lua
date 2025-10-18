-- 🧠 Ynx Rogue - Rusher Alert (QB Awareness)
-- Highlights rushers flashing red when they approach the local player with the football

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- 🔧 Settings
local DETECTION_RADIUS = 40         -- studs
local RUSH_SPEED_THRESHOLD = 8      -- min speed toward you
local FLASH_DURATION = 0.4          -- seconds to stay red
local FLASH_COLOR = Color3.fromRGB(255, 0, 0)

-- Folder to hold temporary highlights
local folder = Instance.new("Folder")
folder.Name = "RusherHighlights"
folder.Parent = player:WaitForChild("PlayerGui")

-- 🧩 Helper: check if local player has the football
local function hasFootball()
	local char = player.Character
	if not char then return false end
	return char:FindFirstChild("Football") ~= nil
end

-- 🧩 Flash highlight on a target
local function flashHighlight(targetChar)
	if not targetChar or folder:FindFirstChild(targetChar.Name) then return end

	local h = Instance.new("Highlight")
	h.Name = targetChar.Name
	h.Adornee = targetChar
	h.FillColor = FLASH_COLOR
	h.OutlineColor = Color3.fromRGB(0, 0, 0)
	h.FillTransparency = 0.25
	h.Parent = folder

	task.delay(FLASH_DURATION, function()
		if h and h.Parent then h:Destroy() end
	end)
end

-- 🧩 Calculate if player is rushing toward you
local function isRushing(enemy)
	local enemyChar = enemy.Character
	local myChar = player.Character
	if not enemyChar or not myChar then return false end

	local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
	local myRoot = myChar:FindFirstChild("HumanoidRootPart")
	if not enemyRoot or not myRoot then return false end

	local dist = (enemyRoot.Position - myRoot.Position).Magnitude
	if dist > DETECTION_RADIUS then return false end

	-- Check if moving toward you
	local velocity = enemyRoot.Velocity
	local dirToYou = (myRoot.Position - enemyRoot.Position).Unit
	local approachSpeed = velocity:Dot(dirToYou)

	return approachSpeed > RUSH_SPEED_THRESHOLD
end

-- 🔁 Main loop
RunService.Heartbeat:Connect(function()
	if not hasFootball() then
		-- Clear any remaining highlights when you lose the ball
		for _, h in ipairs(folder:GetChildren()) do
			h:Destroy()
		end
		return
	end

	for _, enemy in ipairs(Players:GetPlayers()) do
		if enemy ~= player and enemy.Team ~= player.Team then
			if isRushing(enemy) then
				flashHighlight(enemy.Character)
			end
		end
	end
end)

print("✅ [Ynx Rogue] Rusher Alert system loaded")
