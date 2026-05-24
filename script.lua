local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local PlaceId = game.PlaceId

local SecretKeywords = {
	"secret",
	"omega",
	"void",
	"admin",
	"galaxy"
}

local function HasSecret(player)

	for _,v in pairs(player:GetDescendants()) do

		local low = string.lower(v.Name)

		for _,k in pairs(SecretKeywords) do

			if string.find(low,k) then
				return true,v.Name
			end
		end
	end

	return false
end

local function ScanServer()

	for _,plr in pairs(Players:GetPlayers()) do

		if plr ~= Players.LocalPlayer then

			local found,item = HasSecret(plr)

			if found then

				game.StarterGui:SetCore("SendNotification",{
					Title = "SECRET DETECTADO",
					Text = plr.Name.." tiene "..item,
					Duration = 15
				})

				print("FOUND SECRET:",plr.Name,item)

				return true
			end
		end
	end

	return false
end

-- Esperar carga
task.wait(5)

-- Si NO encuentra secretos -> cambiar servidor
if not ScanServer() then

	local url =
		"https://games.roblox.com/v1/games/"..
		PlaceId..
		"/servers/Public?sortOrder=Asc&limit=100"

	local response = game:HttpGet(url)

	local data = HttpService:JSONDecode(response)

	for _,server in pairs(data.data) do

		if server.id ~= game.JobId then

			TeleportService:TeleportToPlaceInstance(
				PlaceId,
				server.id,
				Players.LocalPlayer
			)

			break
		end
	end
end
