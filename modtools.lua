-- Floating Menu Currency Editor dengan GUI Milky Style
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

-- Main GUI dengan ZIndex tinggi agar tampil di atas UI lain
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CurrencyEditor_" .. HttpService:GenerateGUID(false):sub(1, 8)
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 9999

-- Floating Button (Lingkaran) dengan ZIndex tinggi
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 100, 0, 100)
FloatingButton.Text = "💰"
FloatingButton.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
FloatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.TextSize = 20
FloatingButton.AutoButtonColor = false
FloatingButton.Active = true
FloatingButton.Draggable = false
FloatingButton.Selectable = false
FloatingButton.ZIndex = 10000
FloatingButton.Parent = ScreenGui

-- Membuat bentuk lingkaran
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = FloatingButton

-- ==================== POPUP KONFIRMASI ====================
local ConfirmPopup = Instance.new("Frame")
ConfirmPopup.Size = UDim2.new(0, 300, 0, 150)
ConfirmPopup.Position = UDim2.new(0.5, -150, 0.5, -75)
ConfirmPopup.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ConfirmPopup.BorderSizePixel = 0
ConfirmPopup.Visible = false
ConfirmPopup.ZIndex = 10010
ConfirmPopup.Parent = ScreenGui

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 12)
ConfirmCorner.Parent = ConfirmPopup

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
ConfirmTitleCorner.CornerRadius = UDim.new(0, 12)
ConfirmTitleCorner.Parent = ConfirmTitle

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

-- ==================== MAIN POPUP WINDOW ====================
local PopupFrame = Instance.new("Frame")
PopupFrame.Size = UDim2.new(0, 350, 0, 500)
PopupFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
PopupFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PopupFrame.BorderSizePixel = 0
PopupFrame.Visible = false
PopupFrame.ZIndex = 10000
PopupFrame.Parent = ScreenGui

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 12)
PopupCorner.Parent = PopupFrame

-- Header
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 40)
HeaderFrame.Position = UDim2.new(0, 0, 0, 0)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
HeaderFrame.BorderSizePixel = 0
HeaderFrame.ZIndex = 10001
HeaderFrame.Parent = PopupFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = HeaderFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "💰 Currency Editor"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 10002
TitleLabel.Parent = HeaderFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 7)
CloseButton.Text = "×"
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.ZIndex = 10003
CloseButton.Parent = PopupFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Content Area
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 10001
ContentFrame.Parent = PopupFrame

-- ==================== CURRENCY DETECTION SECTION ====================
local DetectionFrame = Instance.new("Frame")
DetectionFrame.Size = UDim2.new(1, -20, 0, 120)
DetectionFrame.Position = UDim2.new(0, 10, 0, 10)
DetectionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DetectionFrame.ZIndex = 10002
DetectionFrame.Parent = ContentFrame

local DetectionCorner = Instance.new("UICorner")
DetectionCorner.CornerRadius = UDim.new(0, 6)
DetectionCorner.Parent = DetectionFrame

local DetectionLabel = Instance.new("TextLabel")
DetectionLabel.Size = UDim2.new(1, 0, 0, 25)
DetectionLabel.Position = UDim2.new(0, 0, 0, 0)
DetectionLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
DetectionLabel.Text = "Deteksi Currency Otomatis"
DetectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DetectionLabel.Font = Enum.Font.GothamBold
DetectionLabel.TextSize = 14
DetectionLabel.ZIndex = 10003
DetectionLabel.Parent = DetectionFrame

local DetectionLabelCorner = Instance.new("UICorner")
DetectionLabelCorner.CornerRadius = UDim.new(0, 6)
DetectionLabelCorner.Parent = DetectionLabel

local AutoDetectButton = Instance.new("TextButton")
AutoDetectButton.Size = UDim2.new(0, 120, 0, 30)
AutoDetectButton.Position = UDim2.new(0.5, -60, 0, 35)
AutoDetectButton.Text = "🔍 Deteksi Otomatis"
AutoDetectButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
AutoDetectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDetectButton.Font = Enum.Font.Gotham
AutoDetectButton.TextSize = 12
AutoDetectButton.ZIndex = 10002
AutoDetectButton.Parent = DetectionFrame

local AutoDetectCorner = Instance.new("UICorner")
AutoDetectCorner.CornerRadius = UDim.new(0, 6)
AutoDetectCorner.Parent = AutoDetectButton

