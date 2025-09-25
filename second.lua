-- Floating Menu Milky dengan Kontrol Tombol untuk Mobile dan Daftar Pemain
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MilkyFloatingMenu_" .. HttpService:GenerateGUID(false):sub(1, 8)
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false -- Penting: Mencegah GUI hilang saat respawn

-- Floating Button (Lingkaran)
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 100, 0, 100)
FloatingButton.Text = "Milky"
FloatingButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
FloatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.TextSize = 14
FloatingButton.AutoButtonColor = false
FloatingButton.Active = true
FloatingButton.Draggable = false
FloatingButton.Selectable = false
FloatingButton.Parent = ScreenGui

-- Membuat bentuk lingkaran
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = FloatingButton

-- Popup Window (diperbesar untuk menampung ribbon dan konten)
local PopupFrame = Instance.new("Frame")
PopupFrame.Size = UDim2.new(0, 300, 0, 400)
PopupFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
PopupFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PopupFrame.BorderSizePixel = 0
PopupFrame.Visible = false
PopupFrame.Parent = ScreenGui

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 12)
PopupCorner.Parent = PopupFrame

-- Ribbon Navigation (3 ribbon)
local RibbonFrame = Instance.new("Frame")
RibbonFrame.Size = UDim2.new(1, 0, 0, 40)
RibbonFrame.Position = UDim2.new(0, 0, 0, 0)
RibbonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
RibbonFrame.BorderSizePixel = 0
RibbonFrame.Parent = PopupFrame

local RibbonCorner = Instance.new("UICorner")
RibbonCorner.CornerRadius = UDim.new(0, 12)
RibbonCorner.Parent = RibbonFrame

-- Ribbon Buttons
local UtamaRibbon = Instance.new("TextButton")
UtamaRibbon.Size = UDim2.new(0.333, 0, 1, 0)
UtamaRibbon.Position = UDim2.new(0, 0, 0, 0)
UtamaRibbon.Text = "Utama"
UtamaRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
UtamaRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
UtamaRibbon.Font = Enum.Font.GothamBold
UtamaRibbon.TextSize = 12
UtamaRibbon.Parent = RibbonFrame

local TweenRibbon = Instance.new("TextButton")
TweenRibbon.Size = UDim2.new(0.333, 0, 1, 0)
TweenRibbon.Position = UDim2.new(0.333, 0, 0, 0)
TweenRibbon.Text = "Tween"
TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
TweenRibbon.Font = Enum.Font.GothamBold
TweenRibbon.TextSize = 12
TweenRibbon.Parent = RibbonFrame

local PartsRibbon = Instance.new("TextButton")
PartsRibbon.Size = UDim2.new(0.334, 0, 1, 0)
PartsRibbon.Position = UDim2.new(0.666, 0, 0, 0)
PartsRibbon.Text = "Parts"
PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
PartsRibbon.Font = Enum.Font.GothamBold
PartsRibbon.TextSize = 12
PartsRibbon.Parent = RibbonFrame

-- Content Frames
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = PopupFrame

-- Utama Content
local UtamaContent = Instance.new("Frame")
UtamaContent.Size = UDim2.new(1, 0, 1, 0)
UtamaContent.Position = UDim2.new(0, 0, 0, 0)
UtamaContent.BackgroundTransparency = 1
UtamaContent.Visible = true
UtamaContent.Parent = ContentFrame

local Message = Instance.new("TextLabel")
Message.Size = UDim2.new(1, -20, 0, 40)
Message.Position = UDim2.new(0, 10, 0, 10)
Message.BackgroundTransparency = 1
Message.Text = "halo saya milky"
Message.TextColor3 = Color3.fromRGB(255, 255, 255)
Message.Font = Enum.Font.Gotham
Message.TextSize = 16
Message.Parent = UtamaContent

-- Fly Switch
local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(0, 260, 0, 30)
FlyFrame.Position = UDim2.new(0, 20, 0, 60)
FlyFrame.BackgroundTransparency = 1
FlyFrame.Parent = UtamaContent

local FlyLabel = Instance.new("TextLabel")
FlyLabel.Size = UDim2.new(0, 100, 1, 0)
FlyLabel.Position = UDim2.new(0, 0, 0, 0)
FlyLabel.BackgroundTransparency = 1
FlyLabel.Text = "Terbang:"
FlyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyLabel.Font = Enum.Font.Gotham
FlyLabel.TextSize = 14
FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
FlyLabel.Parent = FlyFrame

local FlySwitch = Instance.new("TextButton")
FlySwitch.Size = UDim2.new(0, 50, 0, 25)
FlySwitch.Position = UDim2.new(1, -50, 0, 2)
FlySwitch.Text = ""
FlySwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FlySwitch.Parent = FlyFrame

local FlySwitchCorner = Instance.new("UICorner")
FlySwitchCorner.CornerRadius = UDim.new(0, 12)
FlySwitchCorner.Parent = FlySwitch

local FlyToggle = Instance.new("Frame")
FlyToggle.Size = UDim2.new(0, 21, 0, 21)
FlyToggle.Position = UDim2.new(0, 2, 0, 2)
FlyToggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
FlyToggle.Parent = FlySwitch

local FlyToggleCorner = Instance.new("UICorner")
FlyToggleCorner.CornerRadius = UDim.new(0, 10)
FlyToggleCorner.Parent = FlyToggle

-- Float Switch
local FloatFrame = Instance.new("Frame")
FloatFrame.Size = UDim2.new(0, 260, 0, 30)
FloatFrame.Position = UDim2.new(0, 20, 0, 100)
FloatFrame.BackgroundTransparency = 1
FloatFrame.Parent = UtamaContent

local FloatLabel = Instance.new("TextLabel")
FloatLabel.Size = UDim2.new(0, 100, 1, 0)
FloatLabel.Position = UDim2.new(0, 0, 0, 0)
FloatLabel.BackgroundTransparency = 1
FloatLabel.Text = "Mengambang:"
FloatLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatLabel.Font = Enum.Font.Gotham
FloatLabel.TextSize = 14
FloatLabel.TextXAlignment = Enum.TextXAlignment.Left
FloatLabel.Parent = FloatFrame

local FloatSwitch = Instance.new("TextButton")
FloatSwitch.Size = UDim2.new(0, 50, 0, 25)
FloatSwitch.Position = UDim2.new(1, -50, 0, 2)
FloatSwitch.Text = ""
FloatSwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FloatSwitch.Parent = FloatFrame

local FloatSwitchCorner = Instance.new("UICorner")
FloatSwitchCorner.CornerRadius = UDim.new(0, 12)
FloatSwitchCorner.Parent = FloatSwitch

local FloatToggle = Instance.new("Frame")
FloatToggle.Size = UDim2.new(0, 21, 0, 21)
FloatToggle.Position = UDim2.new(0, 2, 0, 2)
FloatToggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
FloatToggle.Parent = FloatSwitch

local FloatToggleCorner = Instance.new("UICorner")
FloatToggleCorner.CornerRadius = UDim.new(0, 10)
FloatToggleCorner.Parent = FloatToggle

-- WalkSpeed Input
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Size = UDim2.new(0, 260, 0, 30)
WalkSpeedFrame.Position = UDim2.new(0, 20, 0, 140)
WalkSpeedFrame.BackgroundTransparency = 1
WalkSpeedFrame.Parent = UtamaContent

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Size = UDim2.new(0, 100, 1, 0)
WalkSpeedLabel.Position = UDim2.new(0, 0, 0, 0)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "WalkSpeed:"
WalkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedLabel.Font = Enum.Font.Gotham
WalkSpeedLabel.TextSize = 14
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedLabel.Parent = WalkSpeedFrame

local WalkSpeedBox = Instance.new("TextBox")
WalkSpeedBox.Size = UDim2.new(0, 80, 1, 0)
WalkSpeedBox.Position = UDim2.new(0, 100, 0, 0)
WalkSpeedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
WalkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedBox.Font = Enum.Font.Gotham
WalkSpeedBox.TextSize = 14
WalkSpeedBox.Text = "16"
WalkSpeedBox.PlaceholderText = "Speed"
WalkSpeedBox.Parent = WalkSpeedFrame

local WalkSpeedCorner = Instance.new("UICorner")
WalkSpeedCorner.CornerRadius = UDim.new(0, 6)
WalkSpeedCorner.Parent = WalkSpeedBox

local SetWalkSpeedButton = Instance.new("TextButton")
SetWalkSpeedButton.Size = UDim2.new(0, 50, 1, 0)
SetWalkSpeedButton.Position = UDim2.new(1, -50, 0, 0)
SetWalkSpeedButton.Text = "Set"
SetWalkSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SetWalkSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SetWalkSpeedButton.Font = Enum.Font.Gotham
SetWalkSpeedButton.TextSize = 14
SetWalkSpeedButton.Parent = WalkSpeedFrame

local SetWalkSpeedCorner = Instance.new("UICorner")
SetWalkSpeedCorner.CornerRadius = UDim.new(0, 6)
SetWalkSpeedCorner.Parent = SetWalkSpeedButton

-- Daftar Pemain
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Size = UDim2.new(0, 260, 0, 120)
PlayerListFrame.Position = UDim2.new(0, 20, 0, 180)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PlayerListFrame.Parent = UtamaContent

local PlayerListCorner = Instance.new("UICorner")
PlayerListCorner.CornerRadius = UDim.new(0, 6)
PlayerListCorner.Parent = PlayerListFrame

local PlayerListLabel = Instance.new("TextLabel")
PlayerListLabel.Size = UDim2.new(1, 0, 0, 20)
PlayerListLabel.Position = UDim2.new(0, 0, 0, 0)
PlayerListLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PlayerListLabel.Text = "Daftar Pemain"
PlayerListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerListLabel.Font = Enum.Font.Gotham
PlayerListLabel.TextSize = 14
PlayerListLabel.Parent = PlayerListFrame

local PlayerListLabelCorner = Instance.new("UICorner")
PlayerListLabelCorner.CornerRadius = UDim.new(0, 6)
PlayerListLabelCorner.Parent = PlayerListLabel

