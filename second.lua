-- Service
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Inisialisasi karakter
local character = nil
local humanoid = nil

-- Fungsi untuk mengatur karakter saat dimuat
local function setupCharacter(newCharacter)
    character = newCharacter
    -- Tunggu hingga Humanoid tersedia
    while not character:FindFirstChildOfClass("Humanoid") do
        character.ChildAdded:Wait()
    end
    humanoid = character:FindFirstChildOfClass("Humanoid")
end

-- Hubungkan event CharacterAdded
if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setupCharacter)

-- Tangani input pengguna
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- Abaikan jika input berasal dari chat (game processed)
    if gameProcessed then
        return
    end

    -- Contoh: Tombol M untuk membuka menu
    if input.KeyCode == Enum.KeyCode.M then
        if character and humanoid then
            -- Jalankan logika Anda di sini
            print("Tombol M ditekan!")
        end
    end
end)UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = FloatingButton

-- ==================== MAIN MENU POPUP ====================
local MainPopup = Instance.new("Frame")
MainPopup.Size = UDim2.new(0, 300, 0, 400)
MainPopup.Position = UDim2.new(0.5, -150, 0.5, -200)
MainPopup.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainPopup.BorderSizePixel = 0
MainPopup.Visible = false
MainPopup.ZIndex = 10005
MainPopup.Parent = ScreenGui

local MainPopupCorner = Instance.new("UICorner")
MainPopupCorner.CornerRadius = UDim.new(0, 12)
MainPopupCorner.Parent = MainPopup

-- Header Menu
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.BorderSizePixel = 0
Header.ZIndex = 10006
Header.Parent = MainPopup

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Size = UDim2.new(1, -40, 1, 0)
HeaderLabel.Position = UDim2.new(0, 10, 0, 0)
HeaderLabel.BackgroundTransparency = 1
HeaderLabel.Text = "Milky Menu"
HeaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderLabel.Font = Enum.Font.GothamBold
HeaderLabel.TextSize = 16
HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderLabel.ZIndex = 10007
HeaderLabel.Parent = Header

-- Close Button di Header
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.ZIndex = 10007
CloseButton.Parent = Header

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 6)
CloseButtonCorner.Parent = CloseButton

-- Container untuk tombol-tombol dengan scrolling
local ButtonsContainer = Instance.new("ScrollingFrame")
ButtonsContainer.Size = UDim2.new(1, -20, 1, -60)
ButtonsContainer.Position = UDim2.new(0, 10, 0, 50)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.BorderSizePixel = 0
ButtonsContainer.ScrollBarThickness = 0 -- Hide default scrollbar
ButtonsContainer.ZIndex = 10006
ButtonsContainer.Parent = MainPopup

-- UIListLayout untuk tombol-tombol
local ButtonsLayout = Instance.new("UIListLayout")
ButtonsLayout.Padding = UDim.new(0, 8)
ButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ButtonsLayout.Parent = ButtonsContainer

-- ==================== CUSTOM SCROLLBAR ====================
local ScrollbarTrack = Instance.new("Frame")
ScrollbarTrack.Size = UDim2.new(0, 6, 1, -60)
ScrollbarTrack.Position = UDim2.new(1, -12, 0, 50)
ScrollbarTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScrollbarTrack.BorderSizePixel = 0
ScrollbarTrack.ZIndex = 10007
ScrollbarTrack.Parent = MainPopup

local ScrollbarTrackCorner = Instance.new("UICorner")
ScrollbarTrackCorner.CornerRadius = UDim.new(1, 0)
ScrollbarTrackCorner.Parent = ScrollbarTrack

local ScrollbarThumb = Instance.new("Frame")
ScrollbarThumb.Size = UDim2.new(1, 0, 0, 80)
ScrollbarThumb.Position = UDim2.new(0, 0, 0, 0)
ScrollbarThumb.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
ScrollbarThumb.BorderSizePixel = 0
ScrollbarThumb.ZIndex = 10008
ScrollbarThumb.Parent = ScrollbarTrack

local ScrollbarThumbCorner = Instance.new("UICorner")
ScrollbarThumbCorner.CornerRadius = UDim.new(1, 0)
ScrollbarThumbCorner.Parent = ScrollbarThumb