local DetectionStatus = Instance.new("TextLabel")
DetectionStatus.Size = UDim2.new(1, -10, 0, 40)
DetectionStatus.Position = UDim2.new(0, 5, 0, 75)
DetectionStatus.BackgroundTransparency = 1
DetectionStatus.Text = "Tekan tombol untuk memindai currency"
DetectionStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
DetectionStatus.Font = Enum.Font.Gotham
DetectionStatus.TextSize = 11
DetectionStatus.TextWrapped = true
DetectionStatus.TextXAlignment = Enum.TextXAlignment.Left
DetectionStatus.ZIndex = 10002
DetectionStatus.Parent = DetectionFrame

-- ==================== MANUAL CURRENCY INPUT ====================
local ManualFrame = Instance.new("Frame")
ManualFrame.Size = UDim2.new(1, -20, 0, 150)
ManualFrame.Position = UDim2.new(0, 10, 0, 140)
ManualFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ManualFrame.ZIndex = 10002
ManualFrame.Parent = ContentFrame

local ManualCorner = Instance.new("UICorner")
ManualCorner.CornerRadius = UDim.new(0, 6)
ManualCorner.Parent = ManualFrame

local ManualLabel = Instance.new("TextLabel")
ManualLabel.Size = UDim2.new(1, 0, 0, 25)
ManualLabel.Position = UDim2.new(0, 0, 0, 0)
ManualLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ManualLabel.Text = "Input Manual Currency"
ManualLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ManualLabel.Font = Enum.Font.GothamBold
ManualLabel.TextSize = 14
ManualLabel.ZIndex = 10003
ManualLabel.Parent = ManualFrame

local ManualLabelCorner = Instance.new("UICorner")
ManualLabelCorner.CornerRadius = UDim.new(0, 6)
ManualLabelCorner.Parent = ManualLabel

-- Currency Name Input
local CurrencyNameFrame = Instance.new("Frame")
CurrencyNameFrame.Size = UDim2.new(1, -20, 0, 30)
CurrencyNameFrame.Position = UDim2.new(0, 10, 0, 35)
CurrencyNameFrame.BackgroundTransparency = 1
CurrencyNameFrame.ZIndex = 10002
CurrencyNameFrame.Parent = ManualFrame

local CurrencyNameLabel = Instance.new("TextLabel")
CurrencyNameLabel.Size = UDim2.new(0, 100, 1, 0)
CurrencyNameLabel.Position = UDim2.new(0, 0, 0, 0)
CurrencyNameLabel.BackgroundTransparency = 1
CurrencyNameLabel.Text = "Nama Currency:"
CurrencyNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrencyNameLabel.Font = Enum.Font.Gotham
CurrencyNameLabel.TextSize = 12
CurrencyNameLabel.TextXAlignment = Enum.TextXAlignment.Left
CurrencyNameLabel.ZIndex = 10002
CurrencyNameLabel.Parent = CurrencyNameFrame

local CurrencyNameBox = Instance.new("TextBox")
CurrencyNameBox.Size = UDim2.new(0, 200, 1, 0)
CurrencyNameBox.Position = UDim2.new(0, 105, 0, 0)
CurrencyNameBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CurrencyNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrencyNameBox.Font = Enum.Font.Gotham
CurrencyNameBox.TextSize = 12
CurrencyNameBox.PlaceholderText = "Contoh: Coins, Gold, Money"
CurrencyNameBox.ZIndex = 10002
CurrencyNameBox.Parent = CurrencyNameFrame

local CurrencyNameCorner = Instance.new("UICorner")
CurrencyNameCorner.CornerRadius = UDim.new(0, 4)
CurrencyNameCorner.Parent = CurrencyNameBox

-- Currency Value Input
local CurrencyValueFrame = Instance.new("Frame")
CurrencyValueFrame.Size = UDim2.new(1, -20, 0, 30)
CurrencyValueFrame.Position = UDim2.new(0, 10, 0, 75)
CurrencyValueFrame.BackgroundTransparency = 1
CurrencyValueFrame.ZIndex = 10002
CurrencyValueFrame.Parent = ManualFrame

local CurrencyValueLabel = Instance.new("TextLabel")
CurrencyValueLabel.Size = UDim2.new(0, 100, 1, 0)
CurrencyValueLabel.Position = UDim2.new(0, 0, 0, 0)
CurrencyValueLabel.BackgroundTransparency = 1
CurrencyValueLabel.Text = "Nilai Baru:"
CurrencyValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrencyValueLabel.Font = Enum.Font.Gotham
CurrencyValueLabel.TextSize = 12
CurrencyValueLabel.TextXAlignment = Enum.TextXAlignment.Left
CurrencyValueLabel.ZIndex = 10002
CurrencyValueLabel.Parent = CurrencyValueFrame