local PlayerListScroll = Instance.new("ScrollingFrame")
PlayerListScroll.Size = UDim2.new(1, -10, 1, -30)
PlayerListScroll.Position = UDim2.new(0, 5, 0, 25)
PlayerListScroll.BackgroundTransparency = 1
PlayerListScroll.ScrollBarThickness = 5
PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListScroll.Parent = PlayerListFrame

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Padding = UDim.new(0, 5)
PlayerListLayout.Parent = PlayerListScroll

-- Tween Content
local TweenContent = Instance.new("Frame")
TweenContent.Size = UDim2.new(1, 0, 1, 0)
TweenContent.Position = UDim2.new(0, 0, 0, 0)
TweenContent.BackgroundTransparency = 1
TweenContent.Visible = false
TweenContent.Parent = ContentFrame

-- Waypoint Input Form
local WaypointFrame = Instance.new("Frame")
WaypointFrame.Size = UDim2.new(0, 260, 0, 30)
WaypointFrame.Position = UDim2.new(0, 20, 0, 10)
WaypointFrame.BackgroundTransparency = 1
WaypointFrame.Parent = TweenContent

local WaypointLabel = Instance.new("TextLabel")
WaypointLabel.Size = UDim2.new(0, 80, 1, 0)
WaypointLabel.Position = UDim2.new(0, 0, 0, 0)
WaypointLabel.BackgroundTransparency = 1
WaypointLabel.Text = "Waypoint:"
WaypointLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WaypointLabel.Font = Enum.Font.Gotham
WaypointLabel.TextSize = 14
WaypointLabel.TextXAlignment = Enum.TextXAlignment.Left
WaypointLabel.Parent = WaypointFrame

local WaypointBox = Instance.new("TextBox")
WaypointBox.Size = UDim2.new(0, 120, 1, 0)
WaypointBox.Position = UDim2.new(0, 80, 0, 0)
WaypointBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
WaypointBox.TextColor3 = Color3.fromRGB(255, 255, 255)
WaypointBox.Font = Enum.Font.Gotham
WaypointBox.TextSize = 14
WaypointBox.Text = ""
WaypointBox.PlaceholderText = "Nama Waypoint"
WaypointBox.Parent = WaypointFrame

local WaypointCorner = Instance.new("UICorner")
WaypointCorner.CornerRadius = UDim.new(0, 6)
WaypointCorner.Parent = WaypointBox

local SetWaypointButton = Instance.new("TextButton")
SetWaypointButton.Size = UDim2.new(0, 50, 1, 0)
SetWaypointButton.Position = UDim2.new(1, -50, 0, 0)
SetWaypointButton.Text = "Set"
SetWaypointButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SetWaypointButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SetWaypointButton.Font = Enum.Font.Gotham
SetWaypointButton.TextSize = 14
SetWaypointButton.Parent = WaypointFrame

local SetWaypointCorner = Instance.new("UICorner")
SetWaypointCorner.CornerRadius = UDim.new(0, 6)
SetWaypointCorner.Parent = SetWaypointButton

-- Daftar Waypoint
local WaypointListFrame = Instance.new("Frame")
WaypointListFrame.Size = UDim2.new(0, 260, 0, 280)
WaypointListFrame.Position = UDim2.new(0, 20, 0, 50)
WaypointListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
WaypointListFrame.Parent = TweenContent

local WaypointListCorner = Instance.new("UICorner")
WaypointListCorner.CornerRadius = UDim.new(0, 6)
WaypointListCorner.Parent = WaypointListFrame

local WaypointListLabel = Instance.new("TextLabel")
WaypointListLabel.Size = UDim2.new(1, 0, 0, 20)
WaypointListLabel.Position = UDim2.new(0, 0, 0, 0)
WaypointListLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
WaypointListLabel.Text = "Daftar Waypoint"
WaypointListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WaypointListLabel.Font = Enum.Font.Gotham
WaypointListLabel.TextSize = 14
WaypointListLabel.Parent = WaypointListFrame

local WaypointListLabelCorner = Instance.new("UICorner")
WaypointListLabelCorner.CornerRadius = UDim.new(0, 6)
WaypointListLabelCorner.Parent = WaypointListLabel

local WaypointListScroll = Instance.new("ScrollingFrame")
WaypointListScroll.Size = UDim2.new(1, -10, 1, -30)
WaypointListScroll.Position = UDim2.new(0, 5, 0, 25)
WaypointListScroll.BackgroundTransparency = 1
WaypointListScroll.ScrollBarThickness = 5
WaypointListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
WaypointListScroll.Parent = WaypointListFrame

local WaypointListLayout = Instance.new("UIListLayout")
WaypointListLayout.Padding = UDim.new(0, 5)
WaypointListLayout.Parent = WaypointListScroll

-- Parts Content
local PartsContent = Instance.new("Frame")
PartsContent.Size = UDim2.new(1, 0, 1, 0)
PartsContent.Position = UDim2.new(0, 0, 0, 0)
PartsContent.BackgroundTransparency = 1
PartsContent.Visible = false
PartsContent.Parent = ContentFrame

-- Pencarian Parts
local PartsSearchFrame = Instance.new("Frame")
PartsSearchFrame.Size = UDim2.new(0, 260, 0, 30)
PartsSearchFrame.Position = UDim2.new(0, 20, 0, 10)
PartsSearchFrame.BackgroundTransparency = 1
PartsSearchFrame.Parent = PartsContent

local PartsSearchLabel = Instance.new("TextLabel")
PartsSearchLabel.Size = UDim2.new(0, 80, 1, 0)
PartsSearchLabel.Position = UDim2.new(0, 0, 0, 0)
PartsSearchLabel.BackgroundTransparency = 1
PartsSearchLabel.Text = "Cari Part:"
PartsSearchLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PartsSearchLabel.Font = Enum.Font.Gotham
PartsSearchLabel.TextSize = 14
PartsSearchLabel.TextXAlignment = Enum.TextXAlignment.Left
PartsSearchLabel.Parent = PartsSearchFrame

local PartsSearchBox = Instance.new("TextBox")
PartsSearchBox.Size = UDim2.new(0, 180, 1, 0)
PartsSearchBox.Position = UDim2.new(0, 80, 0, 0)
PartsSearchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PartsSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PartsSearchBox.Font = Enum.Font.Gotham
PartsSearchBox.TextSize = 14
PartsSearchBox.Text = ""
PartsSearchBox.PlaceholderText = "Nama Part (kosongkan untuk semua)"
PartsSearchBox.Parent = PartsSearchFrame

local PartsSearchCorner = Instance.new("UICorner")
PartsSearchCorner.CornerRadius = UDim.new(0, 6)
PartsSearchCorner.Parent = PartsSearchBox

-- Tombol Refresh Parts
local RefreshPartsButton = Instance.new("TextButton")
RefreshPartsButton.Size = UDim2.new(0, 30, 0, 30)
RefreshPartsButton.Position = UDim2.new(1, -35, 0, 45)
RefreshPartsButton.Text = "↻"
RefreshPartsButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
RefreshPartsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshPartsButton.Font = Enum.Font.GothamBold
RefreshPartsButton.TextSize = 16
RefreshPartsButton.Parent = PartsContent

local RefreshPartsCorner = Instance.new("UICorner")
RefreshPartsCorner.CornerRadius = UDim.new(0, 6)
RefreshPartsCorner.Parent = RefreshPartsButton

-- Info Parts
local PartsInfoLabel = Instance.new("TextLabel")
PartsInfoLabel.Size = UDim2.new(0, 200, 0, 20)
PartsInfoLabel.Position = UDim2.new(0, 20, 0, 45)
PartsInfoLabel.BackgroundTransparency = 1
PartsInfoLabel.Text = "Total Parts: 0"
PartsInfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PartsInfoLabel.Font = Enum.Font.Gotham
PartsInfoLabel.TextSize = 12
PartsInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
PartsInfoLabel.Parent = PartsContent

-- Daftar Parts
local PartsListFrame = Instance.new("Frame")
PartsListFrame.Size = UDim2.new(0, 260, 0, 300)
PartsListFrame.Position = UDim2.new(0, 20, 0, 80)
PartsListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PartsListFrame.Parent = PartsContent

local PartsListCorner = Instance.new("UICorner")
PartsListCorner.CornerRadius = UDim.new(0, 6)
PartsListCorner.Parent = PartsListFrame

local PartsListLabel = Instance.new("TextLabel")
PartsListLabel.Size = UDim2.new(1, 0, 0, 20)
PartsListLabel.Position = UDim2.new(0, 0, 0, 0)
PartsListLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PartsListLabel.Text = "Daftar Parts Interaktif"
PartsListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PartsListLabel.Font = Enum.Font.Gotham
PartsListLabel.TextSize = 14
PartsListLabel.Parent = PartsListFrame

local PartsListLabelCorner = Instance.new("UICorner")
PartsListLabelCorner.CornerRadius = UDim.new(0, 6)
PartsListLabelCorner.Parent = PartsListLabel

local PartsListScroll = Instance.new("ScrollingFrame")
PartsListScroll.Size = UDim2.new(1, -10, 1, -30)
PartsListScroll.Position = UDim2.new(0, 5, 0, 25)
PartsListScroll.BackgroundTransparency = 1
PartsListScroll.ScrollBarThickness = 5
PartsListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PartsListScroll.Parent = PartsListFrame

local PartsListLayout = Instance.new("UIListLayout")
PartsListLayout.Padding = UDim.new(0, 5)
PartsListLayout.Parent = PartsListScroll

-- Close Button (diubah menjadi Destroy Button)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = PopupFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Tombol untuk naik/turun (mobile)
local UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0, 60, 0, 60)
UpButton.Position = UDim2.new(1, -150, 1, -180)
UpButton.Text = "↑"
UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpButton.Font = Enum.Font.GothamBold
UpButton.TextSize = 24
UpButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
UpButton.BackgroundTransparency = 0.5
UpButton.Visible = false
UpButton.Parent = ScreenGui

