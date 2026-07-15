local VERSION = "5.0"

local BASE_URL =
"https://raw.githubusercontent.com/MaikYounes/camlock/main/"


local function Import(file)

	local url = BASE_URL .. file

	local success, result = pcall(function()

		local source = game:HttpGet(url)

		return loadstring(source)()

	end)


	if not success then
		warn("[ERROR CARGANDO] "..file)
		warn(result)
		return nil
	end


	return result

end



local Config = Import("Config.lua")

local Maid = Import("Maid.lua")

local Tracker = Import("Tracker.lua")

local ESP = Import("ESP.lua")

local PlayerManager = Import("PlayerManager.lua")

local UI = Import("UI.lua")

local Input = Import("Input.lua")



if not Config
or not Maid
or not Tracker
or not ESP
or not PlayerManager
or not UI
or not Input then

	warn("Faltan archivos en GitHub")
	return

end



ESP:Init(
	Config,
	Tracker
)


PlayerManager:Init(
	Maid,
	Tracker,
	ESP
)


PlayerManager:Start()



UI:Init(
	Config,
	Tracker,
	ESP
)


UI:Start()



Input:Init(
	Maid,
	Config
)



print("Elite Tracker cargado correctamente")
