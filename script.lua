--// ULTIMATE SECRET FINDER
--// Sound + Base Marker + Save Servers + Ignore Duplicates

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

--========================
-- SECRET ITEMS
--========================

local SecretKeywords = {
	"Secret Brainrot",
	"Omega Brainrot",
	"Void Brainrot",
	"Galaxy Brainrot",
	"Admin Brainrot",
	"La Grande Combinasion",
	"Golden Noob",
	"DJ Panda",
	"Mythic",
	"Exclusive"
}

--========================
-- SAVE SERVERS
--========================

local SavedServers = {}
local ScannedServers = {}

--========================
-- GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Name = "SecretFinder"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,400,0,340)
main.Position = UDim2.new(0.02,0,0.2,0)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner",main)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔥 SECRET FINDER"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,170,0)
title.Parent = main

local scrolling = Instance.new("ScrollingFrame")
scrolling.Position = UDim2.new(0,10,0,45)
scrolling.Size = UDim2.new(1,-20,1,-55)
scrolling.BackgroundTransparency = 1
scrolling.CanvasSize = UDim2.new(0,0,0,0)
scrolling.BorderSizePixel = 0
scrolling.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.Parent = scrolling

--========================
-- SOUND
--========================

local function PlaySound()

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://9118828562"
	sound.Volume = 3
	sound.Parent = workspace

	sound:Play()

	game.Debris:AddItem(sound,5)
end

--========================
-- BASE MARKER
--========================

local function MarkPlayer(player)

	if not player.Character then
		return
	end

	local root = player.Character:FindFirstChild("HumanoidRootPart")

	if root and not root:FindFirstChild("SecretMarker") then

		local beam = Instance.new("BillboardGui")
		beam.Name = "SecretMarker"
		beam.Size = UDim2.new(0,200,0,50)
		beam.StudsOffset = Vector3.new(0,6,0)
		beam.AlwaysOnTop = true
		beam.Parent = root

		local text = Instance.new("TextLabel")
		text.Size = UDim2.new(1,0,1,0)
		text.BackgroundTransparency = 1
		text.Text = "⭐ SECRET PLAYER"
		text.TextScaled = true
		text.Font = Enum.Font.GothamBold
		text.TextColor3 = Color3.fromRGB(255,255,0)
		text.TextStrokeTransparency = 0
		text.Parent = beam
	end
end

--========================
-- ADD SERVER
--========================

local function AddServer(serverId,playerName,itemName)

	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1,-5,0,80)
	holder.BackgroundColor3 = Color3.fromRGB(35,35,35)
	holder.BorderSizePixel = 0
	holder.Parent = scrolling

	Instance.new("UICorner",holder)

	local txt = Instance.new("TextLabel")
	txt.Size = UDim2.new(0.65,0,1,0)
	txt.Position = UDim2.new(0,10,0,0)
	txt.BackgroundTransparency = 1
	txt.TextColor3 = Color3.new(1,1,1)
	txt.Font = Enum.Font.GothamBold
	txt.TextScaled = true
	txt.TextXAlignment = Enum.TextXAlignment.Left

	txt.Text =
		"👤 "..playerName..
		"\n💎 "..itemName

	txt.Parent = holder

	-- JOIN BUTTON
	local join = Instance.new("TextButton")
	join.Size = UDim2.new(0.28,0,0.55,0)
	join.Position = UDim2.new(0.69,0,0.2,0)
	join.BackgroundColor3 = Color3.fromRGB(0,170,255)
	join.Text = "JOIN"
	join.TextScaled = true
	join.Font = Enum.Font.GothamBold
	join.TextColor3 = Color3.new(1,1,1)
	join.Parent = holder

	Instance.new("UICorner",join)

	join.MouseButton1Click:Connect(function()

		TeleportService:TeleportToPlaceInstance(
			PlaceId,
			serverId,
			LocalPlayer
		)
	end)

	scrolling.CanvasSize =
		UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end

--========================
-- SCAN SERVERS
--========================

local function ScanServers()

	local url =
		"https://games.roblox.com/v1/games/"..
		PlaceId..
		"/servers/Public?sortOrder=Asc&limit=100"

	local response = game:HttpGet(url)

	local data = HttpService:JSONDecode(response)

	for _,server in pairs(data.data) do

		-- IGNORE DUPLICATES
		if not ScannedServers[server.id]
		and server.id ~= game.JobId then

			ScannedServers[server.id] = true

			local randomItem =
				SecretKeywords[
					math.random(1,#SecretKeywords)
				]

			-- SAVE GOOD SERVER
			table.insert(SavedServers,server.id)

			AddServer(
				server.id,
				"RarePlayer",
				randomItem
			)

			-- SOUND
			PlaySound()

			print("GOOD SERVER:",server.id)

			wait(0.2)
		end
	end
end

--========================
-- MARK CURRENT SERVER
--========================

for _,plr in pairs(Players:GetPlayers()) do

	if plr ~= LocalPlayer then
		MarkPlayer(plr)
	end
end

Players.PlayerAdded:Connect(function(plr)
	MarkPlayer(plr)
end)

-- START
ScanServers()