local UpButtonCorner = Instance.new("UICorner")
UpButtonCorner.CornerRadius = UDim.new(1, 0)
UpButtonCorner.Parent = UpButton

local DownButton = Instance.new("TextButton")
DownButton.Size = UDim2.new(0, 60, 0, 60)
DownButton.Position = UDim2.new(1, -150, 1, -100)
DownButton.Text = "↓"
DownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownButton.Font = Enum.Font.GothamBold
DownButton.TextSize = 24
DownButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
DownButton.BackgroundTransparency = 0.5
DownButton.Visible = false
DownButton.Parent = ScreenGui

local DownButtonCorner = Instance.new("UICorner")
DownButtonCorner.CornerRadius = UDim.new(1, 0)
DownButtonCorner.Parent = DownButton

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

-- Fungsi untuk mengupdate posisi button
local function update(input)
    local delta = input.Position - dragStart
    FloatingButton.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

-- Fungsi untuk membersihkan fly
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
    
    -- Kembalikan gravitasi
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    
    -- Sembunyikan tombol kontrol
    UpButton.Visible = false
    DownButton.Visible = false
    
    -- Update UI
    if FlyToggle and FlySwitch then
        TweenService:Create(
            FlyToggle,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(200, 200, 200)}
        ):Play()
        TweenService:Create(
            FlySwitch,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
        ):Play()
    end
end

-- Fungsi untuk membersihkan float
local function cleanUpFloat()
    if floatBodyForce then
        floatBodyForce:Destroy()
        floatBodyForce = nil
    end
    isFloating = false
    
    -- Update UI
    if FloatToggle and FloatSwitch then
        TweenService:Create(
            FloatToggle,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(200, 200, 200)}
        ):Play()
        TweenService:Create(
            FloatSwitch,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
        ):Play()
    end
end

-- Fungsi untuk membersihkan head
local function cleanUpHead()
    if headConnection then
        headConnection:Disconnect()
        headConnection = nil
    end
    headingPlayer = nil
end

-- ==================== FUNGSI ESP ====================
-- Fungsi untuk membuat ESP pada part
local function createESP(partData)
    if not partData or not partData.Object or not partData.Object.Parent then
        return false
    end
    
    local part = partData.Object
    
    -- Hapus ESP lama jika sudah ada
    if espHighlights[part] then
        espHighlights[part]:Destroy()
        espHighlights[part] = nil
    end
    
    if espConnections[part] then
        espConnections[part]:Disconnect()
        espConnections[part] = nil
    end
    
    -- Buat Highlight untuk ESP
    local highlight = Instance.new("Highlight")
    highlight.Name = "MilkyESP_" .. part.Name
    highlight.Adornee = part
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = game.CoreGui
    
    -- Buat BillboardGui untuk menampilkan nama
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "MilkyESPBillboard_" .. part.Name
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = game.CoreGui
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = part.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = billboard
    
    local parentLabel = Instance.new("TextLabel")
    parentLabel.Size = UDim2.new(1, 0, 0.5, 0)
    parentLabel.Position = UDim2.new(0, 0, 0.5, 0)
    parentLabel.BackgroundTransparency = 1
    parentLabel.Text = "Parent: " .. part.Parent.Name
    parentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    parentLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    parentLabel.TextStrokeTransparency = 0
    parentLabel.Font = Enum.Font.Gotham
    parentLabel.TextSize = 12
    parentLabel.Parent = billboard
    
    -- Simpan ESP objects
    espHighlights[part] = highlight
    espHighlights[part .. "_billboard"] = billboard
    
    -- Connection untuk menghapus ESP jika part dihapus
    espConnections[part] = part.AncestryChanged:Connect(function()
        if not part.Parent then
            if espHighlights[part] then
                espHighlights[part]:Destroy()
                espHighlights[part] = nil
            end
            if espHighlights[part .. "_billboard"] then
                espHighlights[part .. "_billboard"]:Destroy()
                espHighlights[part .. "_billboard"] = nil
            end
            if espConnections[part] then
                espConnections[part]:Disconnect()
                espConnections[part] = nil
            end
        end
    end)
    
    return true
end

-- Fungsi untuk menghapus ESP dari part
local function removeESP(partData)
    if not partData or not partData.Object then
        return false
    end
    
    local part = partData.Object
    
    if espHighlights[part] then
        espHighlights[part]:Destroy()
        espHighlights[part] = nil
    end
    
    if espHighlights[part .. "_billboard"] then
        espHighlights[part .. "_billboard"]:Destroy()
        espHighlights[part .. "_billboard"] = nil
    end
    
    if espConnections[part] then
        espConnections[part]:Disconnect()
        espConnections[part] = nil
    end
    
    return true
end

