local UI = {}

local Players = game:GetService("Players")

local Config
local Tracker


local ScreenGui
local Main
local SearchBox
local Scroll
local StatusIndicator
local RefreshButton


------------------------------------------------
-- INIT
------------------------------------------------

function UI:Init(configModule, trackerModule)

	Config = configModule
	Tracker = trackerModule

	self:Create()

end


------------------------------------------------
-- CREAR UI
------------------------------------------------

function UI:Create()

	local hiddenUI = (gethui and gethui()) or game:GetService("CoreGui")


	ScreenGui = Instance.new("ScreenGui")

	ScreenGui.Name = Config.UI.Name

	ScreenGui.ResetOnSpawn = false

	ScreenGui.Parent = hiddenUI



	----------------------------------------------
	-- MAIN FRAME
	----------------------------------------------

	Main = Instance.new("Frame")

	Main.Size =
		UDim2.new(
			0,
			Config.UI.Width,
			0,
			Config.UI.Height
		)

	Main.Position = Config.UI.Position

	Main.BackgroundColor3 =
		Config.Colors.Background

	Main.BorderSizePixel = 0

	Main.Active = true

	Main.Draggable = true

	Main.Parent = ScreenGui



	local corner = Instance.new("UICorner")

	corner.CornerRadius = UDim.new(0,10)

	corner.Parent = Main



	----------------------------------------------
	-- TITLE
	----------------------------------------------

	local Title = Instance.new("TextLabel")

	Title.Size =
		UDim2.new(1,-190,0,40)

	Title.Position =
		UDim2.new(0,10,0,0)

	Title.Text =
		"ELITE TRACKER"

	Title.TextColor3 =
		Config.Colors.Text

	Title.Font =
		Enum.Font.GothamBold

	Title.TextSize = 12

	Title.TextXAlignment =
		Enum.TextXAlignment.Left

	Title.BackgroundTransparency = 1

	Title.Parent = Main



	----------------------------------------------
	-- STATUS
	----------------------------------------------

	StatusIndicator = Instance.new("TextLabel")

	StatusIndicator.Size =
		UDim2.new(0,130,0,40)

	StatusIndicator.Position =
		UDim2.new(1,-150,0,0)

	StatusIndicator.BackgroundTransparency = 1

	StatusIndicator.Text =
		"● LOCK OFF"

	StatusIndicator.TextColor3 =
		Config.Colors.Enemy

	StatusIndicator.Font =
		Enum.Font.GothamBold

	StatusIndicator.TextSize = 10

	StatusIndicator.TextXAlignment =
		Enum.TextXAlignment.Right

	StatusIndicator.Parent = Main



	----------------------------------------------
	-- SEARCH
	----------------------------------------------

	SearchBox = Instance.new("TextBox")

	SearchBox.Size =
		UDim2.new(1,-40,0,35)

	SearchBox.Position =
		UDim2.new(0,20,0,45)

	SearchBox.BackgroundColor3 =
		Config.Colors.Row

	SearchBox.PlaceholderText =
		"Buscar jugador..."

	SearchBox.TextColor3 =
		Color3.new(1,1,1)

	SearchBox.Font =
		Enum.Font.Gotham

	SearchBox.TextSize = 13

	SearchBox.Parent = Main



	local searchCorner = Instance.new("UICorner")

	searchCorner.CornerRadius =
		UDim.new(0,6)

	searchCorner.Parent = SearchBox



	----------------------------------------------
	-- PLAYER LIST
	----------------------------------------------

	Scroll = Instance.new("ScrollingFrame")

	Scroll.Size =
		UDim2.new(1,-20,1,-100)

	Scroll.Position =
		UDim2.new(0,10,0,90)

	Scroll.BackgroundTransparency = 1

	Scroll.ScrollBarThickness = 2

	Scroll.Parent = Main



	local layout = Instance.new("UIListLayout")

	layout.SortOrder =
		Enum.SortOrder.Name

	layout.Padding =
		UDim.new(0,5)

	layout.Parent = Scroll



	----------------------------------------------
	-- REFRESH BUTTON
	----------------------------------------------

	RefreshButton = Instance.new("TextButton")

	RefreshButton.Size =
		UDim2.new(0,30,0,30)

	RefreshButton.Position =
		UDim2.new(1,-35,0,5)

	RefreshButton.Text =
		"🔄"

	RefreshButton.BackgroundColor3 =
		Config.Colors.Row

	RefreshButton.TextColor3 =
		Config.Colors.Text

	RefreshButton.Font =
		Enum.Font.GothamBold

	RefreshButton.TextSize = 14

	RefreshButton.Parent = Main



	local refreshCorner = Instance.new("UICorner")

	refreshCorner.CornerRadius =
		UDim.new(0,6)

	refreshCorner.Parent = RefreshButton


end



------------------------------------------------
-- API
------------------------------------------------

function UI:GetSearchBox()
	return SearchBox
end


function UI:GetScroll()
	return Scroll
end


function UI:GetMain()
	return Main
end


function UI:GetRefreshButton()
	return RefreshButton
end


function UI:SetStatus(text,color)

	if StatusIndicator then

		StatusIndicator.Text = text

		StatusIndicator.TextColor3 = color

	end

end


return UI

------------------------------------------------
-- CREAR FILA DE JUGADOR
------------------------------------------------

