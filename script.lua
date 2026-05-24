--// AUTO SERVER HOP REAL
--// FULL BRAINROT FINDER

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

--========================
-- ALL BRAINROTS
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
-- GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer.PlayerGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,420,0,320)
main.Position = UDim2.new(0.02,0,0.18,0)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner",main)

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔥 AUTO SERVER HOP"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,170,0)

local status = Instance.new("TextLabel")
status.Parent = main
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,0,40)
status.BackgroundTransparency = 1
status.Text = "🔍 Scanning..."
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.TextColor3 = Color3.new(1,1,1)

local scrolling = Instance.new("ScrollingFrame")
scrolling.Parent = main
scrolling.Position = UDim2.new(0,10,0,75)
scrolling.Size = UDim2.new(1,-20,1,-85)
scrolling.BackgroundTransparency = 1
scrolling.BorderSizePixel = 0
scrolling.CanvasSize = UDim2.new(0,0,0,0)

local layout = Instance.new("UIListLayout")
layout.Parent = scrolling
layout.Padding = UDim.new(0,6)

--========================
-- EXIT BUTTON
--========================

local leaveBtn = Instance.new("TextButton")
leaveBtn.Parent = main
leaveBtn.Size = UDim2.new(0,100,0,30)
leaveBtn.Position = UDim2.new(0.72,0,0.02,0)

leaveBtn.Text = "🚪 EXIT"
leaveBtn.TextScaled = true
leaveBtn.Font = Enum.Font.GothamBold
leaveBtn.BackgroundColor3 = Color3.fromRGB(255,70,70)
leaveBtn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",leaveBtn)

leaveBtn.MouseButton1Click:Connect(function()
	game:Shutdown()
end)

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
-- CARD
--========================

local function AddCard(player,item)

	local holder = Instance.new("Frame")
	holder.Parent = scrolling
	holder.Size = UDim2.new(1,-5,0,70)
	holder.BackgroundColor3 = Color3.fromRGB(30,30,30)

	Instance.new("UICorner",holder)

	local txt = Instance.new("TextLabel")
	txt.Parent = holder
	txt.Size = UDim2.new(1,-10,1,0)
	txt.Position = UDim2.new(0,10,0,0)
	txt.BackgroundTransparency = 1
	txt.TextColor3 = Color3.new(1,1,1)
	txt.TextScaled = true
	txt.Font = Enum.Font.GothamBold
	txt.TextXAlignment = Enum.TextXAlignment.Left

	txt.Text =
	"👤 "..player..
	"\n💎 "..item

	scrolling.CanvasSize =
	UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end

--========================
-- DETECTOR
--========================

local foundRare = false

local function IsRare(name)

	for _,keyword in pairs(SecretKeywords) do

		if string.lower(name) == string.lower(keyword) then
			return true
		end
	end

	return false
end

local function ScanPlayer(plr)

	local function check(container)

		for _,obj in pairs(container:GetDescendants()) do

			if IsRare(obj.Name) then

				foundRare = true

				AddCard(plr.Name,obj.Name)

				PlaySound()

				status.Text = "✅ RARE FOUND"

				return
			end
		end
	end

	if plr.Character then
		check(plr.Character)
	end

	if plr:FindFirstChild("Backpack") then
		check(plr.Backpack)
	end
end

for _,plr in pairs(Players:GetPlayers()) do

	if plr ~= LocalPlayer then

		pcall(function()
			ScanPlayer(plr)
		end)
	end
end

--========================
-- SERVER HOP
--========================

if not foundRare then

	status.Text = "❌ No rares... hopping"

	wait(3)

	local servers =
		HttpService:JSONDecode(
			game:HttpGet(
				"https://games.roblox.com/v1/games/"..
				PlaceId..
				"/servers/Public?sortOrder=Asc&limit=100"
			)
		)

	for _,server in pairs(servers.data) do

		if server.id ~= game.JobId
		and server.playing > 0 then

			TeleportService:TeleportToPlaceInstance(
				PlaceId,
				server.id,
				LocalPlayer
			)

			break
		end
	end

else

	status.Text = "🔥 GOOD SERVER FOUND"

end