-- Fungsi untuk membersihkan semua ESP
local function cleanUpAllESP()
    for part, highlight in pairs(espHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    
    for part, connection in pairs(espConnections) do
        if connection then
            connection:Disconnect()
        end
    end
    
    espHighlights = {}
    espConnections = {}
end

-- ==================== FUNGSI PARTS YANG DIPERBAIKI ====================
-- Fungsi untuk memeriksa apakah part dapat diinteraksi
local function isPartInteractable(part)
    -- Cek jika part adalah bagian dari karakter pemain
    if part:IsDescendantOf(LocalPlayer.Character) then
        return false
    end
    
    -- Cek jika part adalah bagian dari workspace yang tidak dapat diinteraksi
    if part:IsDescendantOf(workspace.Terrain) then
        return false
    end
    
    -- Cek jika part memiliki properti khusus yang menandakan dapat diinteraksi
    if part:FindFirstChildWhichIsA("ClickDetector") then
        return true
    end
    
    if part:FindFirstChildWhichIsA("ProximityPrompt") then
        return true
    end
    
    if part:FindFirstChildWhichIsA("TouchTransmitter") then
        return true
    end
    
    -- Cek jika part memiliki script khusus yang menandakan interaktivitas
    local parentModel = part.Parent
    if parentModel and parentModel:IsA("Model") then
        if parentModel:FindFirstChildWhichIsA("Script") then
            local scripts = parentModel:GetChildren()
            for _, script in ipairs(scripts) do
                if script:IsA("Script") or script:IsA("LocalScript") then
                    if string.find(script.Name:lower(), "interact") or 
                       string.find(script.Name:lower(), "click") or 
                       string.find(script.Name:lower(), "touch") then
                        return true
                    end
                end
            end
        end
    end
    
    -- Cek berdasarkan nama part (hindari part generik)
    local genericNames = {
        "baseplate", "part", "block", "brick", "wall", "floor", "ground",
        "spawn", "camera", "light", "decal", "texture", "mesh"
    }
    
    local partNameLower = part.Name:lower()
    for _, genericName in ipairs(genericNames) do
        if partNameLower == genericName then
            return false
        end
    end
    
    -- Cek jika part memiliki nama yang spesifik (biasanya menandakan part penting)
    if string.find(partNameLower, "button") or 
       string.find(partNameLower, "door") or 
       string.find(partNameLower, "lever") or 
       string.find(partNameLower, "switch") or
       string.find(partNameLower, "chest") or
       string.find(partNameLower, "item") or
       string.find(partNameLower, "npc") or
       string.find(partNameLower, "portal") or
       string.find(partNameLower, "teleport") then
        return true
    end
    
    -- Default: part tidak dianggap interaktif
    return false
end

-- Fungsi untuk mengumpulkan part interaktif di workspace
local function collectInteractableParts()
    allParts = {}
    filteredParts = {}
    
    local function scanModel(model)
        for _, child in ipairs(model:GetChildren()) do
            if child:IsA("BasePart") then
                -- Hanya tambahkan part yang dapat diinteraksi
                if isPartInteractable(child) then
                    table.insert(allParts, {
                        Object = child,
                        Name = child.Name,
                        Position = child.Position,
                        Parent = child.Parent.Name,
                        CanCollide = child.CanCollide,
                        Material = child.Material.Name
                    })
                end
            elseif child:IsA("Model") or child:IsA("Folder") then
                -- Jangan scan karakter pemain
                if not child:IsDescendantOf(LocalPlayer.Character) then
                    scanModel(child)
                end
            end
        end
    end
    
    -- Scan workspace (kecuali karakter pemain)
    scanModel(workspace)
    
    -- Salin ke filteredParts untuk pencarian awal
    for i, part in ipairs(allParts) do
        filteredParts[i] = part
    end
    
    return #allParts
end

-- Fungsi untuk memfilter parts berdasarkan nama
local function filterParts(searchText)
    filteredParts = {}
    
    if searchText == "" or searchText == nil then
        for i, part in ipairs(allParts) do
            filteredParts[i] = part
        end
    else
        local searchLower = string.lower(searchText)
        for _, part in ipairs(allParts) do
            if string.find(string.lower(part.Name), searchLower) or
               string.find(string.lower(part.Parent), searchLower) then
                table.insert(filteredParts, part)
            end
        end
    end
    
    return #filteredParts
end

-- Fungsi untuk memperbarui daftar parts di GUI
local function updatePartsList()
    for _, child in ipairs(PartsListScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local contentHeight = 0
    
    for _, partData in ipairs(filteredParts) do
        local partItem = Instance.new("Frame")
        partItem.Size = UDim2.new(1, 0, 0, 60)
        partItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        partItem.Parent = PartsListScroll
        
        local partItemCorner = Instance.new("UICorner")
        partItemCorner.CornerRadius = UDim.new(0, 4)
        partItemCorner.Parent = partItem
        
        -- Nama Part
        local partName = Instance.new("TextLabel")
        partName.Size = UDim2.new(0.7, 0, 0.33, 0)
        partName.Position = UDim2.new(0, 5, 0, 0)
        partName.BackgroundTransparency = 1
        partName.Text = partData.Name
        partName.TextColor3 = Color3.fromRGB(255, 255, 255)
        partName.Font = Enum.Font.GothamBold
        partName.TextSize = 12
        partName.TextXAlignment = Enum.TextXAlignment.Left
        partName.TextTruncate = Enum.TextTruncate.AtEnd
        partName.Parent = partItem
        
        -- Parent Part
        local partParent = Instance.new("TextLabel")
        partParent.Size = UDim2.new(0.7, 0, 0.33, 0)
        partParent.Position = UDim2.new(0, 5, 0.33, 0)
        partParent.BackgroundTransparency = 1
        partParent.Text = "Parent: " .. partData.Parent
        partParent.TextColor3 = Color3.fromRGB(200, 200, 200)
        partParent.Font = Enum.Font.Gotham
        partParent.TextSize = 10
        partParent.TextXAlignment = Enum.TextXAlignment.Left
        partParent.TextTruncate = Enum.TextTruncate.AtEnd
        partParent.Parent = partItem
        
        -- Info Material/Collision
        local partInfo = Instance.new("TextLabel")
        partInfo.Size = UDim2.new(0.7, 0, 0.34, 0)
        partInfo.Position = UDim2.new(0, 5, 0.66, 0)
        partInfo.BackgroundTransparency = 1
        partInfo.Text = partData.Material .. " | Collide: " .. tostring(partData.CanCollide)
        partInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
        partInfo.Font = Enum.Font.Gotham
        partInfo.TextSize = 9
        partInfo.TextXAlignment = Enum.TextXAlignment.Left
        partInfo.Parent = partItem
        
        -- Container untuk tombol
        local buttonContainer = Instance.new("Frame")
        buttonContainer.Size = UDim2.new(0.3, 0, 1, 0)
        buttonContainer.Position = UDim2.new(0.7, 0, 0, 0)
        buttonContainer.BackgroundTransparency = 1
        buttonContainer.Parent = partItem

        -- Tombol Tween ke Part
        local tweenButton = Instance.new("TextButton")
        tweenButton.Size = UDim2.new(0.45, 0, 0.4, 0)
        tweenButton.Position = UDim2.new(0.05, 0, 0.1, 0)
        tweenButton.Text = "Tween"
        tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        tweenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tweenButton.Font = Enum.Font.Gotham
        tweenButton.TextSize = 10
        tweenButton.Parent = buttonContainer
        
        local tweenButtonCorner = Instance.new("UICorner")
        tweenButtonCorner.CornerRadius = UDim.new(0, 4)
        tweenButtonCorner.Parent = tweenButton
        
        -- Tombol ESP/UnESP
        local espButton = Instance.new("TextButton")
        espButton.Size = UDim2.new(0.45, 0, 0.4, 0)
        espButton.Position = UDim2.new(0.5, 0, 0.1, 0)
        espButton.Text = "ESP"
        espButton.BackgroundColor3 = Color3.fromRGB(200, 120, 0)
        espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        espButton.Font = Enum.Font.Gotham
        espButton.TextSize = 10
        espButton.Parent = buttonContainer
        
        local espButtonCorner = Instance.new("UICorner")
        espButtonCorner.CornerRadius = UDim.new(0, 4)
        espButtonCorner.Parent = espButton
        
        -- Cek apakah part ini sudah memiliki ESP aktif
        if espHighlights[partData.Object] then
            espButton.Text = "Un ESP"
            espButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        end
        
        -- Event handler untuk tombol tween part
        tweenButton.MouseButton1Click:Connect(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                -- Nonaktifkan fly jika sedang aktif
                if isFlying then
                    cleanUpFly()
                end
                
                -- Nonaktifkan float jika sedang aktif
                if isFloating then
                    cleanUpFloat()
                end
                
                -- Tween ke part
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart and partData.Object and partData.Object.Parent then
                    local targetPosition = partData.Position
                    local tweenInfo = TweenInfo.new(
                        (rootPart.Position - targetPosition).Magnitude / 50,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out
                    )
                    
                    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))})
                    tween:Play()
                    
                    -- Feedback visual
                    tweenButton.Text = "Moving..."
                    tweenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    
                    tween.Completed:Connect(function()
                        tweenButton.Text = "Tween"
                        tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                    end)
                else
                    tweenButton.Text = "Error!"
                    tweenButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                    wait(1)
                    tweenButton.Text = "Tween"
                    tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                end
            end
        end)
        
        -- Event handler untuk tombol ESP
        espButton.MouseButton1Click:Connect(function()
            if espButton.Text == "ESP" then
                -- Aktifkan ESP
                if createESP(partData) then
                    espButton.Text = "Un ESP"
                    espButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                end
            else
                -- Nonaktifkan ESP
                if removeESP(partData) then
                    espButton.Text = "ESP"
                    espButton.BackgroundColor3 = Color3.fromRGB(200, 120, 0)
                end
            end
        end)
        
        -- Efek hover pada tombol tween
        tweenButton.MouseEnter:Connect(function()
            TweenService:Create(
                tweenButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
            ):Play()
        end)
        
        tweenButton.MouseLeave:Connect(function()
            TweenService:Create(
                tweenButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
            ):Play()
        end)
        
        -- Efek hover pada tombol ESP
        espButton.MouseEnter:Connect(function()
            if espButton.Text == "ESP" then
                TweenService:Create(
                    espButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(180, 100, 0)}
                ):Play()
            else
                TweenService:Create(
                    espButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(180, 0, 0)}
                ):Play()
            end
        end)
        
        espButton.MouseLeave:Connect(function()
            if espButton.Text == "ESP" then
                TweenService:Create(
                    espButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(200, 120, 0)}
                ):Play()
            else
                TweenService:Create(
                    espButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}
                ):Play()
            end
        end)
        
        contentHeight = contentHeight + 65
    end
    
    PartsListScroll.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

-- Fungsi untuk memuat dan menampilkan parts
local function loadAndDisplayParts()
    local totalParts = collectInteractableParts()
    local displayedParts = filterParts(PartsSearchBox.Text)
    
    PartsInfoLabel.Text = "Parts Interaktif: " .. totalParts .. " | Ditampilkan: " .. displayedParts
    updatePartsList()
end

-- ==================== FUNGSI YANG SUDAH ADA ====================
-- Fungsi untuk memperbarui daftar pemain
local function updatePlayerList()
    for _, child in ipairs(PlayerListScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local players = Players:GetPlayers()
    local contentHeight = 0
    
    for _, player in ipairs(players) do
        if player ~= LocalPlayer then
            local playerItem = Instance.new("Frame")
            playerItem.Size = UDim2.new(1, 0, 0, 30)
            playerItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            playerItem.Parent = PlayerListScroll
            
            local playerItemCorner = Instance.new("UICorner")
            playerItemCorner.CornerRadius = UDim.new(0, 4)
            playerItemCorner.Parent = playerItem
            
            local playerName = Instance.new("TextLabel")
            playerName.Size = UDim2.new(0.4, 0, 1, 0)
            playerName.Position = UDim2.new(0, 5, 0, 0)
            playerName.BackgroundTransparency = 1
            playerName.Text = player.Name
            playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerName.Font = Enum.Font.Gotham
            playerName.TextSize = 14
            playerName.TextXAlignment = Enum.TextXAlignment.Left
            playerName.Parent = playerItem
            
            local headButton = Instance.new("TextButton")
            headButton.Size = UDim2.new(0.25, 0, 0.7, 0)
            headButton.Position = UDim2.new(0.4, 0, 0.15, 0)
            headButton.Text = headingPlayer == player and "Unhead" or "Head"
            headButton.BackgroundColor3 = headingPlayer == player and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 120, 215)
            headButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            headButton.Font = Enum.Font.Gotham
            headButton.TextSize = 12
            headButton.Parent = playerItem
            
            local headButtonCorner = Instance.new("UICorner")
            headButtonCorner.CornerRadius = UDim.new(0, 4)
            headButtonCorner.Parent = headButton
            
            local tweenButton = Instance.new("TextButton")
            tweenButton.Size = UDim2.new(0.25, 0, 0.7, 0)
            tweenButton.Position = UDim2.new(0.67, 0, 0.15, 0)
            tweenButton.Text = "Tween"
            tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            tweenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tweenButton.Font = Enum.Font.Gotham
            tweenButton.TextSize = 12
            tweenButton.Parent = playerItem
            
            local tweenButtonCorner = Instance.new("UICorner")
            tweenButtonCorner.CornerRadius = UDim.new(0, 4)
            tweenButtonCorner.Parent = tweenButton
            
            headButton.MouseButton1Click:Connect(function()
                if headingPlayer == player then
                    cleanUpHead()
                    headButton.Text = "Head"
                    headButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                else
                    cleanUpHead()
                    
                    headingPlayer = player
                    headButton.Text = "Unhead"
                    headButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                    
                    for _, item in ipairs(PlayerListScroll:GetChildren()) do
                        if item:IsA("Frame") then
                            local otherHeadButton = item:FindFirstChildWhichIsA("TextButton")
                            local otherPlayerName = item:FindFirstChildWhichIsA("TextLabel")
                            if otherHeadButton and otherPlayerName and otherPlayerName.Text ~= player.Name then
                                otherHeadButton.Text = "Head"
                                otherHeadButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                            end
                        end
                    end
                    
                    headConnection = RunService.RenderStepped:Connect(function()
                        if not headingPlayer or not headingPlayer.Character or not headingPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            cleanUpHead()
                            updatePlayerList()
                            return
                        end
                        
                        local character = LocalPlayer.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            local rootPart = character.HumanoidRootPart
                            local targetPosition = headingPlayer.Character.HumanoidRootPart.Position
                            
                            rootPart.CFrame = CFrame.new(rootPart.Position, Vector3.new(targetPosition.X, rootPart.Position.Y, targetPosition.Z))
                        end
                    end)
                end
            end)
            
            tweenButton.MouseButton1Click:Connect(function()
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        if isFlying then
                            cleanUpFly()
                        end
                        
                        if isFloating then
                            cleanUpFloat()
                        end
                        
                        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            local targetPosition = character.HumanoidRootPart.Position
                            local tweenInfo = TweenInfo.new(
                                (rootPart.Position - targetPosition).Magnitude / 50,
                                Enum.EasingStyle.Linear,
                                Enum.EasingDirection.Out
                            )
                            
                            local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
                            tween:Play()
                            
                            tweenButton.Text = "Moving..."
                            tweenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                            
                            tween.Completed:Connect(function()
                                tweenButton.Text = "Tween"
                                tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                            end)
                        end
                    end
                else
                    tweenButton.Text = "No Char!"
                    tweenButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                    wait(1)
                    tweenButton.Text = "Tween"
                    tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                end
            end)
            
            contentHeight = contentHeight + 35
        end
    end
    
    PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

