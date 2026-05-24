--// TRADE FINDER + TELEPORT BUTTON
--// Delta / Roblox Lua

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

--========================
-- CONFIG
--========================

local RareItems = {
	["Omega Brainrot"] = true,
	["Galaxy Brainrot"] = true,
	["Void Brainrot"] = true,
	["Admin Brainrot"] = true
}

--========================
-- GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Name = "TradeFinder"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,370,0,320)
main.Position = UDim2.new(0.02,0,0.2,0)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔥 TRADE FINDER"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,170,0)
title.Parent = main

local scrolling = Instance.new("ScrollingFrame")
scrolling.Position = UDim2.new(0,10,0,45)
scrolling.Size = UDim2.new(1,-20,1,-55)
scrolling.CanvasSize = UDim2.new(0,0,0,0)
scrolling.BackgroundTransparency = 1
scrolling.BorderSizePixel = 0
scrolling.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.Parent = scrolling

--========================
-- TELEPORT
--========================

local function JoinPlayerServer(player)

	if player and player.Parent then
		
		game.StarterGui:SetCore("SendNotification",{
			Title = "Teleportando",
			Text = "Entrando al servidor de "..player.Name,
			Duration = 5
		})

		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end
end

--========================
-- CREAR TARJETA
--========================

local function AddPlayer(player,item)

	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1,-5,0,70)
	holder.BackgroundColor3 = Color3.fromRGB(35,35,35)
	holder.BorderSizePixel = 0
	holder.Parent = scrolling

	Instance.new("UICorner", holder)

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(0.65,0,1,0)
	text.Position = UDim2.new(0,10,0,0)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.GothamBold
	text.TextScaled = true
	text.TextXAlignment = Enum.TextXAlignment.Left
	text.TextColor3 = Color3.new(1,1,1)

	text.Text =
		"👤 "..player.Name..
		"\n💎 "..item.Name

	text.Parent = holder

	-- BOTON TP
	local tp = Instance.new("TextButton")
	tp.Size = UDim2.new(0.28,0,0.6,0)
	tp.Position = UDim2.new(0.7,0,0.2,0)
	tp.BackgroundColor3 = Color3.fromRGB(0,170,255)
	tp.Text = "JOIN"
	tp.Font = Enum.Font.GothamBold
	tp.TextScaled = true
	tp.TextColor3 = Color3.new(1,1,1)
	tp.Parent = holder

	Instance.new("UICorner", tp)

	tp.MouseButton1Click:Connect(function()
		JoinPlayerServer(player)
	end)

	scrolling.CanvasSize =
		UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end

--========================
-- ESCANEAR
--========================

local scanned = {}

local function ScanPlayer(plr)

	task.wait(2)

	if scanned[plr] then
		return
	end

	local inventory = plr:FindFirstChild("Inventory")

	if inventory then

		for _,item in pairs(inventory:GetChildren()) do

			if RareItems[item.Name] then

				scanned[plr] = true

				AddPlayer(plr,item)

				print("RARO:",plr.Name,item.Name)

			end
		end
	end
end

--========================
-- START
--========================

for _,plr in pairs(Players:GetPlayers()) do
	if plr ~= LocalPlayer then
		ScanPlayer(plr)
	end
end

Players.PlayerAdded:Connect(function(plr)
	ScanPlayer(plr)
end)
