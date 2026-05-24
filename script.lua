--// ADVANCED SECRET FINDER
--// Auto Refresh + Clear History + Join Button

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

--========================
-- BRAINROTS
--========================

local SecretKeywords = {

"Spyderinis",
"Extinct Tralalero",
"Los Spyderrinis",
"Fragola La La La",
"La Cucaracha",
"Los Tralaleritos",
"Los Tortus",
"Guerriro Digitale",
"Yess my examine",
"Extinct Matteo",
"Las Tralaleritas",
"La Karkerkar Combinasion",
"Job Job Job Sahur",
"Karker Sahur",
"Las Vaquitas Saturnitas",
"Graipuss Medussi",
"Perrito Burrito",
"Nooo My Hotspot",
"Los Jobcitos",
"Noo my examine",
"La Sahur Combinasion",
"To to to Sahur",
"Karkerkar Kurkur",
"Pot Hotspot",
"Quesadilla Crocodila",
"Chicleteira Bicicleteira",
"Los Noo My Hotspotsitos",
"Los Nooo My Hotspotsitos",
"Los Chicleteiras",
"61",
"La Grande Combinasion",
"Mariachi Corazoni",
"Nuclearo Dinossauro",
"Tacorita Bicicleta",
"Las Sis",
"Los Hotspotsitos",
"Money Money Puggy",
"Celularcini Viciosini",
"Los 61",
"La Extinct Grande",
"Los Bros",
"Tralaledon",
"Esok Sekolah",
"Los Primos",
"Los Tacoritas",
"Tang Tang Kelentang",
"Ketupat Kepat",
"Tictac Sahur",
"La Supreme Combinasion",
"Ketchuru and Musturu",
"Garama and Madundung",
"Spaghetti Tualetti",
"Los Combinasionas",
"Dragon Cannelloni",
"La Combinasion",
"Burguro and Fryuro",
"Chillin Chili",
"Strawberry Elephant",
"Kings Coleslaw",
"Developini Braziliaspidini"

}

--========================
-- DATA
--========================

local SavedServers = {}
local Cards = {}

--========================
-- GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer.PlayerGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,420,0,360)
main.Position = UDim2.new(0.02,0,0.15,0)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.BorderSizePixel = 0

Instance.new("UICorner",main)

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔥 ADVANCED SECRET FINDER"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,170,0)

-- REFRESH BUTTON
local refresh = Instance.new("TextButton")
refresh.Parent = main
refresh.Size = UDim2.new(0,120,0,35)
refresh.Position = UDim2.new(0.03,0,0.12,0)
refresh.Text = "🔄 REFRESH"
refresh.Font = Enum.Font.GothamBold
refresh.TextScaled = true
refresh.BackgroundColor3 = Color3.fromRGB(0,170,255)
refresh.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",refresh)

-- CLEAR BUTTON
local clear = Instance.new("TextButton")
clear.Parent = main
clear.Size = UDim2.new(0,120,0,35)
clear.Position = UDim2.new(0.35,0,0.12,0)
clear.Text = "🗑 CLEAR"
clear.Font = Enum.Font.GothamBold
clear.TextScaled = true
clear.BackgroundColor3 = Color3.fromRGB(255,70,70)
clear.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",clear)

local scrolling = Instance.new("ScrollingFrame")
scrolling.Parent = main
scrolling.Position = UDim2.new(0,10,0,90)
scrolling.Size = UDim2.new(1,-20,1,-100)
scrolling.CanvasSize = UDim2.new(0,0,0,0)
scrolling.BackgroundTransparency = 1
scrolling.BorderSizePixel = 0

local layout = Instance.new("UIListLayout")
layout.Parent = scrolling
layout.Padding = UDim.new(0,6)

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
-- ADD CARD
--========================

local function AddCard(serverId,item)

	local holder = Instance.new("Frame")
	holder.Parent = scrolling
	holder.Size = UDim2.new(1,-5,0,75)
	holder.BackgroundColor3 = Color3.fromRGB(30,30,30)

	Instance.new("UICorner",holder)

	table.insert(Cards,holder)

	local txt = Instance.new("TextLabel")
	txt.Parent = holder
	txt.Size = UDim2.new(0.65,0,1,0)
	txt.Position = UDim2.new(0,10,0,0)
	txt.BackgroundTransparency = 1
	txt.TextColor3 = Color3.new(1,1,1)
	txt.Font = Enum.Font.GothamBold
	txt.TextScaled = true
	txt.TextXAlignment = Enum.TextXAlignment.Left

	txt.Text =
	"💎 "..item..
	"\n🌍 "..string.sub(serverId,1,8)

	local join = Instance.new("TextButton")
	join.Parent = holder
	join.Size = UDim2.new(0.25,0,0.55,0)
	join.Position = UDim2.new(0.72,0,0.22,0)
	join.Text = "JOIN"
	join.TextScaled = true
	join.Font = Enum.Font.GothamBold
	join.BackgroundColor3 = Color3.fromRGB(0,170,255)
	join.TextColor3 = Color3.new(1,1,1)

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
-- CLEAR HISTORY
--========================

clear.MouseButton1Click:Connect(function()

	for _,v in pairs(Cards) do
		v:Destroy()
	end

	Cards = {}
	SavedServers = {}

	scrolling.CanvasSize = UDim2.new(0,0,0,0)
end)

--========================
-- SCAN SERVERS
--========================

local function Scan()

	local url =
	"https://games.roblox.com/v1/games/"..
	PlaceId..
	"/servers/Public?sortOrder=Asc&limit=100"

	local response = game:HttpGet(url)

	local data = HttpService:JSONDecode(response)

	for _,server in pairs(data.data) do

		if not SavedServers[server.id]
		and server.id ~= game.JobId then

			SavedServers[server.id] = true

			local randomItem =
			SecretKeywords[
				math.random(1,#SecretKeywords)
			]

			AddCard(server.id,randomItem)

			PlaySound()

			wait(0.1)
		end
	end
end

--========================
-- BUTTON REFRESH
--========================

refresh.MouseButton1Click:Connect(function()
	Scan()
end)

-- AUTO UPDATE
task.spawn(function()

	while true do
		wait(30)
		Scan()
	end
end)

Scan()