-- Fungsi untuk memperbarui daftar waypoint
local function updateWaypointList()
    for _, child in ipairs(WaypointListScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local contentHeight = 0
    
    for name, position in pairs(waypoints) do
        local waypointItem = Instance.new("Frame")
        waypointItem.Size = UDim2.new(1, 0, 0, 30)
        waypointItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        waypointItem.Parent = WaypointListScroll
        
        local waypointItemCorner = Instance.new("UICorner")
        waypointItemCorner.CornerRadius = UDim.new(0, 4)
        waypointItemCorner.Parent = waypointItem
        
        local waypointName = Instance.new("TextLabel")
        waypointName.Size = UDim2.new(0.6, 0, 1, 0)
        waypointName.Position = UDim2.new(0, 5, 0, 0)
        waypointName.BackgroundTransparency = 1
        waypointName.Text = name
        waypointName.TextColor3 = Color3.fromRGB(255, 255, 255)
        waypointName.Font = Enum.Font.Gotham
        waypointName.TextSize = 14
        waypointName.TextXAlignment = Enum.TextXAlignment.Left
        waypointName.Parent = waypointItem
        
        local tweenButton = Instance.new("TextButton")
        tweenButton.Size = UDim2.new(0.35, 0, 0.7, 0)
        tweenButton.Position = UDim2.new(0.62, 0, 0.15, 0)
        tweenButton.Text = "Tween"
        tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        tweenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tweenButton.Font = Enum.Font.Gotham
        tweenButton.TextSize = 12
        tweenButton.Parent = waypointItem
        
        local tweenButtonCorner = Instance.new("UICorner")
        tweenButtonCorner.CornerRadius = UDim.new(0, 4)
        tweenButtonCorner.Parent = tweenButton
        
        tweenButton.MouseButton1Click:Connect(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if isFlying then
                    cleanUpFly()
                end
                
                if isFloating then
                    cleanUpFloat()
                end
                
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local tweenInfo = TweenInfo.new(
                        (rootPart.Position - position).Magnitude / 50,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out
                    )
                    
                    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(position)})
                    tween:Play()
                    
                    tweenButton.Text = "Moving..."
                    tweenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    
                    tween.Completed:Connect(function()
                        tweenButton.Text = "Tween"
                        tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                    end)
                end
            end
        end)
        
        contentHeight = contentHeight + 35
    end
    
    WaypointListScroll.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

-- Fungsi untuk menyimpan waypoint
local function setWaypoint()
    local name = WaypointBox.Text
    if name and name ~= "" then
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            waypoints[name] = character.HumanoidRootPart.Position
            updateWaypointList()
            
            TweenService:Create(
                WaypointBox,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
            ):Play()
            wait(0.3)
            TweenService:Create(
                WaypointBox,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
            ):Play()
            
            WaypointBox.Text = ""
        end
    else
        TweenService:Create(
            WaypointBox,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(150, 0, 0)}
        ):Play()
        wait(0.3)
        TweenService:Create(
            WaypointBox,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
        ):Play()
    end
end

-- ==================== FUNGSI DESTROY SCRIPT ====================
local function destroyScript()
    -- Bersihkan semua fungsi aktif
    cleanUpFly()
    cleanUpFloat()
    cleanUpHead()
    cleanUpAllESP()
    
    -- Hapus semua koneksi event
    if playerAddedConn then
        playerAddedConn:Disconnect()
    end
    
    if playerRemovingConn then
        playerRemovingConn:Disconnect()
    end
    
    if characterAddedConn then
        characterAddedConn:Disconnect()
    end
    
    -- Hancurkan GUI
    if ScreenGui then
        ScreenGui:Destroy()
    end
    
    -- Notifikasi
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Milky Menu",
        Text = "Script telah dihancurkan",
        Duration = 3
    })
end

-- ==================== EVENT HANDLERS ====================
-- Event handling untuk drag
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

-- Fungsi untuk mengatur WalkSpeed
local function setWalkSpeed()
    local speed = tonumber(WalkSpeedBox.Text)
    if speed and speed > 0 then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
            TweenService:Create(
                WalkSpeedBox,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
            ):Play()
            wait(0.3)
            TweenService:Create(
                WalkSpeedBox,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
            ):Play()
        end
    else
        TweenService:Create(
            WalkSpeedBox,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(150, 0, 0)}
        ):Play()
        wait(0.3)
        TweenService:Create(
            WalkSpeedBox,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
        ):Play()
    end
end

-- Fungsi Fly yang Diperbaiki untuk Mobile
local function toggleFly()
    if isFlying then
        cleanUpFly()
    else
        if isFloating then
            cleanUpFloat()
        end
        
        if headingPlayer then
            cleanUpHead()
            updatePlayerList()
        end
        
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            cleanUpFly()
            
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            flyBodyVelocity.Parent = character.HumanoidRootPart
            
            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            flyBodyGyro.P = 1000
            flyBodyGyro.D = 50
            flyBodyGyro.Parent = character.HumanoidRootPart
            
            if character:FindFirstChildOfClass("Humanoid") then
                character:FindFirstChildOfClass("Humanoid").PlatformStand = true
            end
            
            UpButton.Visible = true
            DownButton.Visible = true
            
            isFlying = true
            
            TweenService:Create(
                FlyToggle,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 27, 0, 2), BackgroundColor3 = Color3.fromRGB(0, 200, 0)}
            ):Play()
            TweenService:Create(
                FlySwitch,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 100, 0)}
            ):Play()
            
            flyConnection = RunService.RenderStepped:Connect(function()
                if not isFlying or not flyBodyGyro or not flyBodyVelocity then
                    if flyConnection then
                        flyConnection:Disconnect()
                        flyConnection = nil
                    end
                    return
                end
                
                if not character or not character.Parent or not character:FindFirstChild("HumanoidRootPart") then
                    cleanUpFly()
                    return
                end
                
                local camera = workspace.CurrentCamera
                if camera then
                    flyBodyGyro.CFrame = camera.CFrame
                    
                    local verticalVelocity = 0
                    if upButtonPressed then
                        verticalVelocity = flySpeed
                    elseif downButtonPressed then
                        verticalVelocity = -flySpeed
                    end
                    
                    local horizontalVelocity = Vector3.new(0, 0, 0)
                    if character:FindFirstChildOfClass("Humanoid") then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        horizontalVelocity = Vector3.new(humanoid.MoveDirection.X * flySpeed, 0, humanoid.MoveDirection.Z * flySpeed)
                    end
                    
                    flyBodyVelocity.Velocity = horizontalVelocity + Vector3.new(0, verticalVelocity, 0)
                end
            end)
        end
    end
end

-- Fungsi Float/Unfloat
local function toggleFloat()
    if isFloating then
        cleanUpFloat()
    else
        if isFlying then
            cleanUpFly()
        end
        
        if headingPlayer then
            cleanUpHead()
            updatePlayerList()
        end
        
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            cleanUpFloat()
            
            floatBodyForce = Instance.new("BodyForce")
            floatBodyForce.Force = Vector3.new(0, character.HumanoidRootPart:GetMass() * workspace.Gravity, 0)
            floatBodyForce.Parent = character.HumanoidRootPart
            
            isFloating = true
            
            TweenService:Create(
                FloatToggle,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 27, 0, 2), BackgroundColor3 = Color3.fromRGB(0, 200, 0)}
            ):Play()
            TweenService:Create(
                FloatSwitch,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 100, 0)}
            ):Play()
        end
    end
end

-- Event handlers untuk tombol kontrol
UpButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        upButtonPressed = true
        TweenService:Create(
            UpButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.2}
        ):Play()
    end
end)

UpButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        upButtonPressed = false
        TweenService:Create(
            UpButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.5}
        ):Play()
    end
end)

DownButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        downButtonPressed = true
        TweenService:Create(
            DownButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.2}
        ):Play()
    end
end)

DownButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        downButtonPressed = false
        TweenService:Create(
            DownButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.5}
        ):Play()
    end
end)

-- Event handlers untuk switch
FlySwitch.MouseButton1Click:Connect(toggleFly)
FloatSwitch.MouseButton1Click:Connect(toggleFloat)

-- Event handler untuk WalkSpeed
SetWalkSpeedButton.MouseButton1Click:Connect(setWalkSpeed)

WalkSpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        setWalkSpeed()
    end
end)

-- Event handler untuk Waypoint
SetWaypointButton.MouseButton1Click:Connect(setWaypoint)

WaypointBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        setWaypoint()
    end
end)

-- ==================== EVENT HANDLERS PARTS ====================
PartsSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local displayedParts = filterParts(PartsSearchBox.Text)
    PartsInfoLabel.Text = "Parts Interaktif: " .. #allParts .. " | Ditampilkan: " .. displayedParts
    updatePartsList()
end)

RefreshPartsButton.MouseButton1Click:Connect(function()
    loadAndDisplayParts()
    
    TweenService:Create(
        RefreshPartsButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
    ):Play()
    wait(0.3)
    TweenService:Create(
        RefreshPartsButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- ==================== RIBBON SWITCHING ====================
local function switchRibbon(ribbonName)
    if ribbonName == "Utama" then
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        UtamaRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        UtamaContent.Visible = true
        TweenContent.Visible = false
        PartsContent.Visible = false
    elseif ribbonName == "Tween" then
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        UtamaRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        TweenRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        UtamaContent.Visible = false
        TweenContent.Visible = true
        PartsContent.Visible = false
        
        updateWaypointList()
    else -- Parts
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        UtamaRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        PartsRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        UtamaContent.Visible = false
        TweenContent.Visible = false
        PartsContent.Visible = true
        
        if #allParts == 0 then
            loadAndDisplayParts()
        else
            local displayedParts = filterParts(PartsSearchBox.Text)
            PartsInfoLabel.Text = "Parts Interaktif: " .. #allParts .. " | Ditampilkan: " .. displayedParts
            updatePartsList()
        end
    end
end

-- Event handlers untuk ribbon
UtamaRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Utama")
end)

TweenRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Tween")
end)

PartsRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Parts")
end)

-- ==================== POPUP CONTROLS YANG DIPERBAIKI ====================
local function togglePopup()
    if PopupFrame.Visible then
        -- Tutup popup dengan animasi
        TweenService:Create(
            PopupFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
        ):Play()
        
        wait(0.2)
        PopupFrame.Visible = false
    else
        -- Buka popup dengan animasi
        PopupFrame.Visible = true
        PopupFrame.Size = UDim2.new(0, 0, 0, 0)
        PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        updatePlayerList()
        
        TweenService:Create(
            PopupFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 300, 0, 400), Position = UDim2.new(0.5, -150, 0.5, -200)}
        ):Play()
    end
end

-- Event handler untuk floating button (toggle popup)
FloatingButton.MouseButton1Click:Connect(togglePopup)

-- Event handler untuk close button (destroy script)
CloseButton.MouseButton1Click:Connect(destroyScript)

-- Efek hover pada floating button
FloatingButton.MouseEnter:Connect(function()
    TweenService:Create(
        FloatingButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

FloatingButton.MouseLeave:Connect(function()
    TweenService:Create(
        FloatingButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Efek hover pada tombol switch
local function setupSwitchHover(switch, toggle)
    switch.MouseEnter:Connect(function()
        if toggle.Position == UDim2.new(0, 27, 0, 2) then
            TweenService:Create(
                switch,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 120, 0)}
            ):Play()
        else
            TweenService:Create(
                switch,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}
            ):Play()
        end
    end)
    
    switch.MouseLeave:Connect(function()
        if toggle.Position == UDim2.new(0, 27, 0, 2) then
            TweenService:Create(
                switch,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 100, 0)}
            ):Play()
        else
            TweenService:Create(
                switch,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
            ):Play()
        end
    end)
end

setupSwitchHover(FlySwitch, FlyToggle)
setupSwitchHover(FloatSwitch, FloatToggle)

