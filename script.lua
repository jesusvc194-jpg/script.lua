--// REAL BRAINROT FINDER + AUTO ESCAPE

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

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
-- GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer.PlayerGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,420,0,340)
main.Position = UDim2.new(0.02,0,0.18,0)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner",main)

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔥 REAL BRAINROT FINDER"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,170,0)

local scrolling = Instance.new("ScrollingFrame")
scrolling.Parent = main
scrolling.Position = UDim2.new(0,10,0,50)
scrolling.Size = UDim2.new(1,-20,1,-60)
scrolling.BackgroundTransparency = 1
scrolling.CanvasSize = UDim2.new(0,0,0,0)

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
-- ESP
--========================

local function MarkPlayer(plr)

	if not plr.Character then
		return
	end

	local root = plr.Character:FindFirstChild("HumanoidRootPart")

	if root and not root:FindFirstChild("SecretESP") then

		local bill = Instance.new("BillboardGui")
		bill.Name = "SecretESP"
		bill.Parent = root
		bill.Size = UDim2.new(0,200,0,50)
		bill.StudsOffset = Vector3.new(0,5,0)
		bill.AlwaysOnTop = true

		local txt = Instance.new("TextLabel")
		txt.Parent = bill
		txt.Size = UDim2.new(1,0,1,0)
		txt.BackgroundTransparency = 1
		txt.Text = "⭐ SECRET PLAYER"
		txt.TextScaled = true
		txt.Font = Enum.Font.GothamBold
		txt.TextColor3 = Color3.fromRGB(255,255,0)
		txt.TextStrokeTransparency = 0
	end
end

--========================
-- CARD
--========================

local function AddCard(playerName,itemName)

	local holder = Instance.new("Frame")
	holder.Parent = scrolling
	holder.Size = UDim2.new(1,-5,0,75)
	holder.BackgroundColor3 = Color3.fromRGB(30,30,30)

	Instance.new("UICorner",holder)

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
	"👤 "..playerName..
	"\n💎 "..itemName

	local tp = Instance.new("TextButton")
	tp.Parent = holder
	tp.Size = UDim2.new(0.25,0,0.55,0)
	tp.Position = UDim2.new(0.72,0,0.22,0)
	tp.Text = "TP"
	tp.TextScaled = true
	tp.Font = Enum.Font.GothamBold
	tp.BackgroundColor3 = Color3.fromRGB(0,170,255)
	tp.TextColor3 = Color3.new(1,1,1)

	Instance.new("UICorner",tp)

	tp.MouseButton1Click:Connect(function()

		local target = Players:FindFirstChild(playerName)

		if target
		and target.Character
		and target.Character:FindFirstChild("HumanoidRootPart") then

			LocalPlayer.Character.HumanoidRootPart.CFrame =
				target.Character.HumanoidRootPart.CFrame + Vector3.new(3,0,0)
		end
	end)

	scrolling.CanvasSize =
	UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end

--========================
-- DETECTOR
--========================

local detected = {}

local function ScanPlayer(plr)

	if detected[plr] then
		return
	end

	local function check(container)

		for _,obj in pairs(container:GetDescendants()) do

			for _,keyword in pairs(SecretKeywords) do

				if string.find(
					string.lower(obj.Name),
					string.lower(keyword)
				) then

					AddCard(plr.Name,keyword)

					MarkPlayer(plr)

					PlaySound()

					detected[plr] = true

					print("FOUND:",plr.Name,keyword)

					break
				end
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

local function ScanAll()

	for _,plr in pairs(Players:GetPlayers()) do

		if plr ~= LocalPlayer then

			pcall(function()
				ScanPlayer(plr)
			end)
		end
	end
end

--========================
-- AUTO ESCAPE
--========================

local function HasRare()

	for _,obj in pairs(LocalPlayer:GetDescendants()) do

		for _,keyword in pairs(SecretKeywords) do

			if string.find(
				string.lower(obj.Name),
				string.lower(keyword)
			) then

				return true
			end
		end
	end

	return false
end

task.spawn(function()

	while true do

		wait(2)

		if HasRare() then

			game.StarterGui:SetCore("SendNotification",{
				Title = "🔥 BRAINROT OBTENIDO",
				Text = "Escapando...",
				Duration = 5
			})

			wait(1)

			local servers =
				HttpService:JSONDecode(
					game:HttpGet(
						"https://games.roblox.com/v1/games/"..
						game.PlaceId..
						"/servers/Public?sortOrder=Asc&limit=100"
					)
				)

			for _,server in pairs(servers.data) do

				if server.id ~= game.JobId then

					TeleportService:TeleportToPlaceInstance(
						game.PlaceId,
						server.id,
						LocalPlayer
					)

					break
				end
			end
		end
	end
end)

while true do
	wait(10)
	ScanAll()
end