local CurrencyValueBox = Instance.new("TextBox")
CurrencyValueBox.Size = UDim2.new(0, 120, 1, 0)
CurrencyValueBox.Position = UDim2.new(0, 105, 0, 0)
CurrencyValueBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CurrencyValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrencyValueBox.Font = Enum.Font.Gotham
CurrencyValueBox.TextSize = 12
CurrencyValueBox.PlaceholderText = "999999"
CurrencyValueBox.ZIndex = 10002
CurrencyValueBox.Parent = CurrencyValueFrame

local CurrencyValueCorner = Instance.new("UICorner")
CurrencyValueCorner.CornerRadius = UDim.new(0, 4)
CurrencyValueCorner.Parent = CurrencyValueBox

local SetCurrencyButton = Instance.new("TextButton")
SetCurrencyButton.Size = UDim2.new(0, 60, 1, 0)
SetCurrencyButton.Position = UDim2.new(1, -60, 0, 0)
SetCurrencyButton.Text = "Set"
SetCurrencyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
SetCurrencyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SetCurrencyButton.Font = Enum.Font.GothamBold
SetCurrencyButton.TextSize = 12
SetCurrencyButton.ZIndex = 10002
SetCurrencyButton.Parent = CurrencyValueFrame

local SetCurrencyCorner = Instance.new("UICorner")
SetCurrencyCorner.CornerRadius = UDim.new(0, 4)
SetCurrencyCorner.Parent = SetCurrencyButton

-- ==================== QUICK PRESETS ====================
local PresetsFrame = Instance.new("Frame")
PresetsFrame.Size = UDim2.new(1, -20, 0, 80)
PresetsFrame.Position = UDim2.new(0, 10, 0, 300)
PresetsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PresetsFrame.ZIndex = 10002
PresetsFrame.Parent = ContentFrame

local PresetsCorner = Instance.new("UICorner")
PresetsCorner.CornerRadius = UDim.new(0, 6)
PresetsCorner.Parent = PresetsFrame

local PresetsLabel = Instance.new("TextLabel")
PresetsLabel.Size = UDim2.new(1, 0, 0, 25)
PresetsLabel.Position = UDim2.new(0, 0, 0, 0)
PresetsLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PresetsLabel.Text = "Preset Cepat"
PresetsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PresetsLabel.Font = Enum.Font.GothamBold
PresetsLabel.TextSize = 14
PresetsLabel.ZIndex = 10003
PresetsLabel.Parent = PresetsFrame

local PresetsLabelCorner = Instance.new("UICorner")
PresetsLabelCorner.CornerRadius = UDim.new(0, 6)
PresetsLabelCorner.Parent = PresetsLabel

local PresetButtonsFrame = Instance.new("Frame")
PresetButtonsFrame.Size = UDim2.new(1, -10, 0, 40)
PresetButtonsFrame.Position = UDim2.new(0, 5, 0, 35)
PresetButtonsFrame.BackgroundTransparency = 1
PresetButtonsFrame.ZIndex = 10002
PresetButtonsFrame.Parent = PresetsFrame

local Preset1k = Instance.new("TextButton")
Preset1k.Size = UDim2.new(0, 60, 0, 30)
Preset1k.Position = UDim2.new(0, 0, 0, 0)
Preset1k.Text = "1K"
Preset1k.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Preset1k.TextColor3 = Color3.fromRGB(255, 255, 255)
Preset1k.Font = Enum.Font.Gotham
Preset1k.TextSize = 12
Preset1k.ZIndex = 10002
Preset1k.Parent = PresetButtonsFrame

local Preset1kCorner = Instance.new("UICorner")
Preset1kCorner.CornerRadius = UDim.new(0, 4)
Preset1kCorner.Parent = Preset1k

local Preset10k = Instance.new("TextButton")
Preset10k.Size = UDim2.new(0, 60, 0, 30)
Preset10k.Position = UDim2.new(0, 65, 0, 0)
Preset10k.Text = "10K"
Preset10k.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Preset10k.TextColor3 = Color3.fromRGB(255, 255, 255)
Preset10k.Font = Enum.Font.Gotham
Preset10k.TextSize = 12
Preset10k.ZIndex = 10002
Preset10k.Parent = PresetButtonsFrame

local Preset10kCorner = Instance.new("UICorner")
Preset10kCorner.CornerRadius = UDim.new(0, 4)
Preset10kCorner.Parent = Preset10k