-- ==================== TOMBOL X-RAY ====================
local XRayButton = Instance.new("TextButton")
XRayButton.Size = UDim2.new(1, 0, 0, 40)
XRayButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
XRayButton.Text = "X-Ray: OFF"
XRayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
XRayButton.Font = Enum.Font.Gotham
XRayButton.TextSize = 14
XRayButton.ZIndex = 10007
XRayButton.Parent = ButtonsContainer

local XRayButtonCorner = Instance.new("UICorner")
XRayButtonCorner.CornerRadius = UDim.new(0, 6)
XRayButtonCorner.Parent = XRayButton

-- ==================== TOMBOL NOCLIP ====================
local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(1, 0, 0, 40)
NoclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NoclipButton.Text = "Noclip: OFF"
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.Font = Enum.Font.Gotham
NoclipButton.TextSize = 14
NoclipButton.ZIndex = 10007
NoclipButton.Parent = ButtonsContainer

local NoclipButtonCorner = Instance.new("UICorner")
NoclipButtonCorner.CornerRadius = UDim.new(0, 6)
NoclipButtonCorner.Parent = NoclipButton

-- ==================== TOMBOL LAINNYA ====================
local PlayerListButton = Instance.new("TextButton")
PlayerListButton.Size = UDim2.new(1, 0, 0, 40)
PlayerListButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PlayerListButton.Text = "Player List"
PlayerListButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerListButton.Font = Enum.Font.Gotham
PlayerListButton.TextSize = 14
PlayerListButton.ZIndex = 10007
PlayerListButton.Parent = ButtonsContainer

local PlayerListButtonCorner = Instance.new("UICorner")
PlayerListButtonCorner.CornerRadius = UDim.new(0, 6)
PlayerListButtonCorner.Parent = PlayerListButton

local CloseMenuButton = Instance.new("TextButton")
CloseMenuButton.Size = UDim2.new(1, 0, 0, 40)
CloseMenuButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseMenuButton.Text = "Close Menu"
CloseMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseMenuButton.Font = Enum.Font.Gotham
CloseMenuButton.TextSize = 14
CloseMenuButton.ZIndex = 10007
CloseMenuButton.Parent = ButtonsContainer

local CloseMenuButtonCorner = Instance.new("UICorner")
CloseMenuButtonCorner.CornerRadius = UDim.new(0, 6)
CloseMenuButtonCorner.Parent = CloseMenuButton

-- ==================== VARIABEL FUNGSIONALITAS ====================
local xrayEnabled = false
local noclipEnabled = false
local noclipConnection = nil
local originalTransparency = {}

-- ==================== FUNGSI X-RAY ====================
local function applyXRayEffect()
    xrayEnabled = not xrayEnabled
    XRayButton.Text = "X-Ray: " .. (xrayEnabled and "ON" or "OFF")
    XRayButton.BackgroundColor3 = xrayEnabled and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(60, 60, 60)
    
    if xrayEnabled then
        -- Simpan transparansi asli dan terapkan efek X-ray
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:FindFirstAncestorOfClass("Model") then
                originalTransparency[part] = part.Transparency
                part.Transparency = 0.7
            end
        end
    else
        -- Kembalikan transparansi asli
        for part, transparency in pairs(originalTransparency) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
        originalTransparency = {}
    end
end

-- ==================== FUNGSI NOCLIP ====================
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    NoclipButton.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    NoclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(60, 60, 60)
    
    if noclipEnabled then
        -- Aktifkan noclip
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        -- Nonaktifkan noclip
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        -- Kembalikan collision
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- ==================== FUNGSI SCROLLBAR ====================
local function updateScrollbar()
    local canvasSize = ButtonsContainer.CanvasSize.Y.Offset
    local windowSize = ButtonsContainer.AbsoluteWindowSize.Y
    
    if canvasSize > windowSize then
        ScrollbarTrack.Visible = true
        
        -- Update ukuran thumb
        local thumbRatio = windowSize / canvasSize
        local thumbSize = math.max(30, windowSize * thumbRatio)
        ScrollbarThumb.Size = UDim2.new(1, 0, 0, thumbSize)
        
        -- Update posisi thumb
        local scrollRatio = ButtonsContainer.CanvasPosition.Y / (canvasSize - windowSize)
        local availableSpace = ScrollbarTrack.AbsoluteSize.Y - thumbSize
        ScrollbarThumb.Position = UDim2.new(0, 0, 0, availableSpace * scrollRatio)
    else
        ScrollbarTrack.Visible = false
    end
