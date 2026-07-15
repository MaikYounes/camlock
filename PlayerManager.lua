local PlayerManager = {}

local Players = game:GetService("Players")

local Maid = nil
local Tracker = nil
local ESP = nil

local managerMaid

--------------------------------------------------
-- INIT
--------------------------------------------------

function PlayerManager:Init(maidModule, trackerModule, espModule)

    Maid = maidModule
    Tracker = trackerModule
    ESP = espModule

    managerMaid = Maid.new()

end

--------------------------------------------------
-- CHARACTER
--------------------------------------------------

function PlayerManager:CharacterAdded(player, character)

    task.wait(0.2)

    local data = Tracker:GetData(player)

    if not data then
        return
    end

    if data.IsTracking then
        ESP:Create(player)
    end

    if Tracker:GetLock() then

        local lockedPlayer = Players:GetPlayerFromCharacter(Tracker:GetLock())

        if lockedPlayer == player then
            Tracker:SetLock(character)
        end

    end

end

--------------------------------------------------
-- PLAYER ADDED
--------------------------------------------------

function PlayerManager:PlayerAdded(player)

    managerMaid:Give(

        player.CharacterAdded:Connect(function(character)

            self:CharacterAdded(player, character)

        end)

    )

    if player.Character then
        task.spawn(function()
            self:CharacterAdded(player, player.Character)
        end)
    end

end

--------------------------------------------------
-- PLAYER REMOVING
--------------------------------------------------

function PlayerManager:PlayerRemoving(player)

    local locked = Tracker:GetLock()

    if locked then

        local target = Players:GetPlayerFromCharacter(locked)

        if target == player then
            Tracker:Unlock()
        end

    end

end

--------------------------------------------------
-- START
--------------------------------------------------

function PlayerManager:Start()

    for _,player in ipairs(Players:GetPlayers()) do

        if player ~= Players.LocalPlayer then

            self:PlayerAdded(player)

        end

    end

    managerMaid:Give(

        Players.PlayerAdded:Connect(function(player)

            self:PlayerAdded(player)

        end)

    )

    managerMaid:Give(

        Players.PlayerRemoving:Connect(function(player)

            self:PlayerRemoving(player)

        end)

    )

end

--------------------------------------------------
-- STOP
--------------------------------------------------

function PlayerManager:Stop()

    if managerMaid then
        managerMaid:Cleanup()
    end

end

return PlayerManager
