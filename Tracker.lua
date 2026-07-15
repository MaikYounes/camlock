local Tracker = {}

--========================================
-- DATOS
--========================================

Tracker.Players = {}

Tracker.LockedTarget = nil
Tracker.IsLocked = false
Tracker.RageMode = false

--========================================
-- TRACKING
--========================================

function Tracker:SetTracking(player, enabled, color)
    if not player then
        return
    end

    self.Players[player.UserId] = {
        Player = player,
        IsTracking = enabled,
        Alignment = color
    }
end

function Tracker:RemoveTracking(player)
    if not player then
        return
    end

    self.Players[player.UserId] = nil
end

function Tracker:GetData(player)
    if not player then
        return nil
    end

    return self.Players[player.UserId]
end

function Tracker:IsTracking(player)
    local data = self:GetData(player)

    if not data then
        return false
    end

    return data.IsTracking
end

function Tracker:GetColor(player)
    local data = self:GetData(player)

    if not data then
        return nil
    end

    return data.Alignment
end

function Tracker:GetTrackedPlayers()

    local list = {}

    for _,data in pairs(self.Players) do
        if data.IsTracking then
            table.insert(list,data.Player)
        end
    end

    return list

end

--========================================
-- LOCK
--========================================

function Tracker:SetLock(character)

    self.LockedTarget = character
    self.IsLocked = character ~= nil

end

function Tracker:GetLock()

    return self.LockedTarget

end

function Tracker:Unlock()

    self.LockedTarget = nil
    self.IsLocked = false
    self.RageMode = false

end

function Tracker:SetRage(state)

    self.RageMode = state

end

--========================================
-- LIMPIEZA
--========================================

function Tracker:Clear()

    self.Players = {}

    self.LockedTarget = nil

    self.IsLocked = false

    self.RageMode = false

end

return Tracker