end

-- Fungsi untuk drag scrollbar thumb
local function setupScrollbarDrag()
    local dragging = false
    local dragStart = nil
    local startPosition = nil
    
    ScrollbarThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position.Y
            startPosition = ScrollbarThumb.Position.Y.Offset
        end
    end)
    
    ScrollbarThumb.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position.Y - dragStart
            local trackHeight = ScrollbarTrack.AbsoluteSize.Y - ScrollbarThumb.AbsoluteSize.Y
            local newY = math.clamp(startPosition + delta, 0, trackHeight)
            
            ScrollbarThumb.Position = UDim2.new(0, 0, 0, newY)
            
            -- Update scrolling frame position
            local scrollRatio = newY / trackHeight
            local canvasSize = ButtonsContainer.CanvasSize.Y.Offset
            local windowSize = ButtonsContainer.AbsoluteWindowSize.Y
            ButtonsContainer.CanvasPosition = Vector2.new(0, scrollRatio * (canvasSize - windowSize))
        end
    end)
end

-- ==================== FUNGSI UTAMA ====================
local function toggleMainMenu()
    MainPopup.Visible = not MainPopup.Visible
    FloatingButton.Text = MainPopup.Visible and "✕" or "☰"
    
    if MainPopup.Visible then
        -- Update container size berdasarkan jumlah tombol
        local buttonCount = #ButtonsContainer:GetChildren() - 1 -- minus UIListLayout
        ButtonsContainer.CanvasSize = UDim2.new(0, 0, 0, (buttonCount * 48) + ((buttonCount - 1) * 8))
        updateScrollbar()
    end
end

-- ==================== EVENT CONNECTIONS ====================
-- Toggle menu utama
FloatingButton.MouseButton1Click:Connect(toggleMainMenu)

-- Tombol close di header
CloseButton.MouseButton1Click:Connect(toggleMainMenu)

-- Tombol close di menu
CloseMenuButton.MouseButton1Click:Connect(toggleMainMenu)

-- Fungsi tombol-tombol
XRayButton.MouseButton1Click:Connect(applyXRayEffect)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)

-- Update scrollbar ketika container berubah
ButtonsContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(updateScrollbar)
ButtonsContainer:GetPropertyChangedSignal("CanvasSize"):Connect(updateScrollbar)

-- Setup scrollbar dragging
setupScrollbarDrag()

-- Player list button functionality
PlayerListButton.MouseButton1Click:Connect(function()
    print("Player List:")
    for _, player in ipairs(Players:GetPlayers()) do
        print("- " .. player.Name)
    end
end)

-- ==================== DRAGGABLE MAIN POPUP ====================
local dragging = false
local dragInput, dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainPopup.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainPopup.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==================== MOBILE SUPPORT ====================
if UserInputService.TouchEnabled then
    -- Make floating button draggable on mobile
    local mobileDragging = false
    local mobileDragStart = nil
    local mobileStartPos = nil
    
    FloatingButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            mobileDragging = true
            mobileDragStart = input.Position
            mobileStartPos = FloatingButton.Position
        end
    end)
    
    FloatingButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            mobileDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if mobileDragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - mobileDragStart
            FloatingButton.Position = UDim2.new(
                mobileStartPos.X.Scale, 
                mobileStartPos.X.Offset + delta.X,
                mobileStartPos.Y.Scale, 
                mobileStartPos.Y.Offset + delta.Y
            )
        end
    end)
end

print("Milky Floating Menu loaded successfully!")UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = FloatingButton

-- ==================== POPUP KONFIRMASI ====================
-- Popup Konfirmasi Penutupan
local ConfirmPopup = Instance.new("Frame")
ConfirmPopup.Size = UDim2.new(0, 300, 0, 150)
ConfirmPopup.Position = UDim2.new(0.5, -150, 0.5, -75)
ConfirmPopup.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ConfirmPopup.BorderSizePixel = 0
ConfirmPopup.Visible = false
ConfirmPopup.ZIndex = 10010 -- Lebih tinggi dari semua UI
ConfirmPopup.Parent = ScreenGui

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 12)
ConfirmCorner.Parent = ConfirmPopup

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
ConfirmTitleCorner.CornerRadius = UDim.new(0, 12)
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

