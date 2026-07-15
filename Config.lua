local Config = {}

--==================================================
-- INFORMACIÓN DEL SISTEMA
--==================================================

Config.Name = "Elite Tracker"
Config.Version = "5.0"

--==================================================
-- TECLAS
--==================================================

Config.Keys = {
    ToggleUI = Enum.KeyCode.Z,
    Panic = Enum.KeyCode.KeypadFive,
    QuickTrack = Enum.KeyCode.C,

    LegitLock = Enum.KeyCode.Q,
    RageLock = Enum.KeyCode.P,
}

--==================================================
-- AIM SETTINGS
--==================================================

Config.Aim = {

    LegitSmoothness = 5,

    HumanJitter = 1.5,

    FieldOfView = 200,

    RagePrediction = 0.165,

    CameraLerp = 0.12,

}

--==================================================
-- UI
--==================================================

Config.UI = {

    Name = "EliteTracker_V5_System",

    Width = 350,

    Height = 450,

    Position = UDim2.new(0,50,0.5,-225)

}

--==================================================
-- COLORES
--==================================================

Config.Colors = {

    Background = Color3.fromRGB(12,12,12),

    Row = Color3.fromRGB(22,22,22),

    Friend = Color3.fromRGB(0,255,150),

    Enemy = Color3.fromRGB(255,50,50),

    Accent = Color3.fromRGB(100,100,255),

    Rage = Color3.fromRGB(255,0,100),

    Text = Color3.fromRGB(255,255,255),

}

--==================================================
-- ESP
--==================================================

Config.ESP = {

    BillboardSize = UDim2.new(0,150,0,20),

    StudOffset = Vector3.new(0,-3.5,0),

    TextSize = 11,

    HighlightTransparency = 0.75,

    OutlineTransparency = 0.6,

}

--==================================================
-- TRACKER
--==================================================

Config.Tracker = {

    AutoRestoreESP = true,

    KeepTrackedPlayers = true,

}

return Config
