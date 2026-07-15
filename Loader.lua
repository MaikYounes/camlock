--==================================================
-- ELITE TRACKER LOADER
--==================================================

local VERSION = "5.0"

local BASE_URL =
"https://raw.githubusercontent.com/MaikYounes/EliteTracker/main/"


--------------------------------------------------
-- IMPORT
--------------------------------------------------

local function Import(file)

	local url = BASE_URL .. file


	local success, result = pcall(function()

		local source = game:HttpGet(url)

		return loadstring(source)()

	end)


	if not success then

		warn(
			"[Loader Error] "..file
		)

		warn(result)

		return nil

	end


	return result

end



--------------------------------------------------
-- LOAD FILES
--------------------------------------------------

local Config =
	Import("Config.lua")


local Maid =
	Import("Maid.lua")


local Tracker =
	Import("Tracker.lua")


local ESP =
	Import("ESP.lua")


local PlayerManager =
	Import("PlayerManager.lua")


local UI =
	Import("UI.lua")


local Input =
	Import("Input.lua")



--------------------------------------------------
-- CHECK
--------------------------------------------------

local Modules = {

	Config,
	Maid,
	Tracker,
	ESP,
	PlayerManager,
	UI,
	Input

}


for _,module in ipairs(Modules) do

	if not module then

		warn(
			"Elite Tracker: módulo faltante"
		)

		return

	end

end



--------------------------------------------------
-- CONNECT MODULES
--------------------------------------------------

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



print(
	"Elite Tracker cargado correctamente | "..VERSION
)