-- ==================== MAIN POPUP WINDOW (DIPERLEBAR) ====================
-- Popup Window dengan ZIndex tinggi (diperlebar dari 300 menjadi 350)
local PopupFrame = Instance.new("Frame")
PopupFrame.Size = UDim2.new(0, 350, 0, 450) -- Diperlebar dan dipertinggi
PopupFrame.Position = UDim2.new(0.5, -175, 0.5, -225) -- Disesuaikan dengan ukuran baru
PopupFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PopupFrame.BorderSizePixel = 0
PopupFrame.Visible = false
PopupFrame.ZIndex = 10000 -- ZIndex sangat tinggi
PopupFrame.Parent = ScreenGui

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 12)
PopupCorner.Parent = PopupFrame

-- Ribbon Navigation (4 ribbon)
local RibbonFrame = Instance.new("Frame")
RibbonFrame.Size = UDim2.new(1, 0, 0, 40)
RibbonFrame.Position = UDim2.new(0, 0, 0, 0)
RibbonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
RibbonFrame.BorderSizePixel = 0
RibbonFrame.ZIndex = 10001 -- Lebih tinggi dari PopupFrame
RibbonFrame.Parent = PopupFrame

local RibbonCorner = Instance.new("UICorner")
RibbonCorner.CornerRadius = UDim.new(0, 12)
RibbonCorner.Parent = RibbonFrame

-- Ribbon Buttons (4 ribbon - disesuaikan ukurannya)
local UtamaRibbon = Instance.new("TextButton")
UtamaRibbon.Size = UDim2.new(0.25, 0, 1, 0)
UtamaRibbon.Position = UDim2.new(0, 0, 0, 0)
UtamaRibbon.Text = "Utama"
UtamaRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
UtamaRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
UtamaRibbon.Font = Enum.Font.GothamBold
UtamaRibbon.TextSize = 12
UtamaRibbon.ZIndex = 10002 -- Lebih tinggi dari RibbonFrame
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

-- Tambahkan ScriptRibbon sebagai ribbon ke-4
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

-- Close Button dipindahkan ke kanan ribbon (di samping ribbon)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25) -- Diperkecil sedikit
CloseButton.Position = UDim2.new(1, -30, 0, 7) -- Posisi di kanan atas, sejajar dengan ribbon
CloseButton.Text = "×" -- Gunakan karakter × yang lebih elegan
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.ZIndex = 10003 -- ZIndex tertinggi agar selalu tampil di atas
CloseButton.Parent = PopupFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Content Frames
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 10001
ContentFrame.Parent = PopupFrame

-- Utama Content (DIPERLEBAR)
local UtamaContent = Instance.new("Frame")
UtamaContent.Size = UDim2.new(1, 0, 1, 0)
UtamaContent.Position = UDim2.new(0, 0, 0, 0)
UtamaContent.BackgroundTransparency = 1
UtamaContent.Visible = true
UtamaContent.ZIndex = 10001
UtamaContent.Parent = ContentFrame

local Message = Instance.new("TextLabel")
Message.Size = UDim2.new(1, -20, 0, 40)
Message.Position = UDim2.new(0, 10, 0, 10)
Message.BackgroundTransparency = 1
Message.Text = "halo saya milky"
Message.TextColor3 = Color3.fromRGB(255, 255, 255)
Message.Font = Enum.Font.Gotham
Message.TextSize = 16
Message.ZIndex = 10002
Message.Parent = UtamaContent

-- Fly Switch (DIPERLEBAR)
local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(0, 310, 0, 30) -- Diperlebar dari 260 menjadi 310
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

-- Float Switch (DIPERLEBAR)
local FloatFrame = Instance.new("Frame")
FloatFrame.Size = UDim2.new(0, 310, 0, 30) -- Diperlebar dari 260 menjadi 310
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

-- Brightness Switch (DITAMBAHKAN)
local BrightnessFrame = Instance.new("Frame")
BrightnessFrame.Size = UDim2.new(0, 310, 0, 30) -- Diperlebar dari 260 menjadi 310
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

-- WalkSpeed Input (DIPERLEBAR)
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Size = UDim2.new(0, 310, 0, 30) -- Diperlebar dari 260 menjadi 310
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