local Preset100k = Instance.new("TextButton")
Preset100k.Size = UDim2.new(0, 60, 0, 30)
Preset100k.Position = UDim2.new(0, 130, 0, 0)
Preset100k.Text = "100K"
Preset100k.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Preset100k.TextColor3 = Color3.fromRGB(255, 255, 255)
Preset100k.Font = Enum.Font.Gotham
Preset100k.TextSize = 12
Preset100k.ZIndex = 10002
Preset100k.Parent = PresetButtonsFrame

local Preset100kCorner = Instance.new("UICorner")
Preset100kCorner.CornerRadius = UDim.new(0, 4)
Preset100kCorner.Parent = Preset100k

local Preset1m = Instance.new("TextButton")
Preset1m.Size = UDim2.new(0, 60, 0, 30)
Preset1m.Position = UDim2.new(0, 195, 0, 0)
Preset1m.Text = "1M"
Preset1m.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Preset1m.TextColor3 = Color3.fromRGB(255, 255, 255)
Preset1m.Font = Enum.Font.Gotham
Preset1m.TextSize = 12
Preset1m.ZIndex = 10002
Preset1m.Parent = PresetButtonsFrame

local Preset1mCorner = Instance.new("UICorner")
Preset1mCorner.CornerRadius = UDim.new(0, 4)
Preset1mCorner.Parent = Preset1m

-- ==================== STATUS LOG ====================
local LogFrame = Instance.new("Frame")
LogFrame.Size = UDim2.new(1, -20, 0, 80)
LogFrame.Position = UDim2.new(0, 10, 0, 390)
LogFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
LogFrame.ZIndex = 10002
LogFrame.Parent = ContentFrame

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 6)
LogCorner.Parent = LogFrame

local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(1, 0, 0, 25)
LogLabel.Position = UDim2.new(0, 0, 0, 0)
LogLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LogLabel.Text = "Log Status"
LogLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogLabel.Font = Enum.Font.GothamBold
LogLabel.TextSize = 14
LogLabel.ZIndex = 10003
LogLabel.Parent = LogFrame

local LogLabelCorner = Instance.new("UICorner")
LogLabelCorner.CornerRadius = UDim.new(0, 6)
LogLabelCorner.Parent = LogLabel

local LogText = Instance.new("TextLabel")
LogText.Size = UDim2.new(1, -10, 1, -30)
LogText.Position = UDim2.new(0, 5, 0, 30)
LogText.BackgroundTransparency = 1
LogText.Text = "Selamat datang! Gunakan deteksi otomatis atau input manual."
LogText.TextColor3 = Color3.fromRGB(200, 200, 200)
LogText.Font = Enum.Font.Gotham
LogText.TextSize = 11
LogText.TextWrapped = true
LogText.TextXAlignment = Enum.TextXAlignment.Left
LogText.TextYAlignment = Enum.TextYAlignment.Top
LogText.ZIndex = 10002
LogText.Parent = LogFrame

-- ==================== VARIABEL ====================
local dragging = false
local dragInput, dragStart, startPos
local detectedCurrencies = {}

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

-- ==================== FUNGSI UTAMA ====================
local function update(input)
    local delta = input.Position - dragStart
    FloatingButton.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

local function addLog(message, color)
    if not color then color = Color3.fromRGB(200, 200, 200) end
    LogText.Text = "[" .. os.date("%H:%M:%S") .. "] " .. message .. "\n" .. LogText.Text
end

