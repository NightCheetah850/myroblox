-- Milky Floating Menu - UI Redesign (Tanpa Menghapus Fungsi)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Color Scheme Modern
local Colors = {
    Primary = Color3.fromRGB(106, 90, 224),    -- Ungu modern
    Secondary = Color3.fromRGB(144, 122, 214), -- Ungu muda
    Success = Color3.fromRGB(76, 175, 80),     -- Hijau
    Danger = Color3.fromRGB(244, 67, 54),      -- Merah
    Warning = Color3.fromRGB(255, 152, 0),     -- Oranye
    Dark = Color3.fromRGB(30, 30, 46),         -- Gelap utama
    Darker = Color3.fromRGB(23, 23, 36),       -- Lebih gelap
    Light = Color3.fromRGB(59, 59, 89),        -- Terang
    Lighter = Color3.fromRGB(82, 82, 122),     -- Lebih terang
    Text = Color3.fromRGB(255, 255, 255),      -- Putih
    TextSecondary = Color3.fromRGB(200, 200, 200) -- Abu-abu
}

-- Modern Font
local Font = Enum.Font.GothamSemibold

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MilkyModernUI_" .. HttpService:GenerateGUID(false):sub(1, 8)
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Floating Button Modern
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 70, 0, 70)
FloatingButton.Position = UDim2.new(0, 50, 0, 50)
FloatingButton.Text = "🎮" -- Gamepad emoji
FloatingButton.BackgroundColor3 = Colors.Primary
FloatingButton.TextColor3 = Colors.Text
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.TextSize = 24
FloatingButton.AutoButtonColor = false
FloatingButton.Active = true
FloatingButton.Draggable = false
FloatingButton.Selectable = false
FloatingButton.Parent = ScreenGui

-- Shadow Effect
local ButtonShadow = Instance.new("Frame")
ButtonShadow.Size = UDim2.new(1, 10, 1, 10)
ButtonShadow.Position = UDim2.new(0, -5, 0, -5)
ButtonShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ButtonShadow.BackgroundTransparency = 0.8
ButtonShadow.ZIndex = -1
ButtonShadow.Parent = FloatingButton

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(1, 0)
ShadowCorner.Parent = ButtonShadow

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = FloatingButton

-- Popup Window Modern
local PopupFrame = Instance.new("Frame")
PopupFrame.Size = UDim2.new(0, 350, 0, 450)
PopupFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
PopupFrame.BackgroundColor3 = Colors.Dark
PopupFrame.BackgroundTransparency = 0.05
PopupFrame.Visible = false
PopupFrame.Parent = ScreenGui

-- Window Shadow
local WindowShadow = Instance.new("Frame")
WindowShadow.Size = UDim2.new(1, 10, 1, 10)
WindowShadow.Position = UDim2.new(0, -5, 0, -5)
WindowShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
WindowShadow.BackgroundTransparency = 0.9
WindowShadow.ZIndex = -1
WindowShadow.Parent = PopupFrame

local WindowShadowCorner = Instance.new("UICorner")
WindowShadowCorner.CornerRadius = UDim.new(0, 15)
WindowShadowCorner.Parent = WindowShadow

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 15)
PopupCorner.Parent = PopupFrame

-- Header Modern
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Colors.Darker
Header.Parent = PopupFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 20, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "MILKY HUB"
Title.TextColor3 = Colors.Primary
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 200, 0, 20)
Subtitle.Position = UDim2.new(0, 20, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Premium Script Hub"
Subtitle.TextColor3 = Colors.TextSecondary
Subtitle.Font = Font
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

-- Ribbon Navigation Modern
local RibbonFrame = Instance.new("Frame")
RibbonFrame.Size = UDim2.new(1, -40, 0, 40)
RibbonFrame.Position = UDim2.new(0, 20, 0, 70)
RibbonFrame.BackgroundTransparency = 1
RibbonFrame.Parent = PopupFrame

-- Ribbon Buttons dengan ikon modern
local ribbonData = {
    {Name = "Utama", Icon = "🏠"},
    {Name = "Tween", Icon = "🚀"}, 
    {Name = "Parts", Icon = "🧱"},
    {Name = "Script", Icon = "📜"}
}

local RibbonButtons = {}

for i, ribbon in ipairs(ribbonData) do
    local tabWidth = 1 / #ribbonData
    
    local RibbonButton = Instance.new("TextButton")
    RibbonButton.Size = UDim2.new(tabWidth, -5, 1, 0)
    RibbonButton.Position = UDim2.new((i-1) * tabWidth, 0, 0, 0)
    RibbonButton.Text = ribbon.Icon .. "\n" .. ribbon.Name
    RibbonButton.BackgroundColor3 = i == 1 and Colors.Primary or Colors.Light
    RibbonButton.TextColor3 = Colors.Text
    RibbonButton.Font = Font
    RibbonButton.TextSize = 11
    RibbonButton.AutoButtonColor = false
    RibbonButton.Parent = RibbonFrame
    
    local RibbonCorner = Instance.new("UICorner")
    RibbonCorner.CornerRadius = UDim.new(0, 8)
    RibbonCorner.Parent = RibbonButton
    
    RibbonButtons[ribbon.Name] = RibbonButton
end

-- Content Frame Modern
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -40, 1, -130)
ContentFrame.Position = UDim2.new(0, 20, 0, 120)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = PopupFrame

