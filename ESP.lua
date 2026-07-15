local ESP = {}

local Players = game:GetService("Players")

local Config = nil
local Tracker = nil

local ESP_NAME = "EliteESP_Tag"

----------------------------------------------------
-- INIT
----------------------------------------------------

function ESP:Init(configModule, trackerModule)
	Config = configModule
	Tracker = trackerModule
end

----------------------------------------------------
-- REMOVE
----------------------------------------------------

function ESP:Remove(player)

	if not player then
		return
	end

	local character = player.Character

	if not character then
		return
	end

	local tag = character:FindFirstChild(ESP_NAME)

	if tag then
		tag:Destroy()
	end

end

----------------------------------------------------
-- CREATE
----------------------------------------------------

function ESP:Create(player)

	if not Config then
		warn("ESP not initialized.")
		return
	end

	if not Tracker then
		warn("Tracker not initialized.")
		return
	end

	local data = Tracker:GetData(player)

	if not data then
		return
	end

	if not data.IsTracking then
		return
	end

	local character = player.Character

	if not character then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")

	if not root then
		return
	end

	self:Remove(player)

	local billboard = Instance.new("BillboardGui")
	billboard.Name = ESP_NAME
	billboard.Adornee = root
	billboard.Size = Config.ESP.BillboardSize
	billboard.StudsOffset = Config.ESP.StudOffset
	billboard.AlwaysOnTop = true
	billboard.Parent = character

	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(1,1)
	label.BackgroundTransparency = 1
	label.Text = player.DisplayName
	label.Font = Enum.Font.GothamMedium
	label.TextSize = Config.ESP.TextSize
	label.TextColor3 = data.Alignment
	label.TextStrokeTransparency = 1
	label.Parent = billboard

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(15,15,15)
	stroke.Thickness = 1.2
	stroke.Transparency = 0.2
	stroke.Parent = label

	local highlight = Instance.new("Highlight")
	highlight.Adornee = character
	highlight.FillColor = data.Alignment
	highlight.FillTransparency = Config.ESP.HighlightTransparency
	highlight.OutlineTransparency = Config.ESP.OutlineTransparency
	highlight.OutlineColor = Color3.new(1,1,1)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = billboard

end

----------------------------------------------------
-- UPDATE
----------------------------------------------------

function ESP:Update(player)

	self:Remove(player)
	self:Create(player)

end

----------------------------------------------------
-- UPDATE ALL
----------------------------------------------------

function ESP:Refresh()

	for _,player in ipairs(Players:GetPlayers()) do

		if player ~= Players.LocalPlayer then

			local data = Tracker:GetData(player)

			if data and data.IsTracking then
				self:Update(player)
			else
				self:Remove(player)
			end

		end

	end

end

----------------------------------------------------
-- CLEAR
----------------------------------------------------

function ESP:Clear()

	for _,player in ipairs(Players:GetPlayers()) do
		self:Remove(player)
	end

end

return ESP