function UI:CreatePlayerRow(player)

	if player == Players.LocalPlayer then
		return
	end


	local row = Instance.new("Frame")

	row.Name = player.Name

	row.Size =
		UDim2.new(1,-10,0,60)

	row.BackgroundColor3 =
		Config.Colors.Row

	row.Parent = Scroll



	local corner = Instance.new("UICorner")

	corner.CornerRadius =
		UDim.new(0,8)

	corner.Parent = row



	----------------------------------------
	-- AVATAR
	----------------------------------------

	local avatar = Instance.new("ImageLabel")

	avatar.Size =
		UDim2.new(0,40,0,40)

	avatar.Position =
		UDim2.new(0,10,0.5,-20)

	avatar.BackgroundColor3 =
		Config.Colors.Background

	avatar.Parent = row


	pcall(function()

		avatar.Image =
			Players:GetUserThumbnailAsync(
				player.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size48x48
			)

	end)



	local avatarCorner = Instance.new("UICorner")

	avatarCorner.CornerRadius =
		UDim.new(1,0)

	avatarCorner.Parent = avatar



	----------------------------------------
	-- INFO
	----------------------------------------

	local info = Instance.new("TextLabel")

	info.Size =
		UDim2.new(.5,0,1,0)

	info.Position =
		UDim2.new(0,60,0,0)

	info.BackgroundTransparency = 1

	info.Text =
		player.DisplayName ..
		"\n@" ..
		player.Name

	info.TextColor3 =
		Color3.new(1,1,1)

	info.Font =
		Enum.Font.GothamBold

	info.TextSize = 13

	info.TextXAlignment =
		Enum.TextXAlignment.Left

	info.Parent = row



	----------------------------------------
	-- ENEMY BUTTON
	----------------------------------------

	local enemy = Instance.new("TextButton")

	enemy.Size =
		UDim2.new(0,40,0,40)

	enemy.Position =
		UDim2.new(1,-45,.5,-20)

	enemy.Text = "E"

	enemy.BackgroundColor3 =
		Config.Colors.Enemy

	enemy.TextColor3 =
		Color3.new(1,1,1)

	enemy.Font =
		Enum.Font.GothamBold

	enemy.Parent = row



	local enemyCorner = Instance.new("UICorner")

	enemyCorner.CornerRadius =
		UDim.new(0,6)

	enemyCorner.Parent = enemy



	----------------------------------------
	-- FRIEND BUTTON
	----------------------------------------

	local friend = Instance.new("TextButton")

	friend.Size =
		UDim2.new(0,40,0,40)

	friend.Position =
		UDim2.new(1,-90,.5,-20)

	friend.Text="F"

	friend.BackgroundColor3 =
		Config.Colors.Friend

	friend.TextColor3 =
		Color3.new(0,0,0)

	friend.Font =
		Enum.Font.GothamBold

	friend.Parent=row



	local friendCorner = Instance.new("UICorner")

	friendCorner.CornerRadius =
		UDim.new(0,6)

	friendCorner.Parent = friend



	----------------------------------------
	-- FUNCION TRACK
	----------------------------------------

	local function setTrack(color)


		local data =
			Tracker:GetData(player)


		if data and data.IsTracking
		and data.Alignment == color then


			Tracker:SetTracking(
				player,
				false,
				color
			)


			ESP:Remove(player)


			info.TextColor3 =
				Color3.new(1,1,1)


		else


			Tracker:SetTracking(
				player,
				true,
				color
			)


			ESP:Create(player)


			info.TextColor3 =
				color

		end


	end



	enemy.MouseButton1Click:Connect(function()

		setTrack(
			Config.Colors.Enemy
		)

	end)



	friend.MouseButton1Click:Connect(function()

		setTrack(
			Config.Colors.Friend
		)

	end)



end



------------------------------------------------
-- REFRESH PLAYERS
------------------------------------------------

function UI:RefreshPlayers()


	for _,item in ipairs(Scroll:GetChildren()) do

		if item:IsA("Frame") then

			item:Destroy()

		end

	end



	for _,player in ipairs(Players:GetPlayers()) do

		self:CreatePlayerRow(player)

	end


end

------------------------------------------------
-- BUSCADOR
------------------------------------------------

function UI:SetupSearch()

	if not SearchBox then
		return
	end


	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()

		local text = SearchBox.Text:lower()


		for _,item in ipairs(Scroll:GetChildren()) do

			if item:IsA("Frame") then

				local name = item.Name:lower()


				item.Visible =
					name:find(text)
					~= nil

			end

		end


	end)

end


------------------------------------------------
-- BOTON REFRESH
------------------------------------------------

function UI:SetupRefresh()


	if not RefreshButton then
		return
	end


	RefreshButton.MouseButton1Click:Connect(function()

		self:RefreshPlayers()

	end)

end



------------------------------------------------
-- ACTUALIZAR ESTADO
------------------------------------------------

function UI:UpdateStatus()


	if not Tracker then
		return
	end



	local target =
		Tracker:GetLock()



	if Tracker.IsLocked
	and target then


		local player =
			Players:GetPlayerFromCharacter(target)



		if player then


			if Tracker.RageMode then


				self:SetStatus(
					"☠ RAGE: "..player.DisplayName,
					Config.Colors.Rage
				)


			else


				self:SetStatus(
					"● LOCK: "..player.DisplayName,
					Config.Colors.Friend
				)


			end


			return

		end

	end



	self:SetStatus(
		"● LOCK OFF",
		Config.Colors.Enemy
	)


end



------------------------------------------------
-- VISIBILIDAD
------------------------------------------------

function UI:Toggle()


	if Main then

		Main.Visible =
			not Main.Visible

	end


end



function UI:SetVisible(state)


	if Main then

		Main.Visible = state

	end


end



function UI:IsVisible()


	if Main then

		return Main.Visible

	end


	return false

end



------------------------------------------------
-- INICIALIZAR EVENTOS
------------------------------------------------

function UI:Start()


	self:SetupSearch()

	self:SetupRefresh()

	self:RefreshPlayers()

end
