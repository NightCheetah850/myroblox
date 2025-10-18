-- Floating Menu Milky dengan Kontrol Tombol untuk Mobile dan Daftar Pemain
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

-- Main GUI dengan ZIndex tinggi agar tampil di atas UI lain
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MilkyFloatingMenu_" .. HttpService:GenerateGUID(false):sub(1, 8)
ScreenGui.Parent = CoreGui -- Parent ke CoreGui agar selalu tampil di atas
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global -- Global untuk ZIndex tertinggi
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 9999 -- Nilai sangat tinggi untuk tampil di atas semua UI

-- ==================== WINDOWS-LIKE MAIN WINDOW ====================
local MainWindow = Instance.new("Frame")
MainWindow.Size = UDim2.new(0, 350, 0, 450)
MainWindow.Position = UDim2.new(0.1, 0, 0.1, 0) -- Posisi awal
MainWindow.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainWindow.BorderSizePixel = 1
MainWindow.BorderColor3 = Color3.fromRGB(80, 80, 80)
MainWindow.Active = true
MainWindow.Selectable = true
MainWindow.ClipsDescendants = true
MainWindow.ZIndex = 10000
MainWindow.Parent = ScreenGui

-- Windows Style Shadow Effect
local WindowShadow = Instance.new("Frame")
WindowShadow.Size = UDim2.new(1, 6, 1, 6)
WindowShadow.Position = UDim2.new(0, -3, 0, -3)
WindowShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
WindowShadow.BackgroundTransparency = 0.8
WindowShadow.BorderSizePixel = 0
WindowShadow.ZIndex = 9999
WindowShadow.Parent = MainWindow

local WindowShadowCorner = Instance.new("UICorner")
WindowShadowCorner.CornerRadius = UDim.new(0, 8)
WindowShadowCorner.Parent = WindowShadow

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 6)
WindowCorner.Parent = MainWindow

-- Title Bar (untuk drag functionality)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 10001
TitleBar.Parent = MainWindow

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 6)
TitleBarCorner.Parent = TitleBar

-- Title Text
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Milky Menu v1.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 10002
TitleLabel.Parent = TitleBar

-- Window Controls (Minimize, Maximize, Close)
local WindowControls = Instance.new("Frame")
WindowControls.Size = UDim2.new(0, 60, 1, 0)
WindowControls.Position = UDim2.new(1, -65, 0, 0)
WindowControls.BackgroundTransparency = 1
WindowControls.ZIndex = 10002
WindowControls.Parent = TitleBar

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 18, 0, 18)
MinimizeButton.Position = UDim2.new(0, 5, 0.5, -9)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 14
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.ZIndex = 10003
MinimizeButton.Parent = WindowControls

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 3)
MinimizeCorner.Parent = MinimizeButton

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 18, 0, 18)
CloseButton.Position = UDim2.new(1, -23, 0.5, -9)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.ZIndex = 10003
CloseButton.Parent = WindowControls

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 3)
CloseCorner.Parent = CloseButton

-- ==================== POPUP KONFIRMASI ====================
-- Popup Konfirmasi Penutupan
local ConfirmPopup = Instance.new("Frame")
ConfirmPopup.Size = UDim2.new(0, 300, 0, 150)
ConfirmPopup.Position = UDim2.new(0.5, -150, 0.5, -75)
ConfirmPopup.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ConfirmPopup.BorderSizePixel = 1
ConfirmPopup.BorderColor3 = Color3.fromRGB(80, 80, 80)
ConfirmPopup.Visible = false
ConfirmPopup.ZIndex = 10010
ConfirmPopup.Parent = ScreenGui

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 8)
ConfirmCorner.Parent = ConfirmPopup

-- Shadow untuk ConfirmPopup
local ConfirmShadow = Instance.new("Frame")
ConfirmShadow.Size = UDim2.new(1, 6, 1, 6)
ConfirmShadow.Position = UDim2.new(0, -3, 0, -3)
ConfirmShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ConfirmShadow.BackgroundTransparency = 0.8
ConfirmShadow.BorderSizePixel = 0
ConfirmShadow.ZIndex = 10009
ConfirmShadow.Parent = ConfirmPopup

local ConfirmShadowCorner = Instance.new("UICorner")
ConfirmShadowCorner.CornerRadius = UDim.new(0, 8)
ConfirmShadowCorner.Parent = ConfirmShadow

-- Judul Konfirmasi
local ConfirmTitle = Instance.new("TextLabel")
ConfirmTitle.Size = UDim2.new(1, 0, 0, 40)
ConfirmTitle.Position = UDim2.new(0, 0, 0, 0)
ConfirmTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ConfirmTitle.Text = "Konfirmasi Penutupan"
ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmTitle.Font = Enum.Font.GothamBold
ConfirmTitle.TextSize = 16
ConfirmTitle.ZIndex = 10011
ConfirmTitle.Parent = ConfirmPopup

local ConfirmTitleCorner = Instance.new("UICorner")
ConfirmTitleCorner.CornerRadius = UDim.new(0, 8)
ConfirmTitleCorner.Parent = ConfirmTitle

-- Pesan Konfirmasi
local ConfirmMessage = Instance.new("TextLabel")
ConfirmMessage.Size = UDim2.new(1, -20, 0, 50)
ConfirmMessage.Position = UDim2.new(0, 10, 0, 45)
ConfirmMessage.BackgroundTransparency = 1
ConfirmMessage.Text = "Apakah Anda yakin ingin menutup menu?"
ConfirmMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmMessage.Font = Enum.Font.Gotham
ConfirmMessage.TextSize = 14
ConfirmMessage.TextWrapped = true
ConfirmMessage.ZIndex = 10011
ConfirmMessage.Parent = ConfirmPopup

-- Tombol Ya
local ConfirmYesButton = Instance.new("TextButton")
ConfirmYesButton.Size = UDim2.new(0, 100, 0, 35)
ConfirmYesButton.Position = UDim2.new(0, 40, 1, -50)
ConfirmYesButton.Text = "Ya"
ConfirmYesButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
ConfirmYesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmYesButton.Font = Enum.Font.GothamBold
ConfirmYesButton.TextSize = 14
ConfirmYesButton.ZIndex = 10011
ConfirmYesButton.Parent = ConfirmPopup

local ConfirmYesCorner = Instance.new("UICorner")
ConfirmYesCorner.CornerRadius = UDim.new(0, 6)
ConfirmYesCorner.Parent = ConfirmYesButton

-- Tombol Tidak
local ConfirmNoButton = Instance.new("TextButton")
ConfirmNoButton.Size = UDim2.new(0, 100, 0, 35)
ConfirmNoButton.Position = UDim2.new(1, -140, 1, -50)
ConfirmNoButton.Text = "Tidak"
ConfirmNoButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ConfirmNoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmNoButton.Font = Enum.Font.GothamBold
ConfirmNoButton.TextSize = 14
ConfirmNoButton.ZIndex = 10011
ConfirmNoButton.Parent = ConfirmPopup

local ConfirmNoCorner = Instance.new("UICorner")
ConfirmNoCorner.CornerRadius = UDim.new(0, 6)
ConfirmNoCorner.Parent = ConfirmNoButton

-- ==================== MAIN CONTENT AREA ====================
-- Container untuk konten utama (di bawah title bar)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, 0, 1, -30)
ContentArea.Position = UDim2.new(0, 0, 0, 30)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 10001
ContentArea.Parent = MainWindow