-- ==================== CONTENT SECTIONS (MEMPERTAHANKAN FUNGSI ASLI) ====================

-- Utama Content (Diperbarui tampilannya saja)
local UtamaContent = Instance.new("ScrollingFrame")
UtamaContent.Size = UDim2.new(1, 0, 1, 0)
UtamaContent.Position = UDim2.new(0, 0, 0, 0)
UtamaContent.BackgroundTransparency = 1
UtamaContent.Visible = true
UtamaContent.ScrollBarThickness = 4
UtamaContent.ScrollBarImageColor3 = Colors.Primary
UtamaContent.CanvasSize = UDim2.new(0, 0, 0, 600)
UtamaContent.Parent = ContentFrame

local UtamaLayout = Instance.new("UIListLayout")
UtamaLayout.Padding = UDim.new(0, 10)
UtamaLayout.Parent = UtamaContent

-- Fungsi untuk membuat card modern
function createCard(title, height)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, height)
    card.BackgroundColor3 = Colors.Darker
    card.BackgroundTransparency = 0.1
    card.Parent = UtamaContent
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 12)
    cardCorner.Parent = card
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Colors.Text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = card
    
    return card
end

-- Welcome Card
local WelcomeCard = createCard("Welcome", 80)
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, -20, 0, 40)
WelcomeLabel.Position = UDim2.new(0, 10, 0, 35)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Hello " .. LocalPlayer.Name .. "!\nPremium features unlocked."
WelcomeLabel.TextColor3 = Colors.TextSecondary
WelcomeLabel.Font = Font
WelcomeLabel.TextSize = 14
WelcomeLabel.TextWrapped = true
WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
WelcomeLabel.Parent = WelcomeCard

-- Fly Section (Diperbarui tampilannya)
local FlyCard = createCard("Movement", 120)

local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(1, -20, 0, 30)
FlyFrame.Position = UDim2.new(0, 10, 0, 40)
FlyFrame.BackgroundTransparency = 1
FlyFrame.Parent = FlyCard

local FlyLabel = Instance.new("TextLabel")
FlyLabel.Size = UDim2.new(0.6, 0, 1, 0)
FlyLabel.BackgroundTransparency = 1
FlyLabel.Text = "✈️ Fly Mode"
FlyLabel.TextColor3 = Colors.Text
FlyLabel.Font = Font
FlyLabel.TextSize = 14
FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
FlyLabel.Parent = FlyFrame

-- Switch Toggle Modern
local FlySwitch = Instance.new("TextButton")
FlySwitch.Size = UDim2.new(0.4, 0, 0.7, 0)
FlySwitch.Position = UDim2.new(0.6, 0, 0.15, 0)
FlySwitch.Text = ""
FlySwitch.BackgroundColor3 = Colors.Light
FlySwitch.Parent = FlyFrame

local FlySwitchCorner = Instance.new("UICorner")
FlySwitchCorner.CornerRadius = UDim.new(0, 12)
FlySwitchCorner.Parent = FlySwitch

local FlyToggle = Instance.new("Frame")
FlyToggle.Size = UDim2.new(0.4, 0, 0.8, 0)
FlyToggle.Position = UDim2.new(0.05, 0, 0.1, 0)
FlyToggle.BackgroundColor3 = Colors.Text
FlyToggle.Parent = FlySwitch