-- Daftar Pemain (DIPERLEBAR) - DIPINDAHKAN KE BAWAH
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Size = UDim2.new(0, 310, 0, 120) -- Diperlebar dari 260 menjadi 310
PlayerListFrame.Position = UDim2.new(0, 20, 0, 220) -- Dipindahkan ke bawah
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

-- ... (Kode Tween Content, Parts Content, Script Content, dan lainnya tetap sama)
-- Tween Content (DIPERLEBAR)
local TweenContent = Instance.new("Frame")
TweenContent.Size = UDim2.new(1, 0, 1, 0)
TweenContent.Position = UDim2.new(0, 0, 0, 0)
TweenContent.BackgroundTransparency = 1
TweenContent.Visible = false
TweenContent.ZIndex = 10001
TweenContent.Parent = ContentFrame

-- Waypoint Input Form (DIPERLEBAR)
local WaypointFrame = Instance.new("Frame")
WaypointFrame.Size = UDim2.new(0, 310, 0, 30) -- Diperlebar dari 260 menjadi 310
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

-- Daftar Waypoint (DIPERLEBAR)
local WaypointListFrame = Instance.new("Frame")
WaypointListFrame.Size = UDim2.new(0, 310, 0, 330) -- Diperlebar dari 260 menjadi 310, dipertinggi
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

-- Parts Content (DIPERLEBAR)
local PartsContent = Instance.new("Frame")
PartsContent.Size = UDim2.new(1, 0, 1, 0)
PartsContent.Position = UDim2.new(0, 0, 0, 0)
PartsContent.BackgroundTransparency = 1
PartsContent.Visible = false
PartsContent.ZIndex = 10001
PartsContent.Parent = ContentFrame

-- Pencarian Parts (DIPERLEBAR)
local PartsSearchFrame = Instance.new("Frame")
PartsSearchFrame.Size = UDim2.new(0, 310, 0, 30) -- Diperlebar dari 260 menjadi 310
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
PartsInfoLabel.Size = UDim2.new(0, 240, 0, 20) -- Diperlebar
PartsInfoLabel.Position = UDim2.new(0, 20, 0, 45)
PartsInfoLabel.BackgroundTransparency = 1
PartsInfoLabel.Text = "Total Parts: 0"
PartsInfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PartsInfoLabel.Font = Enum.Font.Gotham
PartsInfoLabel.TextSize = 12
PartsInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
PartsInfoLabel.ZIndex = 10002
PartsInfoLabel.Parent = PartsContent

-- Daftar Parts (DIPERLEBAR)
local PartsListFrame = Instance.new("Frame")
PartsListFrame.Size = UDim2.new(0, 310, 0, 350) -- Diperlebar dari 260 menjadi 310, dipertinggi
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

-- Script Content (DIPERLEBAR)
local ScriptContent = Instance.new("Frame")
ScriptContent.Size = UDim2.new(1, 0, 1, 0)
ScriptContent.Position = UDim2.new(0, 0, 0, 0)
ScriptContent.BackgroundTransparency = 1
ScriptContent.Visible = false
ScriptContent.ZIndex = 10001
ScriptContent.Parent = ContentFrame

-- Info Game (DIPERLEBAR)
local GameInfoFrame = Instance.new("Frame")
GameInfoFrame.Size = UDim2.new(0, 310, 0, 60) -- Diperlebar dari 260 menjadi 310
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

-- Pencarian Script (DIPERLEBAR)
local ScriptSearchFrame = Instance.new("Frame")
ScriptSearchFrame.Size = UDim2.new(0, 310, 0, 30) -- Diperlebar dari 260 menjadi 310
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

-- Filter Script (DIPERLEBAR)
local FilterFrame = Instance.new("Frame")
FilterFrame.Size = UDim2.new(0, 310, 0, 25) -- Diperlebar dari 260 menjadi 310
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
SearchStatusLabel.Size = UDim2.new(0, 310, 0, 20) -- Diperlebar
SearchStatusLabel.Position = UDim2.new(0, 20, 0, 150)
SearchStatusLabel.BackgroundTransparency = 1
SearchStatusLabel.Text = "Tekan 'Cari' untuk memuat script"
SearchStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SearchStatusLabel.Font = Enum.Font.Gotham
SearchStatusLabel.TextSize = 12
SearchStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
SearchStatusLabel.ZIndex = 10002
SearchStatusLabel.Parent = ScriptContent