-- Ribbon Navigation (4 ribbon)
local RibbonFrame = Instance.new("Frame")
RibbonFrame.Size = UDim2.new(1, 0, 0, 40)
RibbonFrame.Position = UDim2.new(0, 0, 0, 0)
RibbonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
RibbonFrame.BorderSizePixel = 0
RibbonFrame.ZIndex = 10001
RibbonFrame.Parent = ContentArea

local RibbonCorner = Instance.new("UICorner")
RibbonCorner.CornerRadius = UDim.new(0, 6)
RibbonCorner.Parent = RibbonFrame

-- Ribbon Buttons (4 ribbon)
local UtamaRibbon = Instance.new("TextButton")
UtamaRibbon.Size = UDim2.new(0.25, 0, 1, 0)
UtamaRibbon.Position = UDim2.new(0, 0, 0, 0)
UtamaRibbon.Text = "Utama"
UtamaRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
UtamaRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
UtamaRibbon.Font = Enum.Font.GothamBold
UtamaRibbon.TextSize = 12
UtamaRibbon.ZIndex = 10002
UtamaRibbon.Parent = RibbonFrame

local TweenRibbon = Instance.new("TextButton")
TweenRibbon.Size = UDim2.new(0.25, 0, 1, 0)
TweenRibbon.Position = UDim2.new(0.25, 0, 0, 0)
TweenRibbon.Text = "Tween"
TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
TweenRibbon.Font = Enum.Font.GothamBold
TweenRibbon.TextSize = 12
TweenRibbon.ZIndex = 10002
TweenRibbon.Parent = RibbonFrame

local PartsRibbon = Instance.new("TextButton")
PartsRibbon.Size = UDim2.new(0.25, 0, 1, 0)
PartsRibbon.Position = UDim2.new(0.5, 0, 0, 0)
PartsRibbon.Text = "Parts"
PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
PartsRibbon.Font = Enum.Font.GothamBold
PartsRibbon.TextSize = 12
PartsRibbon.ZIndex = 10002
PartsRibbon.Parent = RibbonFrame

local ScriptRibbon = Instance.new("TextButton")
ScriptRibbon.Size = UDim2.new(0.25, 0, 1, 0)
ScriptRibbon.Position = UDim2.new(0.75, 0, 0, 0)
ScriptRibbon.Text = "Script"
ScriptRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScriptRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
ScriptRibbon.Font = Enum.Font.GothamBold
ScriptRibbon.TextSize = 12
ScriptRibbon.ZIndex = 10002
ScriptRibbon.Parent = RibbonFrame

-- Content Frames
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 10001
ContentFrame.Parent = ContentArea

-- Utama Content
local UtamaContent = Instance.new("Frame")
UtamaContent.Size = UDim2.new(1, 0, 1, 0)
UtamaContent.Position = UDim2.new(0, 0, 0, 0)
UtamaContent.BackgroundTransparency = 1
UtamaContent.Visible = true
UtamaContent.ZIndex = 10001
UtamaContent.Parent = ContentFrame

-- Fly Switch
local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(0, 310, 0, 30)
FlyFrame.Position = UDim2.new(0, 20, 0, 60)
FlyFrame.BackgroundTransparency = 1
FlyFrame.ZIndex = 10002
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
FlyLabel.ZIndex = 10002
FlyLabel.Parent = FlyFrame

local FlySwitch = Instance.new("TextButton")
FlySwitch.Size = UDim2.new(0, 50, 0, 25)
FlySwitch.Position = UDim2.new(1, -50, 0, 2)
FlySwitch.Text = ""
FlySwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FlySwitch.ZIndex = 10002
FlySwitch.Parent = FlyFrame

local FlySwitchCorner = Instance.new("UICorner")
FlySwitchCorner.CornerRadius = UDim.new(0, 12)
FlySwitchCorner.Parent = FlySwitch

local FlyToggle = Instance.new("Frame")
FlyToggle.Size = UDim2.new(0, 21, 0, 21)
FlyToggle.Position = UDim2.new(0, 2, 0, 2)
FlyToggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
FlyToggle.ZIndex = 10003
FlyToggle.Parent = FlySwitch

local FlyToggleCorner = Instance.new("UICorner")
FlyToggleCorner.CornerRadius = UDim.new(0, 10)
FlyToggleCorner.Parent = FlyToggle

-- Float Switch
local FloatFrame = Instance.new("Frame")
FloatFrame.Size = UDim2.new(0, 310, 0, 30)
FloatFrame.Position = UDim2.new(0, 20, 0, 100)
FloatFrame.BackgroundTransparency = 1
FloatFrame.ZIndex = 10002
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
FloatLabel.ZIndex = 10002
FloatLabel.Parent = FloatFrame

local FloatSwitch = Instance.new("TextButton")
FloatSwitch.Size = UDim2.new(0, 50, 0, 25)
FloatSwitch.Position = UDim2.new(1, -50, 0, 2)
FloatSwitch.Text = ""
FloatSwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FloatSwitch.ZIndex = 10002
FloatSwitch.Parent = FloatFrame

local FloatSwitchCorner = Instance.new("UICorner")
FloatSwitchCorner.CornerRadius = UDim.new(0, 12)
FloatSwitchCorner.Parent = FloatSwitch

local FloatToggle = Instance.new("Frame")
FloatToggle.Size = UDim2.new(0, 21, 0, 21)
FloatToggle.Position = UDim2.new(0, 2, 0, 2)
FloatToggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
FloatToggle.ZIndex = 10003
FloatToggle.Parent = FloatSwitch

local FloatToggleCorner = Instance.new("UICorner")
FloatToggleCorner.CornerRadius = UDim.new(0, 10)
FloatToggleCorner.Parent = FloatToggle

-- Brightness Switch
local BrightnessFrame = Instance.new("Frame")
BrightnessFrame.Size = UDim2.new(0, 310, 0, 30)
BrightnessFrame.Position = UDim2.new(0, 20, 0, 140)
BrightnessFrame.BackgroundTransparency = 1
BrightnessFrame.ZIndex = 10002
BrightnessFrame.Parent = UtamaContent

local BrightnessLabel = Instance.new("TextLabel")
BrightnessLabel.Size = UDim2.new(0, 100, 1, 0)
BrightnessLabel.Position = UDim2.new(0, 0, 0, 0)
BrightnessLabel.BackgroundTransparency = 1
BrightnessLabel.Text = "Brightness:"
BrightnessLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BrightnessLabel.Font = Enum.Font.Gotham
BrightnessLabel.TextSize = 14
BrightnessLabel.TextXAlignment = Enum.TextXAlignment.Left
BrightnessLabel.ZIndex = 10002
BrightnessLabel.Parent = BrightnessFrame

local BrightnessSwitch = Instance.new("TextButton")
BrightnessSwitch.Size = UDim2.new(0, 50, 0, 25)
BrightnessSwitch.Position = UDim2.new(1, -50, 0, 2)
BrightnessSwitch.Text = ""
BrightnessSwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
BrightnessSwitch.ZIndex = 10002
BrightnessSwitch.Parent = BrightnessFrame

local BrightnessSwitchCorner = Instance.new("UICorner")
BrightnessSwitchCorner.CornerRadius = UDim.new(0, 12)
BrightnessSwitchCorner.Parent = BrightnessSwitch