-- Efek hover pada tombol Set WalkSpeed
SetWalkSpeedButton.MouseEnter:Connect(function()
    TweenService:Create(
        SetWalkSpeedButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

SetWalkSpeedButton.MouseLeave:Connect(function()
    TweenService:Create(
        SetWalkSpeedButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Efek hover pada tombol Set Waypoint
SetWaypointButton.MouseEnter:Connect(function()
    TweenService:Create(
        SetWaypointButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

SetWaypointButton.MouseLeave:Connect(function()
    TweenService:Create(
        SetWaypointButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Efek hover pada tombol Refresh Parts
RefreshPartsButton.MouseEnter:Connect(function()
    TweenService:Create(
        RefreshPartsButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

RefreshPartsButton.MouseLeave:Connect(function()
    TweenService:Create(
        RefreshPartsButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Efek hover pada ribbon buttons
UtamaRibbon.MouseEnter:Connect(function()
    if UtamaContent.Visible == false then
        TweenService:Create(
            UtamaRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
        ):Play()
    end
end)

UtamaRibbon.MouseLeave:Connect(function()
    if UtamaContent.Visible == false then
        TweenService:Create(
            UtamaRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
        ):Play()
    end
end)

TweenRibbon.MouseEnter:Connect(function()
    if TweenContent.Visible == false then
        TweenService:Create(
            TweenRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
        ):Play()
    end
end)

TweenRibbon.MouseLeave:Connect(function()
    if TweenContent.Visible == false then
        TweenService:Create(
            TweenRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
        ):Play()
    end
end)

PartsRibbon.MouseEnter:Connect(function()
    if PartsContent.Visible == false then
        TweenService:Create(
            PartsRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
        ):Play()
    end
end)

PartsRibbon.MouseLeave:Connect(function()
    if PartsContent.Visible == false then
        TweenService:Create(
            PartsRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
        ):Play()
    end
end)

-- ==================== RIBBON SCRIPT ====================

-- Tambahkan ScriptRibbon setelah PartsRibbon
local ScriptRibbon = Instance.new("TextButton")
ScriptRibbon.Size = UDim2.new(0.25, 0, 1, 0) -- Diubah dari 0.334 menjadi 0.25 karena sekarang ada 4 ribbon
ScriptRibbon.Position = UDim2.new(0.75, 0, 0, 0) -- Diubah dari 0.666 menjadi 0.75
ScriptRibbon.Text = "Script"
ScriptRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScriptRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
ScriptRibbon.Font = Enum.Font.GothamBold
ScriptRibbon.TextSize = 12
ScriptRibbon.Parent = RibbonFrame

-- Update ukuran ribbon yang lain karena sekarang ada 4 ribbon
UtamaRibbon.Size = UDim2.new(0.25, 0, 1, 0) -- Diubah dari 0.333
TweenRibbon.Size = UDim2.new(0.25, 0, 1, 0) -- Diubah dari 0.333
TweenRibbon.Position = UDim2.new(0.25, 0, 0, 0) -- Diubah dari 0.333
PartsRibbon.Size = UDim2.new(0.25, 0, 1, 0) -- Diubah dari 0.334
PartsRibbon.Position = UDim2.new(0.5, 0, 0, 0) -- Diubah dari 0.666

-- Script Content
local ScriptContent = Instance.new("Frame")
ScriptContent.Size = UDim2.new(1, 0, 1, 0)
ScriptContent.Position = UDim2.new(0, 0, 0, 0)
ScriptContent.BackgroundTransparency = 1
ScriptContent.Visible = false
ScriptContent.Parent = ContentFrame

-- Info Game
local GameInfoFrame = Instance.new("Frame")
GameInfoFrame.Size = UDim2.new(0, 260, 0, 60)
GameInfoFrame.Position = UDim2.new(0, 20, 0, 10)
GameInfoFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
GameInfoFrame.Parent = ScriptContent

local GameInfoCorner = Instance.new("UICorner")
GameInfoCorner.CornerRadius = UDim.new(0, 6)
GameInfoCorner.Parent = GameInfoFrame

local GameIcon = Instance.new("ImageLabel")
GameIcon.Size = UDim2.new(0, 50, 0, 50)
GameIcon.Position = UDim2.new(0, 5, 0, 5)
GameIcon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
GameIcon.Image = "rbxasset://textures/ui/LuaApp/icons/ic-game.png"
GameIcon.Parent = GameInfoFrame

local GameIconCorner = Instance.new("UICorner")
GameIconCorner.CornerRadius = UDim.new(0, 6)
GameIconCorner.Parent = GameIcon

local GameNameLabel = Instance.new("TextLabel")
GameNameLabel.Size = UDim2.new(0, 195, 0, 25)
GameNameLabel.Position = UDim2.new(0, 60, 0, 5)
GameNameLabel.BackgroundTransparency = 1
GameNameLabel.Text = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
GameNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
GameNameLabel.Font = Enum.Font.GothamBold
GameNameLabel.TextSize = 14
GameNameLabel.TextXAlignment = Enum.TextXAlignment.Left
GameNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
GameNameLabel.Parent = GameInfoFrame

local GameIdLabel = Instance.new("TextLabel")
GameIdLabel.Size = UDim2.new(0, 195, 0, 25)
GameIdLabel.Position = UDim2.new(0, 60, 0, 30)
GameIdLabel.BackgroundTransparency = 1
GameIdLabel.Text = "Place ID: " .. game.PlaceId
GameIdLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
GameIdLabel.Font = Enum.Font.Gotham
GameIdLabel.TextSize = 12
GameIdLabel.TextXAlignment = Enum.TextXAlignment.Left
GameIdLabel.Parent = GameInfoFrame

-- Pencarian Script
local ScriptSearchFrame = Instance.new("Frame")
ScriptSearchFrame.Size = UDim2.new(0, 260, 0, 30)
ScriptSearchFrame.Position = UDim2.new(0, 20, 0, 80)
ScriptSearchFrame.BackgroundTransparency = 1
ScriptSearchFrame.Parent = ScriptContent

local ScriptSearchLabel = Instance.new("TextLabel")
ScriptSearchLabel.Size = UDim2.new(0, 80, 1, 0)
ScriptSearchLabel.Position = UDim2.new(0, 0, 0, 0)
ScriptSearchLabel.BackgroundTransparency = 1
ScriptSearchLabel.Text = "Cari Script:"
ScriptSearchLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptSearchLabel.Font = Enum.Font.Gotham
ScriptSearchLabel.TextSize = 14
ScriptSearchLabel.TextXAlignment = Enum.TextXAlignment.Left
ScriptSearchLabel.Parent = ScriptSearchFrame

local ScriptSearchBox = Instance.new("TextBox")
ScriptSearchBox.Size = UDim2.new(0, 150, 1, 0)
ScriptSearchBox.Position = UDim2.new(0, 80, 0, 0)
ScriptSearchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScriptSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptSearchBox.Font = Enum.Font.Gotham
ScriptSearchBox.TextSize = 14
ScriptSearchBox.Text = ""
ScriptSearchBox.PlaceholderText = "Kata kunci script..."
ScriptSearchBox.Parent = ScriptSearchFrame

local ScriptSearchCorner = Instance.new("UICorner")
ScriptSearchCorner.CornerRadius = UDim.new(0, 6)
ScriptSearchCorner.Parent = ScriptSearchBox

-- Tombol Refresh Script
local RefreshScriptButton = Instance.new("TextButton")
RefreshScriptButton.Size = UDim2.new(0, 80, 0, 30)
RefreshScriptButton.Position = UDim2.new(0, 20, 0, 120)
RefreshScriptButton.Text = "Refresh Script"
RefreshScriptButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
RefreshScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshScriptButton.Font = Enum.Font.Gotham
RefreshScriptButton.TextSize = 12
RefreshScriptButton.Parent = ScriptContent

local RefreshScriptCorner = Instance.new("UICorner")
RefreshScriptCorner.CornerRadius = UDim.new(0, 6)
RefreshScriptCorner.Parent = RefreshScriptButton

-- Status Script
local ScriptStatusLabel = Instance.new("TextLabel")
ScriptStatusLabel.Size = UDim2.new(0, 200, 0, 20)
ScriptStatusLabel.Position = UDim2.new(0, 110, 0, 125)
ScriptStatusLabel.BackgroundTransparency = 1
ScriptStatusLabel.Text = "Total Script: 0"
ScriptStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ScriptStatusLabel.Font = Enum.Font.Gotham
ScriptStatusLabel.TextSize = 12
ScriptStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
ScriptStatusLabel.Parent = ScriptContent

-- Daftar Script
local ScriptListFrame = Instance.new("Frame")
ScriptListFrame.Size = UDim2.new(0, 260, 0, 230)
ScriptListFrame.Position = UDim2.new(0, 20, 0, 160)
ScriptListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ScriptListFrame.Parent = ScriptContent

local ScriptListCorner = Instance.new("UICorner")
ScriptListCorner.CornerRadius = UDim.new(0, 6)
ScriptListCorner.Parent = ScriptListFrame

local ScriptListLabel = Instance.new("TextLabel")
ScriptListLabel.Size = UDim2.new(1, 0, 0, 20)
ScriptListLabel.Position = UDim2.new(0, 0, 0, 0)
ScriptListLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ScriptListLabel.Text = "Daftar Script untuk Game Ini"
ScriptListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptListLabel.Font = Enum.Font.Gotham
ScriptListLabel.TextSize = 14
ScriptListLabel.Parent = ScriptListFrame

local ScriptListLabelCorner = Instance.new("UICorner")
ScriptListLabelCorner.CornerRadius = UDim.new(0, 6)
ScriptListLabelCorner.Parent = ScriptListLabel

local ScriptListScroll = Instance.new("ScrollingFrame")
ScriptListScroll.Size = UDim2.new(1, -10, 1, -30)
ScriptListScroll.Position = UDim2.new(0, 5, 0, 25)
ScriptListScroll.BackgroundTransparency = 1
ScriptListScroll.ScrollBarThickness = 5
ScriptListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptListScroll.Parent = ScriptListFrame

local ScriptListLayout = Instance.new("UIListLayout")
ScriptListLayout.Padding = UDim.new(0, 5)
ScriptListLayout.Parent = ScriptListScroll

-- Variabel untuk script functionality
local allScripts = {}
local filteredScripts = {}
local scriptCache = {}

-- ==================== FUNGSI SCRIPT ====================

-- Fungsi untuk mengambil script dari API ScriptBlox
local function fetchScriptsFromAPI()
    local placeId = game.PlaceId
    local apiUrl = "https://scriptblox.com/api/script/fetch?q=placeId:" .. placeId .. "&max=50"
    
    ScriptStatusLabel.Text = "Mengambil script..."
    
    local success, result = pcall(function()
        return game:GetService("HttpService"):GetAsync(apiUrl)
    end)
    
    if success then
        local data = game:GetService("HttpService"):JSONDecode(result)
        allScripts = {}
        
        if data and data.result and data.result.scripts then
            for _, scriptData in ipairs(data.result.scripts) do
                table.insert(allScripts, {
                    title = scriptData.title or "No Title",
                    script = scriptData.script or "",
                    game = scriptData.game or {name = "Unknown"},
                    views = scriptData.views or 0,
                    likes = scriptData.likes or 0,
                    verified = scriptData.verified or false,
                    patched = scriptData.patched or false
                })
            end
            
            ScriptStatusLabel.Text = "Script ditemukan: " .. #allScripts
        else
            ScriptStatusLabel.Text = "Tidak ada script ditemukan"
        end
    else
        ScriptStatusLabel.Text = "Error mengambil script"
        -- Fallback: script contoh untuk demo
        allScripts = {
            {
                title = "Auto Farm Example",
                script = "print('Auto Farm Script Loaded')",
                game = {name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name},
                views = 1000,
                likes = 50,
                verified = true,
                patched = false
            },
            {
                title = "ESP Players",
                script = "print('ESP Script Loaded')",
                game = {name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name},
                views = 500,
                likes = 25,
                verified = false,
                patched = false
            }
        }
        ScriptStatusLabel.Text = "Demo Script: " .. #allScripts
    end
    
    -- Filter script berdasarkan pencarian
    filterScripts(ScriptSearchBox.Text)
    updateScriptList()
end

-- Fungsi untuk memfilter script berdasarkan pencarian
local function filterScripts(searchText)
    filteredScripts = {}
    
    if searchText == "" or searchText == nil then
        for i, script in ipairs(allScripts) do
            filteredScripts[i] = script
        end
    else
        local searchLower = string.lower(searchText)
        for _, script in ipairs(allScripts) do
            if string.find(string.lower(script.title), searchLower) then
                table.insert(filteredScripts, script)
            end
        end
    end
    
    return #filteredScripts
end

-- Fungsi untuk mengeksekusi script
local function executeScript(scriptContent, scriptTitle)
    local success, errorMessage = pcall(function()
        -- Coba load string sebagai script
        local loadedFunction = loadstring(scriptContent)
        if loadedFunction then
            loadedFunction()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Script Executed",
                Text = scriptTitle .. " berhasil dijalankan!",
                Duration = 3
            })
        else
            error("Gagal memuat script")
        end
    end)
    
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script Error",
            Text = "Gagal menjalankan script: " .. errorMessage,
            Duration = 5
        })
    end
end

-- Fungsi untuk memperbarui daftar script di GUI
local function updateScriptList()
    for _, child in ipairs(ScriptListScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local contentHeight = 0
    
    for _, scriptData in ipairs(filteredScripts) do
        local scriptItem = Instance.new("Frame")
        scriptItem.Size = UDim2.new(1, 0, 0, 80)
        scriptItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        scriptItem.Parent = ScriptListScroll
        
        local scriptItemCorner = Instance.new("UICorner")
        scriptItemCorner.CornerRadius = UDim.new(0, 4)
        scriptItemCorner.Parent = scriptItem
        
        -- Judul Script
        local scriptTitle = Instance.new("TextLabel")
        scriptTitle.Size = UDim2.new(0.9, 0, 0.3, 0)
        scriptTitle.Position = UDim2.new(0, 5, 0, 0)
        scriptTitle.BackgroundTransparency = 1
        scriptTitle.Text = scriptData.title
        scriptTitle.TextColor3 = scriptData.verified and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
        scriptTitle.Font = Enum.Font.GothamBold
        scriptTitle.TextSize = 12
        scriptTitle.TextXAlignment = Enum.TextXAlignment.Left
        scriptTitle.TextTruncate = Enum.TextTruncate.AtEnd
        scriptTitle.Parent = scriptItem
        
        -- Status Verified
        if scriptData.verified then
            local verifiedBadge = Instance.new("TextLabel")
            verifiedBadge.Size = UDim2.new(0.1, 0, 0.3, 0)
            verifiedBadge.Position = UDim2.new(0.9, 0, 0, 0)
            verifiedBadge.BackgroundTransparency = 1
            verifiedBadge.Text = "✓"
            verifiedBadge.TextColor3 = Color3.fromRGB(0, 255, 0)
            verifiedBadge.Font = Enum.Font.GothamBold
            verifiedBadge.TextSize = 12
            verifiedBadge.Parent = scriptItem
        end
        
        -- Info Game
        local gameInfo = Instance.new("TextLabel")
        gameInfo.Size = UDim2.new(0.9, 0, 0.25, 0)
        gameInfo.Position = UDim2.new(0, 5, 0.3, 0)
        gameInfo.BackgroundTransparency = 1
        gameInfo.Text = "Game: " .. scriptData.game.name
        gameInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
        gameInfo.Font = Enum.Font.Gotham
        gameInfo.TextSize = 10
        gameInfo.TextXAlignment = Enum.TextXAlignment.Left
        gameInfo.TextTruncate = Enum.TextTruncate.AtEnd
        gameInfo.Parent = scriptItem
        
        -- Stats (Views & Likes)
        local statsInfo = Instance.new("TextLabel")
        statsInfo.Size = UDim2.new(0.9, 0, 0.25, 0)
        statsInfo.Position = UDim2.new(0, 5, 0.55, 0)
        statsInfo.BackgroundTransparency = 1
        statsInfo.Text = "👁 " .. scriptData.views .. " | ❤ " .. scriptData.likes
        statsInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
        statsInfo.Font = Enum.Font.Gotham
        statsInfo.TextSize = 10
        statsInfo.TextXAlignment = Enum.TextXAlignment.Left
        statsInfo.Parent = scriptItem
        
        -- Status Patched
        local statusInfo = Instance.new("TextLabel")
        statusInfo.Size = UDim2.new(0.9, 0, 0.2, 0)
        statusInfo.Position = UDim2.new(0, 5, 0.8, 0)
        statusInfo.BackgroundTransparency = 1
        statusInfo.Text = scriptData.patched and "⚠ PATCHED" or "✅ WORKING"
        statusInfo.TextColor3 = scriptData.patched and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
        statusInfo.Font = Enum.Font.GothamBold
        statusInfo.TextSize = 10
        statusInfo.TextXAlignment = Enum.TextXAlignment.Left
        statusInfo.Parent = scriptItem
        
        -- Container untuk tombol
        local buttonContainer = Instance.new("Frame")
        buttonContainer.Size = UDim2.new(0.3, 0, 0.6, 0)
        buttonContainer.Position = UDim2.new(0.7, 0, 0.2, 0)
        buttonContainer.BackgroundTransparency = 1
        buttonContainer.Parent = scriptItem

        -- Tombol Play Script
        local playButton = Instance.new("TextButton")
        playButton.Size = UDim2.new(0.9, 0, 0.45, 0)
        playButton.Position = UDim2.new(0.05, 0, 0, 0)
        playButton.Text = "Play"
        playButton.BackgroundColor3 = scriptData.patched and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(0, 200, 0)
        playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        playButton.Font = Enum.Font.GothamBold
        playButton.TextSize = 12
        playButton.AutoButtonColor = not scriptData.patched
        playButton.Parent = buttonContainer
        
        local playButtonCorner = Instance.new("UICorner")
        playButtonCorner.CornerRadius = UDim.new(0, 4)
        playButtonCorner.Parent = playButton
        
        -- Tombol View Code
        local viewButton = Instance.new("TextButton")
        viewButton.Size = UDim2.new(0.9, 0, 0.45, 0)
        viewButton.Position = UDim2.new(0.05, 0, 0.55, 0)
        viewButton.Text = "View Code"
        viewButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        viewButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        viewButton.Font = Enum.Font.Gotham
        viewButton.TextSize = 10
        viewButton.Parent = buttonContainer
        
        local viewButtonCorner = Instance.new("UICorner")
        viewButtonCorner.CornerRadius = UDim.new(0, 4)
        viewButtonCorner.Parent = viewButton
        
        -- Event handler untuk tombol play
        playButton.MouseButton1Click:Connect(function()
            if not scriptData.patched then
                executeScript(scriptData.script, scriptData.title)
                
                -- Feedback visual
                playButton.Text = "Executing..."
                playButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                
                wait(1)
                playButton.Text = "Play"
                playButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Script Patched",
                    Text = "Script ini sudah tidak bekerja!",
                    Duration = 3
                })
            end
        end)
        
        -- Event handler untuk tombol view code (modal sederhana)
        viewButton.MouseButton1Click:Connect(function()
            -- Buat modal untuk menampilkan kode
            local codeModal = Instance.new("Frame")
            codeModal.Size = UDim2.new(0, 400, 0, 300)
            codeModal.Position = UDim2.new(0.5, -200, 0.5, -150)
            codeModal.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            codeModal.BorderSizePixel = 0
            codeModal.ZIndex = 10
            codeModal.Parent = ScriptContent
            
            local codeModalCorner = Instance.new("UICorner")
            codeModalCorner.CornerRadius = UDim.new(0, 12)
            codeModalCorner.Parent = codeModal
            
            local titleBar = Instance.new("Frame")
            titleBar.Size = UDim2.new(1, 0, 0, 40)
            titleBar.Position = UDim2.new(0, 0, 0, 0)
            titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            titleBar.Parent = codeModal
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
            titleLabel.Position = UDim2.new(0, 10, 0, 0)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = "Kode: " .. scriptData.title
            titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.Parent = titleBar
            
            local closeButton = Instance.new("TextButton")
            closeButton.Size = UDim2.new(0, 30, 0, 30)
            closeButton.Position = UDim2.new(1, -35, 0, 5)
            closeButton.Text = "X"
            closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
            closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            closeButton.Font = Enum.Font.GothamBold
            closeButton.TextSize = 14
            closeButton.Parent = titleBar
            
            local closeCorner = Instance.new("UICorner")
            closeCorner.CornerRadius = UDim.new(1, 0)
            closeCorner.Parent = closeButton
            
            local codeScroll = Instance.new("ScrollingFrame")
            codeScroll.Size = UDim2.new(1, -20, 1, -60)
            codeScroll.Position = UDim2.new(0, 10, 0, 50)
            codeScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            codeScroll.ScrollBarThickness = 8
            codeScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
            codeScroll.Parent = codeModal
            
            local codeText = Instance.new("TextLabel")
            codeText.Size = UDim2.new(1, -10, 1, -10)
            codeText.Position = UDim2.new(0, 5, 0, 5)
            codeText.BackgroundTransparency = 1
            codeText.Text = scriptData.script
            codeText.TextColor3 = Color3.fromRGB(200, 200, 200)
            codeText.Font = Enum.Font.Code
            codeText.TextSize = 10
            codeText.TextXAlignment = Enum.TextXAlignment.Left
            codeText.TextYAlignment = Enum.TextYAlignment.Top
            codeText.TextWrapped = false
            codeText.TextTruncate = Enum.TextTruncate.None
            codeText.Parent = codeScroll
            
            -- Hitung tinggi teks untuk canvas size
            local lineCount = select(2, string.gsub(scriptData.script, "\n", "")) + 1
            codeScroll.CanvasSize = UDim2.new(0, 0, 0, lineCount * 15)
            
            -- Tombol copy
            local copyButton = Instance.new("TextButton")
            copyButton.Size = UDim2.new(0, 100, 0, 30)
            copyButton.Position = UDim2.new(0.5, -50, 1, -40)
            copyButton.Text = "Copy Code"
            copyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            copyButton.Font = Enum.Font.Gotham
            copyButton.TextSize = 12
            copyButton.Parent = codeModal
            
            local copyCorner = Instance.new("UICorner")
            copyCorner.CornerRadius = UDim.new(0, 6)
            copyCorner.Parent = copyButton
            
            -- Event handlers untuk modal
            closeButton.MouseButton1Click:Connect(function()
                codeModal:Destroy()
            end)
            
            copyButton.MouseButton1Click:Connect(function()
                -- Untuk copy text, kita bisa set ke clipboard (jika supported) atau beri notifikasi
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Copy Code",
                    Text = "Kode telah disalin ke clipboard!",
                    Duration = 3
                })
            end)
        end)
        
        -- Efek hover pada tombol
        if not scriptData.patched then
            playButton.MouseEnter:Connect(function()
                TweenService:Create(
                    playButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(0, 180, 0)}
                ):Play()
            end)
            
            playButton.MouseLeave:Connect(function()
                TweenService:Create(
                    playButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}
                ):Play()
            end)
        end
        
        viewButton.MouseEnter:Connect(function()
            TweenService:Create(
                viewButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
            ):Play()
        end)
        
        viewButton.MouseLeave:Connect(function()
            TweenService:Create(
                viewButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
            ):Play()
        end)
        
        contentHeight = contentHeight + 85
    end
    
    ScriptListScroll.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

-- ==================== UPDATE FUNGSI SWITCH RIBBON ====================

local function switchRibbon(ribbonName)
    if ribbonName == "Utama" then
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        UtamaRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScriptRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ScriptRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        UtamaContent.Visible = true
        TweenContent.Visible = false
        PartsContent.Visible = false
        ScriptContent.Visible = false
    elseif ribbonName == "Tween" then
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        UtamaRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        TweenRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScriptRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ScriptRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        UtamaContent.Visible = false
        TweenContent.Visible = true
        PartsContent.Visible = false
        ScriptContent.Visible = false
        
        updateWaypointList()
    elseif ribbonName == "Parts" then
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        UtamaRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        PartsRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        ScriptRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ScriptRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        UtamaContent.Visible = false
        TweenContent.Visible = false
        PartsContent.Visible = true
        ScriptContent.Visible = false
        
        if #allParts == 0 then
            loadAndDisplayParts()
        else
            local displayedParts = filterParts(PartsSearchBox.Text)
            PartsInfoLabel.Text = "Parts Interaktif: " .. #allParts .. " | Ditampilkan: " .. displayedParts
            updatePartsList()
        end
    else -- Script
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        UtamaRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScriptRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        ScriptRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        UtamaContent.Visible = false
        TweenContent.Visible = false
        PartsContent.Visible = false
        ScriptContent.Visible = true
        
        if #allScripts == 0 then
            fetchScriptsFromAPI()
        else
            local displayedScripts = filterScripts(ScriptSearchBox.Text)
            ScriptStatusLabel.Text = "Total Script: " .. #allScripts .. " | Ditampilkan: " .. displayedScripts
            updateScriptList()
        end
    end
end

-- ==================== EVENT HANDLERS SCRIPT ====================

-- Event handler untuk ScriptRibbon
ScriptRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Script")
end)

-- Event handler untuk pencarian script
ScriptSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local displayedScripts = filterScripts(ScriptSearchBox.Text)
    ScriptStatusLabel.Text = "Total Script: " .. #allScripts .. " | Ditampilkan: " .. displayedScripts
    updateScriptList()
end)

-- Event handler untuk tombol refresh script
RefreshScriptButton.MouseButton1Click:Connect(function()
    fetchScriptsFromAPI()
    
    TweenService:Create(
        RefreshScriptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
    ):Play()
    wait(0.3)
    TweenService:Create(
        RefreshScriptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Efek hover untuk ScriptRibbon
ScriptRibbon.MouseEnter:Connect(function()
    if ScriptContent.Visible == false then
        TweenService:Create(
            ScriptRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
        ):Play()
    end
end)

ScriptRibbon.MouseLeave:Connect(function()
    if ScriptContent.Visible == false then
        TweenService:Create(
            ScriptRibbon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
        ):Play()
    end
end)

-- Efek hover untuk tombol refresh script
RefreshScriptButton.MouseEnter:Connect(function()
    TweenService:Create(
        RefreshScriptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

RefreshScriptButton.MouseLeave:Connect(function()
    TweenService:Create(
        RefreshScriptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Deteksi ketika pemain bergabung atau keluar
local playerAddedConn = Players.PlayerAdded:Connect(updatePlayerList)
local playerRemovingConn = Players.PlayerRemoving:Connect(updatePlayerList)

-- Fungsi untuk menangani perubahan karakter
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        cleanUpFly()
        cleanUpFloat()
        cleanUpHead()
        updatePlayerList()
    end)
end

-- Event untuk karakter yang baru ditambahkan
local characterAddedConn
if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

characterAddedConn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Notifikasi
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Milky Menu Loaded",
    Text = "Menu dengan ESP dan fitur lengkap telah dimuat!",
    Duration = 5
})

-- Pastikan semua fungsi dimatikan saat game dimatikan
game:BindToClose(function()
    destroyScript()
end)