-- Daftar Script (DIPERLEBAR)
local ScriptListFrame = Instance.new("Frame")
ScriptListFrame.Size = UDim2.new(0, 310, 0, 230) -- Diperlebar dari 260 menjadi 310, dipertinggi
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

-- ==================== FUNGSI POPUP KONFIRMASI YANG DIPERBAIKI ====================
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

-- ==================== VARIABEL BARU UNTUK BRIGHTNESS ====================
local isBrightnessEnabled = false
local originalBrightness = Lighting.Brightness
local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalFogEnd = Lighting.FogEnd

-- ==================== FUNGSI YANG SUDAH ADA (TANPA PERUBAHAN) ====================
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

-- Variabel untuk script
local scriptBloxAPI = "https://scriptblox.com/api/script/search"
local currentScripts = {}
local filteredScripts = {}
local activeFilters = {
    verified = false,
    free = false,
    universal = false
}

-- Variabel untuk koneksi event (DITAMBAHKAN UNTUK PERBAIKAN)
local playerAddedConn, playerRemovingConn, characterAddedConn

-- ==================== FUNGSI BRIGHTNESS YANG DITAMBAHKAN ====================
local function toggleBrightness()
    if isBrightnessEnabled then
        -- Nonaktifkan brightness (kembalikan ke nilai asli)
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
        -- Aktifkan brightness (terangkan ruangan)
        originalBrightness = Lighting.Brightness
        originalAmbient = Lighting.Ambient
        originalOutdoorAmbient = Lighting.OutdoorAmbient
        originalFogEnd = Lighting.FogEnd
        
        Lighting.Brightness = 2  -- Tingkatkan brightness
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)  -- Ambient light terang
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)  -- Outdoor ambient terang
        Lighting.FogEnd = 100000  -- Hilangkan fog dengan men-set nilai sangat besar
        
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

-- ==================== FUNGSI UTAMA YANG DIPERBAIKI ====================

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

-- Fungsi untuk membersihkan brightness
local function cleanUpBrightness()
    if isBrightnessEnabled then
        toggleBrightness() -- Nonaktifkan brightness
    end
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

-- ==================== FUNGSI SCRIPT BLOCK ====================

-- Fungsi untuk mendapatkan script dari ScriptBlox API
local function searchScripts(query, filters)
    SearchStatusLabel.Text = "Mencari script..."
    SearchStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    local url = scriptBloxAPI .. "?q=" .. query .. "&max=20"
    
    -- Tambahkan filter ke URL
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

-- Fungsi untuk mengeksekusi script
local function executeScript(scriptCode, scriptTitle)
    if scriptCode and scriptCode ~= "" then
        -- Bersihkan fungsi aktif sebelum menjalankan script baru
        cleanUpFly()
        cleanUpFloat()
        cleanUpHead()
        cleanUpAllESP()
        cleanUpBrightness()
        
        -- Eksekusi script menggunakan loadstring
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

-- Fungsi untuk memperbarui daftar script di GUI
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
        
        -- Judul Script
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
        
        -- Info Script
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
        
        -- Status Script (Verified, Free, etc.)
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
        
        -- Stats (Likes/Views)
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
        
        -- Tombol Execute
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
        
        -- Nonaktifkan tombol jika script patched
        if scriptData.isPatched then
            executeButton.Active = false
            executeButton.Text = "Patched"
        end
        
        -- Event handler untuk tombol execute
        executeButton.MouseButton1Click:Connect(function()
            if not scriptData.isPatched then
                executeButton.Text = "Executing..."
                executeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
                
                executeScript(scriptData.script, scriptData.title)
                
                -- Kembalikan tampilan tombol setelah 2 detik
                wait(2)
                if executeButton then
                    executeButton.Text = "Execute"
                    executeButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                end
            end
        end)
        
        -- Efek hover pada tombol execute
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
        partItem.ZIndex = 10002
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
        partName.ZIndex = 10002
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
        partParent.ZIndex = 10002
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
        partInfo.ZIndex = 10002
        partInfo.Parent = partItem
        
        -- Container untuk tombol
        local buttonContainer = Instance.new("Frame")
        buttonContainer.Size = UDim2.new(0.3, 0, 1, 0)
        buttonContainer.Position = UDim2.new(0.7, 0, 0, 0)
        buttonContainer.BackgroundTransparency = 1
        buttonContainer.ZIndex = 10002
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
        tweenButton.ZIndex = 10002
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
        espButton.ZIndex = 10002
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