local BrightnessToggle = Instance.new("Frame")
BrightnessToggle.Size = UDim2.new(0, 21, 0, 21)
BrightnessToggle.Position = UDim2.new(0, 2, 0, 2)
BrightnessToggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
BrightnessToggle.ZIndex = 10003
BrightnessToggle.Parent = BrightnessSwitch

local BrightnessToggleCorner = Instance.new("UICorner")
BrightnessToggleCorner.CornerRadius = UDim.new(0, 10)
BrightnessToggleCorner.Parent = BrightnessToggle

-- WalkSpeed Input
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Size = UDim2.new(0, 310, 0, 30)
WalkSpeedFrame.Position = UDim2.new(0, 20, 0, 180)
WalkSpeedFrame.BackgroundTransparency = 1
WalkSpeedFrame.ZIndex = 10002
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
WalkSpeedLabel.ZIndex = 10002
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
WalkSpeedBox.ZIndex = 10002
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
SetWalkSpeedButton.ZIndex = 10002
SetWalkSpeedButton.Parent = WalkSpeedFrame

local SetWalkSpeedCorner = Instance.new("UICorner")
SetWalkSpeedCorner.CornerRadius = UDim.new(0, 6)
SetWalkSpeedCorner.Parent = SetWalkSpeedButton

-- Daftar Pemain
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Size = UDim2.new(0, 310, 0, 120)
PlayerListFrame.Position = UDim2.new(0, 20, 0, 220)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PlayerListFrame.ZIndex = 10002
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
PlayerListLabel.ZIndex = 10003
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
PlayerListScroll.ZIndex = 10002
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
TweenContent.ZIndex = 10001
TweenContent.Parent = ContentFrame

-- Waypoint Input Form
local WaypointFrame = Instance.new("Frame")
WaypointFrame.Size = UDim2.new(0, 310, 0, 30)
WaypointFrame.Position = UDim2.new(0, 20, 0, 10)
WaypointFrame.BackgroundTransparency = 1
WaypointFrame.ZIndex = 10002
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
WaypointLabel.ZIndex = 10002
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
WaypointBox.ZIndex = 10002
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
SetWaypointButton.ZIndex = 10002
SetWaypointButton.Parent = WaypointFrame

local SetWaypointCorner = Instance.new("UICorner")
SetWaypointCorner.CornerRadius = UDim.new(0, 6)
SetWaypointCorner.Parent = SetWaypointButton

-- Daftar Waypoint
local WaypointListFrame = Instance.new("Frame")
WaypointListFrame.Size = UDim2.new(0, 310, 0, 330)
WaypointListFrame.Position = UDim2.new(0, 20, 0, 50)
WaypointListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
WaypointListFrame.ZIndex = 10002
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
WaypointListLabel.ZIndex = 10003
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
WaypointListScroll.ZIndex = 10002
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
PartsContent.ZIndex = 10001
PartsContent.Parent = ContentFrame

-- Pencarian Parts
local PartsSearchFrame = Instance.new("Frame")
PartsSearchFrame.Size = UDim2.new(0, 310, 0, 30)
PartsSearchFrame.Position = UDim2.new(0, 20, 0, 10)
PartsSearchFrame.BackgroundTransparency = 1
PartsSearchFrame.ZIndex = 10002
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
PartsSearchLabel.ZIndex = 10002
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
PartsSearchBox.ZIndex = 10002
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
RefreshPartsButton.ZIndex = 10002
RefreshPartsButton.Parent = PartsContent

local RefreshPartsCorner = Instance.new("UICorner")
RefreshPartsCorner.CornerRadius = UDim.new(0, 6)
RefreshPartsCorner.Parent = RefreshPartsButton

-- Info Parts
local PartsInfoLabel = Instance.new("TextLabel")
PartsInfoLabel.Size = UDim2.new(0, 240, 0, 20)
PartsInfoLabel.Position = UDim2.new(0, 20, 0, 45)
PartsInfoLabel.BackgroundTransparency = 1
PartsInfoLabel.Text = "Total Parts: 0"
PartsInfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PartsInfoLabel.Font = Enum.Font.Gotham
PartsInfoLabel.TextSize = 12
PartsInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
PartsInfoLabel.ZIndex = 10002
PartsInfoLabel.Parent = PartsContent

-- Daftar Parts
local PartsListFrame = Instance.new("Frame")
PartsListFrame.Size = UDim2.new(0, 310, 0, 350)
PartsListFrame.Position = UDim2.new(0, 20, 0, 80)
PartsListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PartsListFrame.ZIndex = 10002
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
PartsListLabel.ZIndex = 10003
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
PartsListScroll.ZIndex = 10002
PartsListScroll.Parent = PartsListFrame

local PartsListLayout = Instance.new("UIListLayout")
PartsListLayout.Padding = UDim.new(0, 5)
PartsListLayout.Parent = PartsListScroll

-- Script Content
local ScriptContent = Instance.new("Frame")
ScriptContent.Size = UDim2.new(1, 0, 1, 0)
ScriptContent.Position = UDim2.new(0, 0, 0, 0)
ScriptContent.BackgroundTransparency = 1
ScriptContent.Visible = false
ScriptContent.ZIndex = 10001
ScriptContent.Parent = ContentFrame

-- Info Game
local GameInfoFrame = Instance.new("Frame")
GameInfoFrame.Size = UDim2.new(0, 310, 0, 60)
GameInfoFrame.Position = UDim2.new(0, 20, 0, 10)
GameInfoFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
GameInfoFrame.ZIndex = 10002
GameInfoFrame.Parent = ScriptContent

local GameInfoCorner = Instance.new("UICorner")
GameInfoCorner.CornerRadius = UDim.new(0, 6)
GameInfoCorner.Parent = GameInfoFrame

local GameInfoLabel = Instance.new("TextLabel")
GameInfoLabel.Size = UDim2.new(1, 0, 0, 20)
GameInfoLabel.Position = UDim2.new(0, 0, 0, 0)
GameInfoLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
GameInfoLabel.Text = "Info Game"
GameInfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
GameInfoLabel.Font = Enum.Font.Gotham
GameInfoLabel.TextSize = 14
GameInfoLabel.ZIndex = 10003
GameInfoLabel.Parent = GameInfoFrame

local GameInfoLabelCorner = Instance.new("UICorner")
GameInfoLabelCorner.CornerRadius = UDim.new(0, 6)
GameInfoLabelCorner.Parent = GameInfoLabel

local GameNameLabel = Instance.new("TextLabel")
GameNameLabel.Size = UDim2.new(1, -10, 0, 20)
GameNameLabel.Position = UDim2.new(0, 5, 0, 25)
GameNameLabel.BackgroundTransparency = 1
GameNameLabel.Text = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
GameNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
GameNameLabel.Font = Enum.Font.Gotham
GameNameLabel.TextSize = 12
GameNameLabel.TextXAlignment = Enum.TextXAlignment.Left
GameNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
GameNameLabel.ZIndex = 10002
GameNameLabel.Parent = GameInfoFrame