local function detectCurrencies()
    detectedCurrencies = {}
    addLog("Memindai currency...", Color3.fromRGB(255, 255, 0))
    
    -- Cari di leaderstats (tempat paling umum)
    local player = Players.LocalPlayer
    if player:FindFirstChild("leaderstats") then
        local leaderstats = player.leaderstats
        for _, child in pairs(leaderstats:GetChildren()) do
            if child:IsA("IntValue") or child:IsA("NumberValue") or child:IsA("StringValue") then
                table.insert(detectedCurrencies, {
                    Name = child.Name,
                    Value = child.Value,
                    Object = child,
                    Type = "leaderstats"
                })
            end
        end
    end
    
    -- Cari di folder lain yang mungkin
    local commonFolders = {"Stats", "Currency", "Money", "Data", "PlayerData"}
    for _, folderName in pairs(commonFolders) do
        if player:FindFirstChild(folderName) then
            local folder = player[folderName]
            for _, child in pairs(folder:GetChildren()) do
                if child:IsA("IntValue") or child:IsA("NumberValue") or child:IsA("StringValue") then
                    table.insert(detectedCurrencies, {
                        Name = child.Name,
                        Value = child.Value,
                        Object = child,
                        Type = folderName
                    })
                end
            end
        end
    end
    
    -- Cari di ReplicatedStorage (beberapa game menyimpan data di sini)
    if game:GetService("ReplicatedStorage"):FindFirstChild("PlayerData") then
        local playerData = game:GetService("ReplicatedStorage").PlayerData
        if playerData:FindFirstChild(player.Name) then
            local playerFolder = playerData[player.Name]
            for _, child in pairs(playerFolder:GetChildren()) do
                if child:IsA("IntValue") or child:IsA("NumberValue") or child:IsA("StringValue") then
                    table.insert(detectedCurrencies, {
                        Name = child.Name,
                        Value = child.Value,
                        Object = child,
                        Type = "ReplicatedStorage"
                    })
                end
            end
        end
    end
    
    if #detectedCurrencies > 0 then
        local message = "Ditemukan " .. #detectedCurrencies .. " currency:\n"
        for i, currency in ipairs(detectedCurrencies) do
            message = message .. "- " .. currency.Name .. " (" .. currency.Type .. "): " .. tostring(currency.Value) .. "\n"
        end
        addLog(message, Color3.fromRGB(0, 255, 0))
        
        -- Auto-fill yang pertama ke input box
        if detectedCurrencies[1] then
            CurrencyNameBox.Text = detectedCurrencies[1].Name
            CurrencyValueBox.Text = tostring(detectedCurrencies[1].Value)
        end
    else
        addLog("Tidak ditemukan currency. Gunakan input manual.", Color3.fromRGB(255, 100, 100))
    end
end

local function setCurrencyValue(currencyName, newValue)
    local success = false
    local valueType = typeof(newValue)
    
    -- Coba ubah di semua lokasi yang terdeteksi
    for _, currency in pairs(detectedCurrencies) do
        if currency.Name:lower() == currencyName:lower() then
            if currency.Object and currency.Object.Parent then
                if valueType == "number" then
                    currency.Object.Value = newValue
                    success = true
                    addLog("Berhasil mengubah " .. currencyName .. " menjadi " .. newValue, Color3.fromRGB(0, 255, 0))
                    break
                end
            end
        end
    end
    
    -- Jika tidak ditemukan di detected, coba cari manual
    if not success then
        local player = Players.LocalPlayer
        
        -- Cari di leaderstats
        if player:FindFirstChild("leaderstats") then
            local leaderstats = player.leaderstats
            if leaderstats:FindFirstChild(currencyName) then
                local currencyObj = leaderstats[currencyName]
                if valueType == "number" then
                    currencyObj.Value = newValue
                    success = true
                    addLog("Berhasil mengubah " .. currencyName .. " menjadi " .. newValue, Color3.fromRGB(0, 255, 0))
                end
            end
        end
        
        -- Cari di folder umum lainnya
        if not success then
            local commonFolders = {"Stats", "Currency", "Money", "Data", "PlayerData"}
            for _, folderName in pairs(commonFolders) do
                if player:FindFirstChild(folderName) then
                    local folder = player[folderName]
                    if folder:FindFirstChild(currencyName) then
                        local currencyObj = folder[currencyName]
                        if valueType == "number" then
                            currencyObj.Value = newValue
                            success = true
                            addLog("Berhasil mengubah " .. currencyName .. " menjadi " .. newValue, Color3.fromRGB(0, 255, 0))
                            break
                        end
                    end
                end
            end
        end
    end
    
    if not success then
        addLog("Gagal mengubah " .. currencyName .. ". Currency tidak ditemukan.", Color3.fromRGB(255, 100, 100))
    end
    
    return success
end

local function applyPresetValue(value)
    local currencyName = CurrencyNameBox.Text
    if currencyName and currencyName ~= "" then
        CurrencyValueBox.Text = tostring(value)
        setCurrencyValue(currencyName, value)
    else
        addLog("Masukkan nama currency terlebih dahulu!", Color3.fromRGB(255, 100, 100))
    end
end

-- ==================== FUNGSI DESTROY ====================
local function destroyScript()
    if ScreenGui then
        ScreenGui:Destroy()
    end
    error("Script destroyed by user")
end

-- ==================== EVENT HANDLERS ====================
-- Drag functionality
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

