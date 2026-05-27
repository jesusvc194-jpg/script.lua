--// BRAINROT SECRET FINDER
--// REAL NPC DETECTOR
--// WHITELIST DETECTOR
--// AUTO SERVER HOP
--// MOBILE UI

if getgenv().BrainrotFinderLoaded then
	return
end
getgenv().BrainrotFinderLoaded = true

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlaceID = game.PlaceId
local JobID = game.JobId

--// AUTO EXECUTE

local LOADSTRING =
'loadstring(game:HttpGet("https://raw.githubusercontent.com/jesusvc194-jpg/Hades/refs/heads/main/script.lua"))()'

pcall(function()

	if queue_on_teleport then
		queue_on_teleport(LOADSTRING)

	elseif syn and syn.queue_on_teleport then
		syn.queue_on_teleport(LOADSTRING)
	end
end)

--// VALID BRAINROTS

local ValidNames = {

	["spyderinis"] = true,
	["extinct tralalero"] = true,
	["los spyderrinis"] = true,
	["fragola la la la"] = true,
	["la cucaracha"] = true,
	["los tralaleritos"] = true,
	["los tortus"] = true,
	["guerriro digitale"] = true,
	["yess my examine"] = true,
	["extinct matteo"] = true,
	["las tralaleritas"] = true,
	["la karkerkar combinasion"] = true,
	["job job job sahur"] = true,
	["karker sahur"] = true,
	["las vaquitas saturnitas"] = true,
	["graipuss medussi"] = true,
	["perrito burrito"] = true,
	["nooo my hotspot"] = true,
	["los jobcitos"] = true,
	["noo my examine"] = true,
	["la sahur combinasion"] = true,
	["to to to sahur"] = true,
	["karkerkar kurkur"] = true,
	["pot hotspot"] = true,
	["quesadilla crocodila"] = true,
	["chicleteira bicicleteira"] = true,
	["los noo my hotspotsitos"] = true,
	["los nooo my hotspotsitos"] = true,
	["los chicleteiras"] = true,
	["67"] = true,
	["la grande combinasion"] = true,
	["mariachi corazoni"] = true,
	["nuclearo dinossauro"] = true,
	["tacorita bicicleta"] = true,
	["las sis"] = true,
	["los hotspotsitos"] = true,
	["money money puggy"] = true,
	["celularcini viciosini"] = true,
	["los 67"] = true,
	["la extinct grande"] = true,
	["los bros"] = true,
	["tralaledon"] = true,
	["esok sekolah"] = true,
	["los primos"] = true,
	["los tacoritas"] = true,
	["tang tang kelentang"] = true,
	["ketupat kepat"] = true,
	["tictac sahur"] = true,
	["la supreme combinasion"] = true,
	["ketchuru and musturu"] = true,
	["garama and madundung"] = true,
	["spaghetti tualetti"] = true,
	["los combinasionas"] = true,
	["dragon cannelloni"] = true,
	["la combinasion"] = true,
	["burguro and fryuro"] = true,
	["chillin chili"] = true,
	["strawberry elephant"] = true,
	["kings coleslaw"] = true,
	["developini braziliaspidini"] = true
}

--// SERVER BLACKLIST

local FILE = "BrainrotServers.json"

local visited = {}

pcall(function()

	if isfile(FILE) then
		visited = HttpService:JSONDecode(readfile(FILE))
	end
end)

visited[JobID] = true

pcall(function()

	writefile(
		FILE,
		HttpService:JSONEncode(visited)
	)
end)

--// GUI

local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotFinder"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,230,0,160)
main.Position = UDim2.new(0.72,0,0.02,0)
main.BackgroundColor3 = Color3.fromRGB(0,0,0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

Instance.new("UICorner",main).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,28)
title.BackgroundTransparency = 1
title.Text = "🔥 SECRET FINDER"
title.TextColor3 = Color3.fromRGB(255,170,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local status = Instance.new("TextLabel")
status.Parent = main
status.Size = UDim2.new(1,-10,0,25)
status.Position = UDim2.new(0,5,0,28)
status.BackgroundTransparency = 1
status.Text = "🔍 Searching..."
status.TextColor3 = Color3.new(1,1,1)
status.Font = Enum.Font.GothamBold
status.TextScaled = true

local log = Instance.new("TextLabel")
log.Parent = main
log.Size = UDim2.new(1,-10,1,-60)
log.Position = UDim2.new(0,5,0,55)
log.BackgroundTransparency = 1
log.Text = "[SYSTEM]\nWaiting..."
log.TextColor3 = Color3.fromRGB(255,170,0)
log.Font = Enum.Font.Code
log.TextSize = 13
log.TextWrapped = true
log.TextXAlignment = Enum.TextXAlignment.Left
log.TextYAlignment = Enum.TextYAlignment.Top

--// SERVER HOP

local hopping = false

local function ServerHop()

	if hopping then
		return
	end

	hopping = true

	local success,err = pcall(function()

		local req =
			game:HttpGet(
				"https://games.roblox.com/v1/games/"..
				PlaceID..
				"/servers/Public?sortOrder=Asc&limit=100"
			)

		local data =
			HttpService:JSONDecode(req)

		for _,server in pairs(data.data) do

			if server.id ~= JobID
			and server.playing < server.maxPlayers
			and not visited[server.id] then

				visited[server.id] = true

				writefile(
					FILE,
					HttpService:JSONEncode(visited)
				)

				log.Text =
					"[HOP]\nJoining New Server..."

				task.wait(1)

				TeleportService:TeleportToPlaceInstance(
					PlaceID,
					server.id,
					LocalPlayer
				)

				return
			end
		end

		table.clear(visited)

		visited[JobID] = true

		writefile(
			FILE,
			HttpService:JSONEncode(visited)
		)
	end)

	if not success then

		log.Text =
			"[ERROR]\n"..tostring(err)
	end

	hopping = false
end

--// REAL DETECTOR

local function IsValidBrainrot(model)

	if not model:IsA("Model") then
		return false
	end

	if not model:FindFirstChild("HumanoidRootPart") then
		return false
	end

	local foundName = false
	local foundRare = false

	for _,v in pairs(model:GetDescendants()) do

		if v:IsA("TextLabel") then

			local text =
				string.lower(v.Text)

			-- RARITY

			if string.find(text,"secret") then
				foundRare = true
			end

			-- NAME

			if ValidNames[text] then
				foundName = true
			end
		end
	end

	return foundName and foundRare
end

--// MAIN LOOP

task.spawn(function()

	while true do

		task.wait(6)

		local found = {}

		for _,v in pairs(workspace:GetDescendants()) do

			pcall(function()

				if IsValidBrainrot(v) then

					if not table.find(found,v.Name) then
						table.insert(found,v.Name)
					end
				end
			end)
		end

		if #found > 0 then

			status.Text = "🔥 SECRET FOUND"

			log.Text =
				"[FOUND]\n\n"..
				table.concat(found,"\n")

			pcall(function()

				StarterGui:SetCore(
					"SendNotification",
					{
						Title = "SECRET FOUND",
						Text = table.concat(found,", "),
						Duration = 8
					}
				)
			end)

		else

			status.Text = "🔍 Searching..."

			log.Text =
				"[SCAN]\nNo Secret Found"

			ServerHop()
		end
	end
end)

print("BRAINROT FINDER LOADED")