local PlaceIdLabel = Instance.new("TextLabel")
PlaceIdLabel.Size = UDim2.new(1, -10, 0, 20)
PlaceIdLabel.Position = UDim2.new(0, 5, 0, 45)
PlaceIdLabel.BackgroundTransparency = 1
PlaceIdLabel.Text = "Place ID: " .. game.PlaceId
PlaceIdLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PlaceIdLabel.Font = Enum.Font.Gotham
PlaceIdLabel.TextSize = 11
PlaceIdLabel.TextXAlignment = Enum.TextXAlignment.Left
PlaceIdLabel.ZIndex = 10002
PlaceIdLabel.Parent = GameInfoFrame

-- Pencarian Script
local ScriptSearchFrame = Instance.new("Frame")
ScriptSearchFrame.Size = UDim2.new(0, 310, 0, 30)
ScriptSearchFrame.Position = UDim2.new(0, 20, 0, 80)
ScriptSearchFrame.BackgroundTransparency = 1
ScriptSearchFrame.ZIndex = 10002
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
ScriptSearchLabel.ZIndex = 10002
ScriptSearchLabel.Parent = ScriptSearchFrame

local ScriptSearchBox = Instance.new("TextBox")
ScriptSearchBox.Size = UDim2.new(0, 150, 1, 0)
ScriptSearchBox.Position = UDim2.new(0, 80, 0, 0)
ScriptSearchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScriptSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptSearchBox.Font = Enum.Font.Gotham
ScriptSearchBox.TextSize = 14
ScriptSearchBox.Text = ""
ScriptSearchBox.PlaceholderText = "Kata kunci script"
ScriptSearchBox.ZIndex = 10002
ScriptSearchBox.Parent = ScriptSearchFrame

local ScriptSearchCorner = Instance.new("UICorner")
ScriptSearchCorner.CornerRadius = UDim.new(0, 6)
ScriptSearchCorner.Parent = ScriptSearchBox

-- Tombol Pencarian Script
local SearchScriptButton = Instance.new("TextButton")
SearchScriptButton.Size = UDim2.new(0, 50, 1, 0)
SearchScriptButton.Position = UDim2.new(1, -50, 0, 0)
SearchScriptButton.Text = "Cari"
SearchScriptButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SearchScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchScriptButton.Font = Enum.Font.Gotham
SearchScriptButton.TextSize = 14
SearchScriptButton.ZIndex = 10002
SearchScriptButton.Parent = ScriptSearchFrame

local SearchScriptCorner = Instance.new("UICorner")
SearchScriptCorner.CornerRadius = UDim.new(0, 6)
SearchScriptCorner.Parent = SearchScriptButton

-- Filter Script
local FilterFrame = Instance.new("Frame")
FilterFrame.Size = UDim2.new(0, 310, 0, 25)
FilterFrame.Position = UDim2.new(0, 20, 0, 120)
FilterFrame.BackgroundTransparency = 1
FilterFrame.ZIndex = 10002
FilterFrame.Parent = ScriptContent

local VerifiedFilter = Instance.new("TextButton")
VerifiedFilter.Size = UDim2.new(0, 70, 1, 0)
VerifiedFilter.Position = UDim2.new(0, 0, 0, 0)
VerifiedFilter.Text = "Verified"
VerifiedFilter.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
VerifiedFilter.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifiedFilter.Font = Enum.Font.Gotham
VerifiedFilter.TextSize = 12
VerifiedFilter.ZIndex = 10002
VerifiedFilter.Parent = FilterFrame

local VerifiedFilterCorner = Instance.new("UICorner")
VerifiedFilterCorner.CornerRadius = UDim.new(0, 4)
VerifiedFilterCorner.Parent = VerifiedFilter

local FreeFilter = Instance.new("TextButton")
FreeFilter.Size = UDim2.new(0, 50, 1, 0)
FreeFilter.Position = UDim2.new(0, 75, 0, 0)
FreeFilter.Text = "Free"
FreeFilter.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
FreeFilter.TextColor3 = Color3.fromRGB(255, 255, 255)
FreeFilter.Font = Enum.Font.Gotham
FreeFilter.TextSize = 12
FreeFilter.ZIndex = 10002
FreeFilter.Parent = FilterFrame

local FreeFilterCorner = Instance.new("UICorner")
FreeFilterCorner.CornerRadius = UDim.new(0, 4)
FreeFilterCorner.Parent = FreeFilter

local UniversalFilter = Instance.new("TextButton")
UniversalFilter.Size = UDim2.new(0, 70, 1, 0)
UniversalFilter.Position = UDim2.new(0, 130, 0, 0)
UniversalFilter.Text = "Universal"
UniversalFilter.BackgroundColor3 = Color3.fromRGB(120, 0, 215)
UniversalFilter.TextColor3 = Color3.fromRGB(255, 255, 255)
UniversalFilter.Font = Enum.Font.Gotham
UniversalFilter.TextSize = 12
UniversalFilter.ZIndex = 10002
UniversalFilter.Parent = FilterFrame

local UniversalFilterCorner = Instance.new("UICorner")
UniversalFilterCorner.CornerRadius = UDim.new(0, 4)
UniversalFilterCorner.Parent = UniversalFilter

-- Status Pencarian
local SearchStatusLabel = Instance.new("TextLabel")
SearchStatusLabel.Size = UDim2.new(0, 310, 0, 20)
SearchStatusLabel.Position = UDim2.new(0, 20, 0, 150)
SearchStatusLabel.BackgroundTransparency = 1
SearchStatusLabel.Text = "Tekan 'Cari' untuk memuat script"
SearchStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SearchStatusLabel.Font = Enum.Font.Gotham
SearchStatusLabel.TextSize = 12
SearchStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
SearchStatusLabel.ZIndex = 10002
SearchStatusLabel.Parent = ScriptContent

-- Daftar Script
local ScriptListFrame = Instance.new("Frame")
ScriptListFrame.Size = UDim2.new(0, 310, 0, 230)
ScriptListFrame.Position = UDim2.new(0, 20, 0, 175)
ScriptListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ScriptListFrame.ZIndex = 10002
ScriptListFrame.Parent = ScriptContent

local ScriptListCorner = Instance.new("UICorner")
ScriptListCorner.CornerRadius = UDim.new(0, 6)
ScriptListCorner.Parent = ScriptListFrame

local ScriptListLabel = Instance.new("TextLabel")
ScriptListLabel.Size = UDim2.new(1, 0, 0, 20)
ScriptListLabel.Position = UDim2.new(0, 0, 0, 0)
ScriptListLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ScriptListLabel.Text = "Daftar Script (" .. game.PlaceId .. ")"
ScriptListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptListLabel.Font = Enum.Font.Gotham
ScriptListLabel.TextSize = 14
ScriptListLabel.ZIndex = 10003
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
ScriptListScroll.ZIndex = 10002
ScriptListScroll.Parent = ScriptListFrame

local ScriptListLayout = Instance.new("UIListLayout")
ScriptListLayout.Padding = UDim.new(0, 5)
ScriptListLayout.Parent = ScriptListScroll

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
UpButton.ZIndex = 10001
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
DownButton.ZIndex = 10001
DownButton.Parent = ScreenGui

local DownButtonCorner = Instance.new("UICorner")
DownButtonCorner.CornerRadius = UDim.new(1, 0)
DownButtonCorner.Parent = DownButton

-- Floating Ball (untuk minimized state)
local FloatingBall = Instance.new("Frame")
FloatingBall.Size = UDim2.new(0, 50, 0, 50)
FloatingBall.Position = UDim2.new(0, 20, 0, 20)
FloatingBall.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
FloatingBall.BorderSizePixel = 0
FloatingBall.Visible = false
FloatingBall.ZIndex = 10000
FloatingBall.Parent = ScreenGui

