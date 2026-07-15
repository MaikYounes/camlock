local Input = {}

local UserInputService = game:GetService("UserInputService")

local Maid
local Config

local inputMaid


function Input:Init(maidModule, configModule)

	Maid = maidModule
	Config = configModule

	inputMaid = Maid.new()

end


function Input:Bind(key, callback)

	inputMaid:Give(
		UserInputService.InputBegan:Connect(function(input, processed)

			if processed then
				return
			end

			if input.KeyCode == key then
				callback()
			end

		end)
	)

end


function Input:Start(actions)

	for key,callback in pairs(actions) do

		self:Bind(
			key,
			callback
		)

	end

end


function Input:Destroy()

	if inputMaid then
		inputMaid:Cleanup()
	end

end


return Input