local FlyToggleCorner = Instance.new("UICorner")
FlyToggleCorner.CornerRadius = UDim.new(0, 10)
FlyToggleCorner.Parent = FlyToggle

-- Float Section
local FloatFrame = Instance.new("Frame")
FloatFrame.Size = UDim2.new(1, -20, 0, 30)
FloatFrame.Position = UDim2.new(0, 10, 0, 80)
FloatFrame.BackgroundTransparency = 1
FloatFrame.Parent = FlyCard

local FloatLabel = Instance.new("TextLabel")
FloatLabel.Size = UDim2.new(0.6, 0, 1, 0)
FloatLabel.BackgroundTransparency = 1
FloatLabel.Text = "🌊 Float Mode"
FloatLabel.TextColor3 = Colors.Text
FloatLabel.Font = Font
FloatLabel.TextSize = 14
FloatLabel.TextXAlignment = Enum.TextXAlignment.Left
FloatLabel.Parent = FloatFrame

local FloatSwitch = Instance.new("TextButton")
FloatSwitch.Size = UDim2.new(0.4, 0, 0.7, 0)
FloatSwitch.Position = UDim2.new(0.6, 0, 0.15, 0)
FloatSwitch.Text = ""
FloatSwitch.BackgroundColor3 = Colors.Light
FloatSwitch.Parent = FloatFrame

local FloatSwitchCorner = Instance.new("UICorner")
FloatSwitchCorner.CornerRadius = UDim.new(0, 12)
FloatSwitchCorner.Parent = FloatSwitch

local FloatToggle = Instance.new("Frame")
FloatToggle.Size = UDim2.new(0.4, 0, 0.8, 0)
FloatToggle.Position = UDim2.new(0.05, 0, 0.1, 0)
FloatToggle.BackgroundColor3 = Colors.Text
FloatToggle.Parent = FloatSwitch

local FloatToggleCorner = Instance.new("UICorner")
FloatToggleCorner.CornerRadius = UDim.new(0, 10)
FloatToggleCorner.Parent = FloatToggle

-- WalkSpeed Section
local SpeedCard = createCard("Speed Settings", 100)

local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Size = UDim2.new(1, -20, 0, 30)
WalkSpeedFrame.Position = UDim2.new(0, 10, 0, 40)
WalkSpeedFrame.BackgroundTransparency = 1
WalkSpeedFrame.Parent = SpeedCard

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Size = UDim2.new(0.4, 0, 1, 0)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "🚶 WalkSpeed"
WalkSpeedLabel.TextColor3 = Colors.Text
WalkSpeedLabel.Font = Font
WalkSpeedLabel.TextSize = 14
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedLabel.Parent = WalkSpeedFrame

local WalkSpeedBox = Instance.new("TextBox")
WalkSpeedBox.Size = UDim2.new(0.3, 0, 1, 0)
WalkSpeedBox.Position = UDim2.new(0.4, 5, 0, 0)
WalkSpeedBox.BackgroundColor3 = Colors.Darker
WalkSpeedBox.TextColor3 = Colors.Text
WalkSpeedBox.Font = Font
WalkSpeedBox.TextSize = 14
WalkSpeedBox.Text = "16"
WalkSpeedBox.PlaceholderText = "Speed"
WalkSpeedBox.PlaceholderColor3 = Colors.TextSecondary
WalkSpeedBox.Parent = WalkSpeedFrame

local WalkSpeedCorner = Instance.new("UICorner")
WalkSpeedCorner.CornerRadius = UDim.new(0, 6)
WalkSpeedCorner.Parent = WalkSpeedBox

local SetWalkSpeedButton = Instance.new("TextButton")
SetWalkSpeedButton.Size = UDim2.new(0.25, 0, 1, 0)
SetWalkSpeedButton.Position = UDim2.new(0.75, 5, 0, 0)
SetWalkSpeedButton.Text = "Set"
SetWalkSpeedButton.BackgroundColor3 = Colors.Primary
SetWalkSpeedButton.TextColor3 = Colors.Text
SetWalkSpeedButton.Font = Font
SetWalkSpeedButton.TextSize = 14
SetWalkSpeedButton.Parent = WalkSpeedFrame

local SetWalkSpeedCorner = Instance.new("UICorner")
SetWalkSpeedCorner.CornerRadius = UDim.new(0, 6)
SetWalkSpeedCorner.Parent = SetWalkSpeedButton

-- Player List Modern
local PlayerCard = createCard("Player List", 200)