local FloatingBallCorner = Instance.new("UICorner")
FloatingBallCorner.CornerRadius = UDim.new(1, 0)
FloatingBallCorner.Parent = FloatingBall

local FloatingBallShadow = Instance.new("Frame")
FloatingBallShadow.Size = UDim2.new(1, 6, 1, 6)
FloatingBallShadow.Position = UDim2.new(0, -3, 0, -3)
FloatingBallShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FloatingBallShadow.BackgroundTransparency = 0.8
FloatingBallShadow.BorderSizePixel = 0
FloatingBallShadow.ZIndex = 9999
FloatingBallShadow.Parent = FloatingBall

local FloatingBallShadowCorner = Instance.new("UICorner")
FloatingBallShadowCorner.CornerRadius = UDim.new(1, 0)
FloatingBallShadowCorner.Parent = FloatingBallShadow

local FloatingBallIcon = Instance.new("TextLabel")
FloatingBallIcon.Size = UDim2.new(1, 0, 1, 0)
FloatingBallIcon.Position = UDim2.new(0, 0, 0, 0)
FloatingBallIcon.BackgroundTransparency = 1
FloatingBallIcon.Text = "M"
FloatingBallIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBallIcon.Font = Enum.Font.GothamBold
FloatingBallIcon.TextSize = 18
FloatingBallIcon.ZIndex = 10001
FloatingBallIcon.Parent = FloatingBall

-- Variabel untuk drag floating ball
local ballDragging = false
local ballDragInput, ballDragStart, ballStartPos

-- ==================== VARIABEL GLOBAL ====================
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

-- Variabel untuk script
local scriptBloxAPI = "https://scriptblox.com/api/script/search"
local currentScripts = {}
local filteredScripts = {}
local activeFilters = {
    verified = false,
    free = false,
    universal = false
}

-- Variabel untuk koneksi event
local playerAddedConn, playerRemovingConn, characterAddedConn

-- Variabel untuk brightness
local isBrightnessEnabled = false
local originalBrightness = Lighting.Brightness
local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalFogEnd = Lighting.FogEnd

-- ==================== FUNGSI UTAMA ====================
-- Fungsi untuk mengupdate posisi window
local function update(input)
    local delta = input.Position - dragStart
    MainWindow.Position = UDim2.new(
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
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    
    UpButton.Visible = false
    DownButton.Visible = false
    
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

-- Fungsi untuk membersihkan brightness
local function cleanUpBrightness()
    if isBrightnessEnabled then
        toggleBrightness()
    end
end

-- Fungsi toggle brightness
local function toggleBrightness()
    if isBrightnessEnabled then
        Lighting.Brightness = originalBrightness
        Lighting.Ambient = originalAmbient
        Lighting.OutdoorAmbient = originalOutdoorAmbient
        Lighting.FogEnd = originalFogEnd
        
        isBrightnessEnabled = false
        
        TweenService:Create(
            BrightnessToggle,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(200, 200, 200)}
        ):Play()
        TweenService:Create(
            BrightnessSwitch,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
        ):Play()
    else
        originalBrightness = Lighting.Brightness
        originalAmbient = Lighting.Ambient
        originalOutdoorAmbient = Lighting.OutdoorAmbient
        originalFogEnd = Lighting.FogEnd
        
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
        Lighting.FogEnd = 100000
        
        isBrightnessEnabled = true
        
        TweenService:Create(
            BrightnessToggle,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 27, 0, 2), BackgroundColor3 = Color3.fromRGB(0, 200, 0)}
        ):Play()
        TweenService:Create(
            BrightnessSwitch,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 0)}
        ):Play()
    end
end

-- ==================== FUNGSI ESP ====================
local function createESP(partData)
    if not partData or not partData.Object or not partData.Object.Parent then
        return false
    end
    
    local part = partData.Object
    
    if espHighlights[part] then
        espHighlights[part]:Destroy()
        espHighlights[part] = nil
    end
    
    if espConnections[part] then
        espConnections[part]:Disconnect()
        espConnections[part] = nil
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "MilkyESP_" .. part.Name
    highlight.Adornee = part
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = game.CoreGui
    
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
    
    espHighlights[part] = highlight
    espHighlights[part .. "_billboard"] = billboard
    
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

-- ==================== FUNGSI SCRIPT BLOX ====================
local function searchScripts(query, filters)
    SearchStatusLabel.Text = "Mencari script..."
    SearchStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    local url = scriptBloxAPI .. "?q=" .. query .. "&max=20"
    
    if filters.verified then
        url = url .. "&verified=1"
    end
    if filters.free then
        url = url .. "&mode=free"
    end
    if filters.universal then
        url = url .. "&universal=1"
    end
    
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        local data = game:GetService("HttpService"):JSONDecode(result)
        currentScripts = {}
        
        if data and data.result and data.result.scripts then
            for _, script in ipairs(data.result.scripts) do
                table.insert(currentScripts, {
                    title = script.title or "No Title",
                    game = script.game and script.game.name or "Unknown Game",
                    script = script.script or "",
                    verified = script.verified or false,
                    key = script.key or false,
                    isUniversal = script.isUniversal or false,
                    isPatched = script.isPatched or false,
                    likeCount = script.likeCount or 0,
                    dislikeCount = script.dislikeCount or 0,
                    views = script.views or 0
                })
            end
            
            SearchStatusLabel.Text = "Ditemukan " .. #currentScripts .. " script"
            SearchStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            return true
        else
            SearchStatusLabel.Text = "Tidak ada script ditemukan"
            SearchStatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end
    else
        SearchStatusLabel.Text = "Error: Gagal mengambil data"
        SearchStatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        return false
    end
end

local function executeScript(scriptCode, scriptTitle)
    if scriptCode and scriptCode ~= "" then
        cleanUpFly()
        cleanUpFloat()
        cleanUpHead()
        cleanUpAllESP()
        cleanUpBrightness()
        
        local success, errorMessage = pcall(function()
            loadstring(scriptCode)()
        end)
        
        if success then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Script Executed",
                Text = "Script '" .. scriptTitle .. "' berhasil dijalankan",
                Duration = 5
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Script Error",
                Text = "Gagal menjalankan script: " .. errorMessage,
                Duration = 5
            })
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script Error",
            Text = "Script code kosong",
            Duration = 5
        })
    end
end