-- Popup controls
local function togglePopup()
    if PopupFrame.Visible then
        TweenService:Create(
            PopupFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
        ):Play()
        
        wait(0.2)
        PopupFrame.Visible = false
    else
        PopupFrame.Visible = true
        PopupFrame.Size = UDim2.new(0, 0, 0, 0)
        PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        TweenService:Create(
            PopupFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 350, 0, 500), Position = UDim2.new(0.5, -175, 0.5, -250)}
        ):Play()
    end
end

-- Button events
FloatingButton.MouseButton1Click:Connect(togglePopup)

CloseButton.MouseButton1Click:Connect(showConfirmPopup)

AutoDetectButton.MouseButton1Click:Connect(function()
    detectCurrencies()
    
    TweenService:Create(
        AutoDetectButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}
    ):Play()
    wait(0.3)
    TweenService:Create(
        AutoDetectButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
    ):Play()
end)

SetCurrencyButton.MouseButton1Click:Connect(function()
    local currencyName = CurrencyNameBox.Text
    local currencyValue = tonumber(CurrencyValueBox.Text)
    
    if currencyName and currencyName ~= "" and currencyValue then
        setCurrencyValue(currencyName, currencyValue)
        
        TweenService:Create(
            SetCurrencyButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}
        ):Play()
    else
        addLog("Nama currency atau nilai tidak valid!", Color3.fromRGB(255, 100, 100))
        TweenService:Create(
            SetCurrencyButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}
        ):Play()
    end
    
    wait(0.3)
    TweenService:Create(
        SetCurrencyButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 180, 120)}
    ):Play()
end)

-- Preset buttons
Preset1k.MouseButton1Click:Connect(function()
    applyPresetValue(1000)
end)

Preset10k.MouseButton1Click:Connect(function()
    applyPresetValue(10000)
end)

Preset100k.MouseButton1Click:Connect(function()
    applyPresetValue(100000)
end)

Preset1m.MouseButton1Click:Connect(function()
    applyPresetValue(1000000)
end)

-- Confirm popup events
ConfirmYesButton.MouseButton1Click:Connect(function()
    hideConfirmPopup()
    destroyScript()
end)

ConfirmNoButton.MouseButton1Click:Connect(function()
    hideConfirmPopup()
end)

-- Hover effects
local function setupHoverEffects()
    -- Floating button
    FloatingButton.MouseEnter:Connect(function()
        TweenService:Create(
            FloatingButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 160, 100)}
        ):Play()
    end)
    
    FloatingButton.MouseLeave:Connect(function()
        TweenService:Create(
            FloatingButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 180, 120)}
        ):Play()
    end)
    
    -- Close button
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
    
    -- Auto detect button
    AutoDetectButton.MouseEnter:Connect(function()
        TweenService:Create(
            AutoDetectButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
        ):Play()
    end)
    
    AutoDetectButton.MouseLeave:Connect(function()
        TweenService:Create(
            AutoDetectButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
        ):Play()
    end)
    
    -- Set currency button
    SetCurrencyButton.MouseEnter:Connect(function()
        TweenService:Create(
            SetCurrencyButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 200, 140)}
        ):Play()
    end)
    
    SetCurrencyButton.MouseLeave:Connect(function()
        TweenService:Create(
            SetCurrencyButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 180, 120)}
        ):Play()
    end)
    
    -- Preset buttons
    local presetButtons = {Preset1k, Preset10k, Preset100k, Preset1m}
    for _, button in ipairs(presetButtons) do
        button.MouseEnter:Connect(function()
            TweenService:Create(
                button,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 100, 180)}
            ):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(
                button,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
            ):Play()
        end)
    end
    
    -- Confirm buttons
    ConfirmYesButton.MouseEnter:Connect(function()
        TweenService:Create(
            ConfirmYesButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}
        ):Play()
    end)
    
    ConfirmYesButton.MouseLeave:Connect(function()
        TweenService:Create(
            ConfirmYesButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(220, 60, 60)}
        ):Play()
    end)
    
    ConfirmNoButton.MouseEnter:Connect(function()
        TweenService:Create(
            ConfirmNoButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
        ):Play()
    end)
    
    ConfirmNoButton.MouseLeave:Connect(function()
        TweenService:Create(
            ConfirmNoButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
        ):Play()
    end)
end

setupHoverEffects()

-- Notifikasi awal
addLog("Currency Editor berhasil dimuat!", Color3.fromRGB(0, 255, 0))
addLog("Gunakan deteksi otomatis atau input manual nama currency.")

print("Currency Editor by Milky - Loaded Successfully!")