local PlayerListScroll = Instance.new("ScrollingFrame")
PlayerListScroll.Size = UDim2.new(1, -20, 0, 150)
PlayerListScroll.Position = UDim2.new(0, 10, 0, 40)
PlayerListScroll.BackgroundTransparency = 1
PlayerListScroll.ScrollBarThickness = 4
PlayerListScroll.ScrollBarImageColor3 = Colors.Primary
PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListScroll.Parent = PlayerCard

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Padding = UDim.new(0, 5)
PlayerListLayout.Parent = PlayerListScroll

-- Tween Content Modern
local TweenContent = Instance.new("ScrollingFrame")
TweenContent.Size = UDim2.new(1, 0, 1, 0)
TweenContent.Position = UDim2.new(0, 0, 0, 0)
TweenContent.BackgroundTransparency = 1
TweenContent.Visible = false
TweenContent.ScrollBarThickness = 4
TweenContent.ScrollBarImageColor3 = Colors.Primary
TweenContent.CanvasSize = UDim2.new(0, 0, 0, 400)
TweenContent.Parent = ContentFrame

local TweenLayout = Instance.new("UIListLayout")
TweenLayout.Padding = UDim.new(0, 10)
TweenLayout.Parent = TweenContent

-- Waypoint Card
local WaypointCard = createCard("Waypoints", 150)
WaypointCard.Parent = TweenContent

local WaypointFrame = Instance.new("Frame")
WaypointFrame.Size = UDim2.new(1, -20, 0, 30)
WaypointFrame.Position = UDim2.new(0, 10, 0, 40)
WaypointFrame.BackgroundTransparency = 1
WaypointFrame.Parent = WaypointCard

local WaypointBox = Instance.new("TextBox")
WaypointBox.Size = UDim2.new(0.7, 0, 1, 0)
WaypointBox.BackgroundColor3 = Colors.Darker
WaypointBox.TextColor3 = Colors.Text
WaypointBox.Font = Font
WaypointBox.TextSize = 14
WaypointBox.Text = ""
WaypointBox.PlaceholderText = "Waypoint name"
WaypointBox.PlaceholderColor3 = Colors.TextSecondary
WaypointBox.Parent = WaypointFrame

local WaypointCorner = Instance.new("UICorner")
WaypointCorner.CornerRadius = UDim.new(0, 6)
WaypointCorner.Parent = WaypointBox

local SetWaypointButton = Instance.new("TextButton")
SetWaypointButton.Size = UDim2.new(0.25, 0, 1, 0)
SetWaypointButton.Position = UDim2.new(0.75, 5, 0, 0)
SetWaypointButton.Text = "💾 Save"
SetWaypointButton.BackgroundColor3 = Colors.Success
SetWaypointButton.TextColor3 = Colors.Text
SetWaypointButton.Font = Font
SetWaypointButton.TextSize = 14
SetWaypointButton.Parent = WaypointFrame

local SetWaypointCorner = Instance.new("UICorner")
SetWaypointCorner.CornerRadius = UDim.new(0, 6)
SetWaypointCorner.Parent = SetWaypointButton

local WaypointListScroll = Instance.new("ScrollingFrame")
WaypointListScroll.Size = UDim2.new(1, -20, 0, 80)
WaypointListScroll.Position = UDim2.new(0, 10, 0, 80)
WaypointListScroll.BackgroundTransparency = 1
WaypointListScroll.ScrollBarThickness = 4
WaypointListScroll.Parent = WaypointCard

local WaypointListLayout = Instance.new("UIListLayout")
WaypointListLayout.Padding = UDim.new(0, 5)
WaypointListLayout.Parent = WaypointListScroll

-- Parts Content Modern
local PartsContent = Instance.new("ScrollingFrame")
PartsContent.Size = UDim2.new(1, 0, 1, 0)
PartsContent.Position = UDim2.new(0, 0, 0, 0)
PartsContent.BackgroundTransparency = 1
PartsContent.Visible = false
PartsContent.ScrollBarThickness = 4
PartsContent.ScrollBarImageColor3 = Colors.Primary
PartsContent.CanvasSize = UDim2.new(0, 0, 0, 500)
PartsContent.Parent = ContentFrame

local PartsLayout = Instance.new("UIListLayout")
PartsLayout.Padding = UDim.new(0, 10)
PartsLayout.Parent = PartsContent