local function updateScriptList()
    for _, child in ipairs(ScriptListScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local contentHeight = 0
    
    for _, scriptData in ipairs(currentScripts) do
        local scriptItem = Instance.new("Frame")
        scriptItem.Size = UDim2.new(1, 0, 0, 80)
        scriptItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        scriptItem.ZIndex = 10002
        scriptItem.Parent = ScriptListScroll
        
        local scriptItemCorner = Instance.new("UICorner")
        scriptItemCorner.CornerRadius = UDim.new(0, 4)
        scriptItemCorner.Parent = scriptItem
        
        local scriptTitle = Instance.new("TextLabel")
        scriptTitle.Size = UDim2.new(1, -10, 0, 20)
        scriptTitle.Position = UDim2.new(0, 5, 0, 0)
        scriptTitle.BackgroundTransparency = 1
        scriptTitle.Text = scriptData.title
        scriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        scriptTitle.Font = Enum.Font.GothamBold
        scriptTitle.TextSize = 12
        scriptTitle.TextXAlignment = Enum.TextXAlignment.Left
        scriptTitle.TextTruncate = Enum.TextTruncate.AtEnd
        scriptTitle.ZIndex = 10002
        scriptTitle.Parent = scriptItem
        
        local scriptInfo = Instance.new("TextLabel")
        scriptInfo.Size = UDim2.new(1, -10, 0, 15)
        scriptInfo.Position = UDim2.new(0, 5, 0, 20)
        scriptInfo.BackgroundTransparency = 1
        scriptInfo.Text = "Game: " .. scriptData.game
        scriptInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
        scriptInfo.Font = Enum.Font.Gotham
        scriptInfo.TextSize = 10
        scriptInfo.TextXAlignment = Enum.TextXAlignment.Left
        scriptInfo.TextTruncate = Enum.TextTruncate.AtEnd
        scriptInfo.ZIndex = 10002
        scriptInfo.Parent = scriptItem
        
        local scriptStatus = Instance.new("TextLabel")
        scriptStatus.Size = UDim2.new(1, -10, 0, 15)
        scriptStatus.Position = UDim2.new(0, 5, 0, 35)
        scriptStatus.BackgroundTransparency = 1
        
        local statusText = ""
        if scriptData.verified then
            statusText = statusText .. "✓ "
        end
        if not scriptData.key then
            statusText = statusText .. "Free "
        end
        if scriptData.isUniversal then
            statusText = statusText .. "Universal "
        end
        if scriptData.isPatched then
            statusText = statusText .. "⚠ Patched "
        end
        
        scriptStatus.Text = statusText ~= "" and statusText or "No info"
        scriptStatus.TextColor3 = scriptData.isPatched and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 255, 100)
        scriptStatus.Font = Enum.Font.Gotham
        scriptStatus.TextSize = 10
        scriptStatus.TextXAlignment = Enum.TextXAlignment.Left
        scriptStatus.ZIndex = 10002
        scriptStatus.Parent = scriptItem
        
        local scriptStats = Instance.new("TextLabel")
        scriptStats.Size = UDim2.new(1, -10, 0, 15)
        scriptStats.Position = UDim2.new(0, 5, 0, 50)
        scriptStats.BackgroundTransparency = 1
        scriptStats.Text = "👍 " .. scriptData.likeCount .. " | 👁 " .. scriptData.views
        scriptStats.TextColor3 = Color3.fromRGB(150, 150, 150)
        scriptStats.Font = Enum.Font.Gotham
        scriptStats.TextSize = 10
        scriptStats.TextXAlignment = Enum.TextXAlignment.Left
        scriptStats.ZIndex = 10002
        scriptStats.Parent = scriptItem
        
        local executeButton = Instance.new("TextButton")
        executeButton.Size = UDim2.new(0, 60, 0, 25)
        executeButton.Position = UDim2.new(1, -65, 0, 5)
        executeButton.Text = "Execute"
        executeButton.BackgroundColor3 = scriptData.isPatched and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(0, 180, 0)
        executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        executeButton.Font = Enum.Font.Gotham
        executeButton.TextSize = 11
        executeButton.ZIndex = 10002
        executeButton.Parent = scriptItem
        
        local executeButtonCorner = Instance.new("UICorner")
        executeButtonCorner.CornerRadius = UDim.new(0, 4)
        executeButtonCorner.Parent = executeButton
        
        if scriptData.isPatched then
            executeButton.Active = false
            executeButton.Text = "Patched"
        end
        
        executeButton.MouseButton1Click:Connect(function()
            if not scriptData.isPatched then
                executeButton.Text = "Executing..."
                executeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
                
                executeScript(scriptData.script, scriptData.title)
                
                wait(2)
                if executeButton then
                    executeButton.Text = "Execute"
                    executeButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                end
            end
        end)
        
        if not scriptData.isPatched then
            executeButton.MouseEnter:Connect(function()
                TweenService:Create(
                    executeButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
                ):Play()
            end)
            
            executeButton.MouseLeave:Connect(function()
                TweenService:Create(
                    executeButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(0, 180, 0)}
                ):Play()
            end)
        end
        
        contentHeight = contentHeight + 85
    end
    
    ScriptListScroll.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

-- ==================== FUNGSI PARTS ====================
local function isPartInteractable(part)
    if part:IsDescendantOf(LocalPlayer.Character) then
        return false
    end
    
    if part:IsDescendantOf(workspace.Terrain) then
        return false
    end
    
    if part:FindFirstChildWhichIsA("ClickDetector") then
        return true
    end
    
    if part:FindFirstChildWhichIsA("ProximityPrompt") then
        return true
    end
    
    if part:FindFirstChildWhichIsA("TouchTransmitter") then
        return true
    end
    
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
    
    return false
end

local function collectInteractableParts()
    allParts = {}
    filteredParts = {}
    
    local function scanModel(model)
        for _, child in ipairs(model:GetChildren()) do
            if child:IsA("BasePart") then
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
                if not child:IsDescendantOf(LocalPlayer.Character) then
                    scanModel(child)
                end
            end
        end
    end
    
    scanModel(workspace)
    
    for i, part in ipairs(allParts) do
        filteredParts[i] = part
    end
    
    return #allParts
end

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
        partItem.ZIndex = 10002
        partItem.Parent = PartsListScroll
        
        local partItemCorner = Instance.new("UICorner")
        partItemCorner.CornerRadius = UDim.new(0, 4)
        partItemCorner.Parent = partItem
        
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
        partName.ZIndex = 10002
        partName.Parent = partItem
        
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
        partParent.ZIndex = 10002
        partParent.Parent = partItem
        
        local partInfo = Instance.new("TextLabel")
        partInfo.Size = UDim2.new(0.7, 0, 0.34, 0)
        partInfo.Position = UDim2.new(0, 5, 0.66, 0)
        partInfo.BackgroundTransparency = 1
        partInfo.Text = partData.Material .. " | Collide: " .. tostring(partData.CanCollide)
        partInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
        partInfo.Font = Enum.Font.Gotham
        partInfo.TextSize = 9
        partInfo.TextXAlignment = Enum.TextXAlignment.Left
        partInfo.ZIndex = 10002
        partInfo.Parent = partItem
        
        local buttonContainer = Instance.new("Frame")
        buttonContainer.Size = UDim2.new(0.3, 0, 1, 0)
        buttonContainer.Position = UDim2.new(0.7, 0, 0, 0)
        buttonContainer.BackgroundTransparency = 1
        buttonContainer.ZIndex = 10002
        buttonContainer.Parent = partItem

        local tweenButton = Instance.new("TextButton")
        tweenButton.Size = UDim2.new(0.45, 0, 0.4, 0)
        tweenButton.Position = UDim2.new(0.05, 0, 0.1, 0)
        tweenButton.Text = "Tween"
        tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        tweenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tweenButton.Font = Enum.Font.Gotham
        tweenButton.TextSize = 10
        tweenButton.ZIndex = 10002
        tweenButton.Parent = buttonContainer
        
        local tweenButtonCorner = Instance.new("UICorner")
        tweenButtonCorner.CornerRadius = UDim.new(0, 4)
        tweenButtonCorner.Parent = tweenButton
        
        local espButton = Instance.new("TextButton")
        espButton.Size = UDim2.new(0.45, 0, 0.4, 0)
        espButton.Position = UDim2.new(0.5, 0, 0.1, 0)
        espButton.Text = "ESP"
        espButton.BackgroundColor3 = Color3.fromRGB(200, 120, 0)
        espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        espButton.Font = Enum.Font.Gotham
        espButton.TextSize = 10
        espButton.ZIndex = 10002
        espButton.Parent = buttonContainer
        
        local espButtonCorner = Instance.new("UICorner")
        espButtonCorner.CornerRadius = UDim.new(0, 4)
        espButtonCorner.Parent = espButton
        
        if espHighlights[partData.Object] then
            espButton.Text = "Un ESP"
            espButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        end
        
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
                if rootPart and partData.Object and partData.Object.Parent then
                    local targetPosition = partData.Position
                    local tweenInfo = TweenInfo.new(
                        (rootPart.Position - targetPosition).Magnitude / 50,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out
                    )
                    
                    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))})
                    tween:Play()
                    
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
        
        espButton.MouseButton1Click:Connect(function()
            if espButton.Text == "ESP" then
                if createESP(partData) then
                    espButton.Text = "Un ESP"
                    espButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                end
            else
                if removeESP(partData) then
                    espButton.Text = "ESP"
                    espButton.BackgroundColor3 = Color3.fromRGB(200, 120, 0)
                end
            end
        end)
        
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