-- ==================== FUNGSI SWITCH RIBBON YANG DIPERBAIKI ====================
local function switchRibbon(ribbonName)
    -- Sematkan semua konten terlebih dahulu
    UtamaContent.Visible = false
    TweenContent.Visible = false
    PartsContent.Visible = false
    ScriptContent.Visible = false
    
    -- Reset warna semua ribbon
    UtamaRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    UtamaRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    TweenRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TweenRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    PartsRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    PartsRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    ScriptRibbon.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ScriptRibbon.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Aktifkan ribbon dan konten yang dipilih
    if ribbonName == "Utama" then
        UtamaRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        UtamaRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        UtamaContent.Visible = true
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
    else -- Script
        ScriptRibbon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        ScriptRibbon.TextColor3 = Color3.fromRGB(255, 255, 255)
        ScriptContent.Visible = true
        
        -- Otomatis mencari script untuk game saat ini ketika membuka tab Script
        if #currentScripts == 0 then
            local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
            ScriptSearchBox.Text = gameName
            -- Pencarian dilakukan secara asynchronous untuk tidak membebankan GUI
            spawn(function()
                if searchScripts(gameName, activeFilters) then
                    updateScriptList()
                end
            end)
        end
    end
end

-- ==================== FUNGSI DESTROY SCRIPT YANG DIPERBAIKI ====================
local function destroyScript()
    -- Bersihkan semua fungsi aktif
    cleanUpFly()
    cleanUpFloat()
    cleanUpHead()
    cleanUpAllESP()
    cleanUpBrightness()
    
    -- Hapus semua koneksi event yang sudah dideklarasikan
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
    
    -- Hentikan eksekusi script lebih lanjut
    -- Dengan menggunakan error untuk menghentikan eksekusi
    error("Script destroyed by user")
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
BrightnessSwitch.MouseButton1Click:Connect(toggleBrightness) -- DITAMBAHKAN

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

-- ==================== EVENT HANDLERS SCRIPT ====================

-- Event handler untuk pencarian script
SearchScriptButton.MouseButton1Click:Connect(function()
    local searchQuery = ScriptSearchBox.Text
    if searchQuery == "" then
        -- Jika kotak pencarian kosong, gunakan nama game sebagai query
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

-- Event handlers untuk filter
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

-- Efek hover untuk tombol filter
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

-- ==================== RIBBON SWITCHING ====================
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

ScriptRibbon.MouseButton1Click:Connect(function()
    switchRibbon("Script")
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

-- Efek hover pada ribbon buttons lainnya
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
            {Size = UDim2.new(0, 350, 0, 450), Position = UDim2.new(0.5, -175, 0.5, -225)}
        ):Play()
    end
end

-- ==================== EVENT HANDLERS POPUP KONFIRMASI YANG DIPERBAIKI ====================
ConfirmYesButton.MouseButton1Click:Connect(function()
    hideConfirmPopup()
    
    -- Panggil fungsi destroyScript yang sudah diperbaiki
    destroyScript()
end)

ConfirmNoButton.MouseButton1Click:Connect(function()
    hideConfirmPopup()
end)

-- Efek hover pada tombol konfirmasi
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

-- Event handler untuk floating button (toggle popup)
FloatingButton.MouseButton1Click:Connect(togglePopup)

-- Event handler untuk close button (show konfirmasi)
CloseButton.MouseButton1Click:Connect(showConfirmPopup)

-- Efek hover pada tombol close
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

-- Efek hover pada tombol switch (termasuk brightness)
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
setupSwitchHover(BrightnessSwitch, BrightnessToggle) -- DITAMBAHKAN

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

-- Deteksi ketika pemain bergabung atau keluar
playerAddedConn = Players.PlayerAdded:Connect(updatePlayerList)
playerRemovingConn = Players.PlayerRemoving:Connect(updatePlayerList)

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
if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

characterAddedConn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Notifikasi
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Milky Menu Loaded",
    Text = "Menu dengan ESP, Brightness, dan fitur lengkap telah dimuat!",
    Duration = 5
})

-- Pastikan semua fungsi dimatikan saat game dimatikan
game:BindToClose(function()
    destroyScript()
end)