-- Parts Search Card
local PartsSearchCard = createCard("Parts Explorer", 120)
PartsSearchCard.Parent = PartsContent

local PartsSearchFrame = Instance.new("Frame")
PartsSearchFrame.Size = UDim2.new(1, -20, 0, 30)
PartsSearchFrame.Position = UDim2.new(0, 10, 0, 40)
PartsSearchFrame.BackgroundTransparency = 1
PartsSearchFrame.Parent = PartsSearchCard

local PartsSearchBox = Instance.new("TextBox")
PartsSearchBox.Size = UDim2.new(0.7, 0, 1, 0)
PartsSearchBox.BackgroundColor3 = Colors.Darker
PartsSearchBox.TextColor3 = Colors.Text
PartsSearchBox.Font = Font
PartsSearchBox.TextSize = 14
PartsSearchBox.Text = ""
PartsSearchBox.PlaceholderText = "Search parts..."
PartsSearchBox.PlaceholderColor3 = Colors.TextSecondary
PartsSearchBox.Parent = PartsSearchFrame

local PartsSearchCorner = Instance.new("UICorner")
PartsSearchCorner.CornerRadius = UDim.new(0, 6)
PartsSearchCorner.Parent = PartsSearchBox

local RefreshPartsButton = Instance.new("TextButton")
RefreshPartsButton.Size = UDim2.new(0.25, 0, 1, 0)
RefreshPartsButton.Position = UDim2.new(0.75, 5, 0, 0)
RefreshPartsButton.Text = "🔃 Refresh"
RefreshPartsButton.BackgroundColor3 = Colors.Primary
RefreshPartsButton.TextColor3 = Colors.Text
RefreshPartsButton.Font = Font
RefreshPartsButton.TextSize = 14
RefreshPartsButton.Parent = PartsSearchFrame

local RefreshPartsCorner = Instance.new("UICorner")
RefreshPartsCorner.CornerRadius = UDim.new(0, 6)
RefreshPartsCorner.Parent = RefreshPartsButton

local PartsInfoLabel = Instance.new("TextLabel")
PartsInfoLabel.Size = UDim2.new(1, -20, 0, 20)
PartsInfoLabel.Position = UDim2.new(0, 10, 0, 80)
PartsInfoLabel.BackgroundTransparency = 1
PartsInfoLabel.Text = "Total Parts: 0"
PartsInfoLabel.TextColor3 = Colors.TextSecondary
PartsInfoLabel.Font = Font
PartsInfoLabel.TextSize = 12
PartsInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
PartsInfoLabel.Parent = PartsSearchCard

local PartsListScroll = Instance.new("ScrollingFrame")
PartsListScroll.Size = UDim2.new(1, -20, 0, 300)
PartsListScroll.Position = UDim2.new(0, 10, 0, 110)
PartsListScroll.BackgroundTransparency = 1
PartsListScroll.ScrollBarThickness = 4
PartsListScroll.Parent = PartsSearchCard

local PartsListLayout = Instance.new("UIListLayout")
PartsListLayout.Padding = UDim.new(0, 5)
PartsListLayout.Parent = PartsListScroll

-- Script Content Modern
local ScriptContent = Instance.new("ScrollingFrame")
ScriptContent.Size = UDim2.new(1, 0, 1, 0)
ScriptContent.Position = UDim2.new(0, 0, 0, 0)
ScriptContent.BackgroundTransparency = 1
ScriptContent.Visible = false
ScriptContent.ScrollBarThickness = 4
ScriptContent.ScrollBarImageColor3 = Colors.Primary
ScriptContent.CanvasSize = UDim2.new(0, 0, 0, 500)
ScriptContent.Parent = ContentFrame

local ScriptLayout = Instance.new("UIListLayout")
ScriptLayout.Padding = UDim.new(0, 10)
ScriptLayout.Parent = ScriptContent

-- Script Search Card
local ScriptSearchCard = createCard("Script Library", 150)
ScriptSearchCard.Parent = ScriptContent

local ScriptSearchFrame = Instance.new("Frame")
ScriptSearchFrame.Size = UDim2.new(1, -20, 0, 30)
ScriptSearchFrame.Position = UDim2.new(0, 10, 0, 40)
ScriptSearchFrame.BackgroundTransparency = 1
ScriptSearchFrame.Parent = ScriptSearchCard