local function loadAndDisplayParts()
    local totalParts = collectInteractableParts()
    local displayedParts = filterParts(PartsSearchBox.Text)
    
    PartsInfoLabel.Text = "Parts Interaktif: " .. totalParts .. " | Ditampilkan: " .. displayedParts
    updatePartsList()
end

-- ==================== FUNGSI LAINNYA ====================
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
            playerItem.ZIndex = 10002
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
            playerName.ZIndex = 10002
            playerName.Parent = playerItem
            
            local headButton = Instance.new("TextButton")
            headButton.Size = UDim2.new(0.25, 0, 0.7, 0)
            headButton.Position = UDim2.new(0.4, 0, 0.15, 0)
            headButton.Text = headingPlayer == player and "Unhead" or "Head"
            headButton.BackgroundColor3 = headingPlayer == player and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 120, 215)
            headButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            headButton.Font = Enum.Font.Gotham
            headButton.TextSize = 12
            headButton.ZIndex = 10002
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
            tweenButton.ZIndex = 10002
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
        waypointItem.ZIndex = 10002
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
        waypointName.ZIndex = 10002
        waypointName.Parent = waypointItem
        
        local tweenButton = Instance.new("TextButton")
        tweenButton.Size = UDim2.new(0.35, 0, 0.7, 0)
        tweenButton.Position = UDim2.new(0.62, 0, 0.15, 0)
        tweenButton.Text = "Tween"
        tweenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        tweenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tweenButton.Font = Enum.Font.Gotham
        tweenButton.TextSize = 12
        tweenButton.ZIndex = 10002
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

-- ==================== FUNGSI WINDOW CONTROLS ====================
local function minimizeWindow()
    -- Simpan posisi terakhir window sebelum minimize
    local lastWindowPosition = MainWindow.Position
    
    -- Sembunyikan main window dengan animasi
    TweenService:Create(
        MainWindow,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    ):Play()
    
    wait(0.3)
    MainWindow.Visible = false
    ContentArea.Visible = false
    
    -- Tampilkan floating ball di posisi yang sesuai
    FloatingBall.Visible = true
    FloatingBall.Position = UDim2.new(
        lastWindowPosition.X.Scale, 
        math.clamp(lastWindowPosition.X.Offset, 0, workspace.CurrentCamera.ViewportSize.X - 50),
        lastWindowPosition.Y.Scale, 
        math.clamp(lastWindowPosition.Y.Offset, 0, workspace.CurrentCamera.ViewportSize.Y - 50)
    )
    
    -- Animasi muncul floating ball
    FloatingBall.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(
        FloatingBall,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 50, 0, 50)}
    ):Play()
    
    MinimizeButton.Text = "+"
end

local function restoreWindow()
    -- Sembunyikan floating ball dengan animasi
    TweenService:Create(
        FloatingBall,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    ):Play()
    
    wait(0.2)
    FloatingBall.Visible = false
    
    -- Tampilkan main window dengan animasi
    MainWindow.Visible = true
    MainWindow.Size = UDim2.new(0, 0, 0, 0)
    MainWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(
        MainWindow,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 350, 0, 450), Position = UDim2.new(0.1, 0, 0.1, 0)}
    ):Play()
    
    ContentArea.Visible = true
    MinimizeButton.Text = "_"
end

local function restoreWindowFromBall()
    restoreWindow()
end

-- ==================== FUNGSI POPUP KONFIRMASI ====================
local function showConfirmPopup()
    ConfirmPopup.Visible = true
    ConfirmPopup.Size = UDim2.new(0, 0, 0, 0)
    ConfirmPopup.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(
        ConfirmPopup,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 300, 0, 150), Position = UDim2.new(0.5, -150, 0.5, -75)}
    ):Play()
end

local function hideConfirmPopup()
    TweenService:Create(
        ConfirmPopup,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    ):Play()
    
    wait(0.2)
    ConfirmPopup.Visible = false
end

-- ==================== FUNGSI DESTROY SCRIPT ====================
local function destroyScript()
    cleanUpFly()
    cleanUpFloat()
    cleanUpHead()
    cleanUpAllESP()
    cleanUpBrightness()
    
    if playerAddedConn then
        playerAddedConn:Disconnect()
    end
    
    if playerRemovingConn then
        playerRemovingConn:Disconnect()
    end
    
    if characterAddedConn then
        characterAddedConn:Disconnect()
    end
    
    -- Hapus floating ball juga
    if FloatingBall then
        FloatingBall:Destroy()
    end
    
    if ScreenGui then
        ScreenGui:Destroy()
    end
end
-- ==================== FUNGSI RIBBON SWITCHING ====================
local function switchRibbon(ribbonName)
    UtamaContent.Visible = false
    TweenContent.Visible = false
    PartsContent.Visible = false
    ScriptContent.Visible = false
    
    UtamaRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    UtamaRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    ScriptRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ScriptRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    if ribbonName == "Utama" then
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        UtamaRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        UtamaContent.Visible = true
        updatePlayerList()
    elseif ribbonName == "Tween" then
        TweenRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        TweenRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        TweenContent.Visible = true
        updateWaypointList()
    elseif ribbonName == "Parts" then
        PartsRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        PartsRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        PartsContent.Visible = true
        
        if #allParts == 0 then
            loadAndDisplayParts()
        else
            local displayedParts = filterParts(PartsSearchBox.Text)
            PartsInfoLabel.Text = "Parts Interaktif: " .. #allParts .. " | Ditampilkan: " .. displayedParts
            updatePartsList()
        end
    else
        ScriptRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        ScriptRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        ScriptContent.Visible = true
        
        if #currentScripts == 0 then
            local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
            ScriptSearchBox.Text = gameName
            spawn(function()
                if searchScripts(gameName, activeFilters) then
                    updateScriptList()
                end
            end)
        end
    end
end

-- ==================== FUNGSI FLY ====================
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

-- ==================== FUNGSI FLOAT ====================
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

