-- Script: tools.lua
-- Untuk perangkat mobile Roblox
-- Menambahkan tombol modtools yang dapat dipindah dan fitur teleportasi ke pemain

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Cek apakah pemain adalah admin/pemilik map
local function isAdmin(player)
    -- Ganti dengan logika admin yang sesuai
    return player.Name == "NamaAnda" or player.UserId == 12345 -- Ganti dengan nama/UserID Anda
end

-- Buat GUI utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModToolsMobile"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- Tombol utama modtools
local mainButton = Instance.new("ImageButton")
mainButton.Name = "MainModButton"
mainButton.Size = UDim2.new(0, 60, 0, 60)
mainButton.Position = UDim2.new(0, 20, 0.5, -30)
mainButton.AnchorPoint = Vector2.new(0, 0.5)
mainButton.Image = "rbxassetid://7072716642" -- Ganti dengan asset ID gambar yang sesuai
mainButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainButton.AutoButtonColor = false

-- Style tombol
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.3, 0)
corner.Parent = mainButton

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://7072716642" -- Ganti dengan asset ID gambar shadow
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainButton
shadow.ZIndex = mainButton.ZIndex - 1

mainButton.Parent = screenGui

-- Frame untuk popup form
local popupFrame = Instance.new("Frame")
popupFrame.Name = "PlayerListPopup"
popupFrame.Size = UDim2.new(0, 300, 0, 400)
popupFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
popupFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
popupFrame.BorderSizePixel = 0
popupFrame.Visible = false

local popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0.05, 0)
popupCorner.Parent = popupFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "Pilih Pemain"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = popupFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0.05, 0)
titleCorner.Parent = title

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.Parent = title

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0.5, 0)
closeCorner.Parent = closeButton

local playersList = Instance.new("ScrollingFrame")
playersList.Name = "PlayersList"
playersList.Size = UDim2.new(1, -20, 1, -60)
playersList.Position = UDim2.new(0, 10, 0, 50)
playersList.BackgroundTransparency = 1
playersList.BorderSizePixel = 0
playersList.ScrollBarThickness = 5
playersList.AutomaticCanvasSize = Enum.AutomaticSize.Y
playersList.Parent = popupFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = playersList

popupFrame.Parent = screenGui

-- Variabel untuk drag functionality
local dragging = false
local dragInput, dragStart, startPos

-- Fungsi untuk mengupdate daftar pemain
local function updatePlayerList()
    for _, child in ipairs(playersList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0, 50)
            playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Text = player.Name
            playerButton.Font = Enum.Font.SourceSans
            playerButton.TextSize = 18
            playerButton.AutoButtonColor = true
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0.1, 0)
            buttonCorner.Parent = playerButton
            
            playerButton.MouseButton1Click:Connect(function()
                popupFrame.Visible = false
                -- Eksekusi perintah teleportasi
                local command = string.format(";tweengoto %s", player.Name)
                game:GetService("ReplicatedStorage"):FindFirstChild("AdminCommand"):FireServer(command)
            end)
            
            playerButton.Parent = playersList
        end
    end
end

-- Fungsi untuk memulai drag
local function beginDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = mainButton.Position
    
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
end

-- Fungsi untuk update posisi saat drag
local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        mainButton.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end

-- Event handlers untuk drag functionality
mainButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input)
    end
end)

mainButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

-- Toggle popup ketika tombol diklik
mainButton.MouseButton1Click:Connect(function()
    if not isAdmin(Players.LocalPlayer) then
        return
    end
    
    if popupFrame.Visible then
        popupFrame.Visible = false
    else
        updatePlayerList()
        popupFrame.Visible = true
    end
end)

-- Tutup popup ketika tombol close diklik
closeButton.MouseButton1Click:Connect(function()
    popupFrame.Visible = false
end)

-- Sembunyikan UI jika bukan admin
local function onPlayerAdded(player)
    if player == Players.LocalPlayer then
        if not isAdmin(player) then
            screenGui.Enabled = false
        else
            screenGui.Enabled = true
        end
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

if Players.LocalPlayer then
    onPlayerAdded(Players.LocalPlayer)
end

-- Handler untuk resize layar (responsif)
local function onViewportSizeChanged()
    if popupFrame.Visible then
        popupFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    end
end

game:GetService("Workspace").CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged)