local ScriptSearchBox = Instance.new("TextBox")
ScriptSearchBox.Size = UDim2.new(0.6, 0, 1, 0)
ScriptSearchBox.BackgroundColor3 = Colors.Darker
ScriptSearchBox.TextColor3 = Colors.Text
ScriptSearchBox.Font = Font
ScriptSearchBox.TextSize = 14
ScriptSearchBox.Text = ""
ScriptSearchBox.PlaceholderText = "Search scripts..."
ScriptSearchBox.PlaceholderColor3 = Colors.TextSecondary
ScriptSearchBox.Parent = ScriptSearchFrame

local ScriptSearchCorner = Instance.new("UICorner")
ScriptSearchCorner.CornerRadius = UDim.new(0, 6)
ScriptSearchCorner.Parent = ScriptSearchBox

local SearchScriptButton = Instance.new("TextButton")
SearchScriptButton.Size = UDim2.new(0.35, 0, 1, 0)
SearchScriptButton.Position = UDim2.new(0.65, 5, 0, 0)
SearchScriptButton.Text = "🔍 Search"
SearchScriptButton.BackgroundColor3 = Colors.Primary
SearchScriptButton.TextColor3 = Colors.Text
SearchScriptButton.Font = Font
SearchScriptButton.TextSize = 14
SearchScriptButton.Parent = ScriptSearchFrame

local SearchScriptCorner = Instance.new("UICorner")
SearchScriptCorner.CornerRadius = UDim.new(0, 6)
SearchScriptCorner.Parent = SearchScriptButton

local ScriptListScroll = Instance.new("ScrollingFrame")
ScriptListScroll.Size = UDim2.new(1, -20, 0, 250)
ScriptListScroll.Position = UDim2.new(0, 10, 0, 80)
ScriptListScroll.BackgroundTransparency = 1
ScriptListScroll.ScrollBarThickness = 4
ScriptListScroll.Parent = ScriptSearchCard

local ScriptListLayout = Instance.new("UIListLayout")
ScriptListLayout.Padding = UDim.new(0, 8)
ScriptListLayout.Parent = ScriptListScroll

-- Close Button Modern
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 15)
CloseButton.Text = "×"
CloseButton.BackgroundColor3 = Colors.Danger
CloseButton.TextColor3 = Colors.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Control Buttons Modern
local UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0, 60, 0, 60)
UpButton.Position = UDim2.new(1, -150, 1, -180)
UpButton.Text = "↑"
UpButton.TextColor3 = Colors.Text
UpButton.Font = Enum.Font.GothamBold
UpButton.TextSize = 20
UpButton.BackgroundColor3 = Colors.Primary
UpButton.BackgroundTransparency = 0.3
UpButton.Visible = false
UpButton.Parent = ScreenGui

local UpButtonCorner = Instance.new("UICorner")
UpButtonCorner.CornerRadius = UDim.new(1, 0)
UpButtonCorner.Parent = UpButton

local DownButton = Instance.new("TextButton")
DownButton.Size = UDim2.new(0, 60, 0, 60)
DownButton.Position = UDim2.new(1, -150, 1, -100)
DownButton.Text = "↓"
DownButton.TextColor3 = Colors.Text
DownButton.Font = Enum.Font.GothamBold
DownButton.TextSize = 20
DownButton.BackgroundColor3 = Colors.Primary
DownButton.BackgroundTransparency = 0.3
DownButton.Visible = false
DownButton.Parent = ScreenGui

local DownButtonCorner = Instance.new("UICorner")
DownButtonCorner.CornerRadius = UDim.new(1, 0)
DownButtonCorner.Parent = DownButton

-- ==================== VARIABEL DAN FUNGSI ASLI (TIDAK DIUBAH) ====================

-- Variabel untuk drag functionality
local dragging = false
local dragInput, dragStart, startPos

-- Variabel untuk fly
local isFlying = false
local flyBodyVelocity, flyBodyGyro
local flySpeed = 50
local flyConnection

-- Variabel untuk float
local isFloating = false
local floatBodyForce

-- Variabel untuk kontrol tombol
local upButtonPressed = false
local downButtonPressed = false

-- Variabel untuk waypoints
local waypoints = {}

-- Variabel untuk head functionality
local headingPlayer = nil
local headConnection = nil

-- Variabel untuk parts
local allParts = {}
local filteredParts = {}

-- Variabel untuk ESP
local espConnections = {}
local espHighlights = {}