-- ==================== FUNGSI WALKSPEED ====================
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

-- ==================== EVENT HANDLERS ====================
-- Drag functionality
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainWindow.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Window controls
MinimizeButton.MouseButton1Click:Connect(function()
    if ContentArea.Visible then
        minimizeWindow()
    else
        restoreWindow()
    end
end)

CloseButton.MouseButton1Click:Connect(showConfirmPopup)

-- Konfirmasi popup
ConfirmYesButton.MouseButton1Click:Connect(function()
    hideConfirmPopup()
    destroyScript()
end)

ConfirmNoButton.MouseButton1Click:Connect(function()
    hideConfirmPopup()
end)

-- Ribbon switching
UtamaRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Utama")
end)

TweenRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Tween")
end)

PartsRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Parts")
end)

ScriptRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Script")
end)

-- Switch functionality
FlySwitch.MouseButton1Click:Connect(toggleFly)
FloatSwitch.MouseButton1Click:Connect(toggleFloat)
BrightnessSwitch.MouseButton1Click:Connect(toggleBrightness)

-- WalkSpeed functionality
SetWalkSpeedButton.MouseButton1Click:Connect(setWalkSpeed)

WalkSpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        setWalkSpeed()
    end
end)

-- Waypoint functionality
SetWaypointButton.MouseButton1Click:Connect(setWaypoint)

WaypointBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        setWaypoint()
    end
end)

-- Parts functionality
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

-- Script functionality
SearchScriptButton.MouseButton1Click:Connect(function()
    local searchQuery = ScriptSearchBox.Text
    if searchQuery == "" then
        searchQuery = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end
    
    if searchScripts(searchQuery, activeFilters) then
        updateScriptList()
        
        TweenService:Create(
            SearchScriptButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
        ):Play()
    else
        TweenService:Create(
            SearchScriptButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(150, 0, 0)}
        ):Play()
    end
    
    wait(0.3)
    TweenService:Create(
        SearchScriptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

ScriptSearchBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SearchScriptButton.MouseButton1Click:Wait()
    end
end)

-- Filter functionality
VerifiedFilter.MouseButton1Click:Connect(function()
    activeFilters.verified = not activeFilters.verified
    if activeFilters.verified then
        TweenService:Create(
            VerifiedFilter,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}
        ):Play()
    else
        TweenService:Create(
            VerifiedFilter,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
        ):Play()
    end
end)

FreeFilter.MouseButton1Click:Connect(function()
    activeFilters.free = not activeFilters.free
    if activeFilters.free then
        TweenService:Create(
            FreeFilter,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
        ):Play()
    else
        TweenService:Create(
            FreeFilter,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
        ):Play()
    end
end)

UniversalFilter.MouseButton1Click:Connect(function()
    activeFilters.universal = not activeFilters.universal
    if activeFilters.universal then
        TweenService:Create(
            UniversalFilter,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(140, 0, 255)}
        ):Play()
    else
        TweenService:Create(
            UniversalFilter,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(120, 0, 215)}
        ):Play()
    end
end)

-- Mobile controls
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

-- Player events
playerAddedConn = Players.PlayerAdded:Connect(updatePlayerList)
playerRemovingConn = Players.PlayerRemoving:Connect(updatePlayerList)

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        cleanUpFly()
        cleanUpFloat()
        cleanUpHead()
        updatePlayerList()
    end)
end

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

characterAddedConn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Hover effects
MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(
        MinimizeButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}
    ):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(
        MinimizeButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
    ):Play()
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}
    ):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(220, 60, 60)}
    ):Play()
end)

-- Ribbon hover effects
local function setupRibbonHover(ribbon)
    ribbon.MouseEnter:Connect(function()
        if ribbon.BackgroundColor3 ~= Color3.fromRGB(0, 120, 215) then
            TweenService:Create(
                ribbon,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
            ):Play()
        end
    end)
    
    ribbon.MouseLeave:Connect(function()
        if ribbon.BackgroundColor3 ~= Color3.fromRGB(0, 120, 215) then
            TweenService:Create(
                ribbon,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
            ):Play()
        end
    end)
end

setupRibbonHover(UtamaRibbon)
setupRibbonHover(TweenRibbon)
setupRibbonHover(PartsRibbon)
setupRibbonHover(ScriptRibbon)

-- Switch hover effects
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
setupSwitchHover(BrightnessSwitch, BrightnessToggle)

-- Button hover effects
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

SearchScriptButton.MouseEnter:Connect(function()
    TweenService:Create(
        SearchScriptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

SearchScriptButton.MouseLeave:Connect(function()
    TweenService:Create(
        SearchScriptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Filter hover effects
VerifiedFilter.MouseEnter:Connect(function()
    TweenService:Create(
        VerifiedFilter,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = activeFilters.verified and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(0, 130, 0)}
    ):Play()
end)

VerifiedFilter.MouseLeave:Connect(function()
    TweenService:Create(
        VerifiedFilter,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = activeFilters.verified and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 0)}
    ):Play()
end)

FreeFilter.MouseEnter:Connect(function()
    TweenService:Create(
        FreeFilter,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = activeFilters.free and Color3.fromRGB(0, 80, 160) or Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

FreeFilter.MouseLeave:Connect(function()
    TweenService:Create(
        FreeFilter,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = activeFilters.free and Color3.fromRGB(0, 100, 180) or Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

UniversalFilter.MouseEnter:Connect(function()
    TweenService:Create(
        UniversalFilter,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = activeFilters.universal and Color3.fromRGB(160, 0, 235) or Color3.fromRGB(140, 0, 255)}
    ):Play()
end)

UniversalFilter.MouseLeave:Connect(function()
    TweenService:Create(
        UniversalFilter,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = activeFilters.universal and Color3.fromRGB(140, 0, 255) or Color3.fromRGB(120, 0, 215)}
    ):Play()
end)

-- Drag functionality untuk floating ball
FloatingBall.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        ballDragging = true
        ballDragStart = input.Position
        ballStartPos = FloatingBall.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                ballDragging = false
            end
        end)
    end
end)

FloatingBall.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        ballDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == ballDragInput and ballDragging then
        local delta = input.Position - ballDragStart
        FloatingBall.Position = UDim2.new(
            ballStartPos.X.Scale, 
            ballStartPos.X.Offset + delta.X, 
            ballStartPos.Y.Scale, 
            ballStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Klik floating ball untuk restore window
FloatingBall.MouseButton1Click:Connect(function()
    if not ballDragging then
        restoreWindowFromBall()
    end
end)

-- Double click detection untuk floating ball
local lastBallClickTime = 0
FloatingBall.MouseButton1Click:Connect(function()
    local currentTime = tick()
    if currentTime - lastBallClickTime < 0.3 then
        restoreWindowFromBall()
    end
    lastBallClickTime = currentTime
end)

-- Hover effects untuk floating ball
FloatingBall.MouseEnter:Connect(function()
    TweenService:Create(
        FloatingBall,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
    ):Play()
end)

FloatingBall.MouseLeave:Connect(function()
    TweenService:Create(
        FloatingBall,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

-- Notifikasi awal
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Milky Windows Menu Loaded",
    Text = "Jendela Windows-like telah dimuat! Drag title bar untuk memindahkan.",
    Duration = 5
})

-- Pastikan cleanup saat game ditutup
game:BindToClose(function()
    destroyScript()
end)