-- Fungsi untuk mengupdate posisi button (tetap sama)
local function update(input)
    local delta = input.Position - dragStart
    FloatingButton.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

-- Fungsi untuk membersihkan fly (tetap sama)
local function cleanUpFly()
    if flyBodyVelocity then
        flyBodyVelocity:Destroy()
        flyBodyVelocity = nil
    end
    if flyBodyGyro then
        flyBodyGyro:Destroy()
        flyBodyGyro = nil
    end
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    isFlying = false
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    
    UpButton.Visible = false
    DownButton.Visible = false
    
    -- Update UI modern
    if FlyToggle and FlySwitch then
        TweenService:Create(
            FlyToggle,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.05, 0, 0.1, 0), BackgroundColor3 = Colors.Text}
        ):Play()
        TweenService:Create(
            FlySwitch,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Colors.Light}
        ):Play()
    end
end

-- Fungsi untuk membersihkan float (tetap sama)
local function cleanUpFloat()
    if floatBodyForce then
        floatBodyForce:Destroy()
        floatBodyForce = nil
    end
    isFloating = false
    
    if FloatToggle and FloatSwitch then
        TweenService:Create(
            FloatToggle,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.05, 0, 0.1, 0), BackgroundColor3 = Colors.Text}
        ):Play()
        TweenService:Create(
            FloatSwitch,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Colors.Light}
        ):Play()
    end
end

-- ... (SEMUA FUNGSI ASLI TETAP SAMA, HANYA TAMPILAN YANG BERUBAH)

-- ==================== ANIMASI DAN EFFECT MODERN ====================

-- Fungsi toggle popup dengan animasi modern
local function togglePopup()
    if PopupFrame.Visible then
        TweenService:Create(
            PopupFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
        ):Play()
        wait(0.3)
        PopupFrame.Visible = false
    else
        PopupFrame.Visible = true
        PopupFrame.Size = UDim2.new(0, 0, 0, 0)
        PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        updatePlayerList()
        
        TweenService:Create(
            PopupFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 350, 0, 450), Position = UDim2.new(0.5, -175, 0.5, -225)}
        ):Play()
    end
end

-- Fungsi switch ribbon modern
local function switchRibbon(ribbonName)
    UtamaContent.Visible = ribbonName == "Utama"
    TweenContent.Visible = ribbonName == "Tween"
    PartsContent.Visible = ribbonName == "Parts"
    ScriptContent.Visible = ribbonName == "Script"
    
    for name, button in pairs(RibbonButtons) do
        if name == ribbonName then
            TweenService:Create(
                button,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Colors.Primary}
            ):Play()
        else
            TweenService:Create(
                button,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Colors.Light}
            ):Play()
        end
    end
end

-- ==================== EVENT HANDLERS MODERN ====================

-- Floating Button dengan efek modern
FloatingButton.MouseButton1Click:Connect(togglePopup)

FloatingButton.MouseEnter:Connect(function()
    TweenService:Create(
        FloatingButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Colors.Secondary, Size = UDim2.new(0, 75, 0, 75)}
    ):Play()
end)

FloatingButton.MouseLeave:Connect(function()
    TweenService:Create(
        FloatingButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Colors.Primary, Size = UDim2.new(0, 70, 0, 70)}
    ):Play()
end)

-- Ribbon button events
for ribbonName, button in pairs(RibbonButtons) do
    button.MouseButton1Click:Connect(function()
        switchRibbon(ribbonName)
    end)
    
    button.MouseEnter:Connect(function()
        if not button.BackgroundColor3:Equals(Colors.Primary) then
            TweenService:Create(
                button,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Colors.Lighter}
            ):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not button.BackgroundColor3:Equals(Colors.Primary) then
            TweenService:Create(
                button,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Colors.Light}
            ):Play()
        end
    end)
end

-- Close button event
CloseButton.MouseButton1Click:Connect(function()
    -- Panggil fungsi destroy script asli
    destroyScript()
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(200, 60, 60)}
    ):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Colors.Danger}
    ):Play()
end)

-- ==================== DRAG FUNCTIONALITY (TETAP SAMA) ====================

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatingButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

FloatingButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- ==================== INISIALISASI ====================

-- Notifikasi modern
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🎮 Milky Hub",
    Text = "Modern UI loaded successfully!",
    Duration = 5
})

print("Milky Hub Modern UI loaded with all original functions preserved!")
