--[[
    Script Tools Teleportasi Pemain
    Oleh: Creator Map
    Deskripsi: Memunculkan UI untuk memilih pemain dan teleportasi ke lokasinya
--]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Variabel utama
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Buat ScreenGui utama jika belum ada
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MapOwnerTools"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Buat tombol utama
local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 100, 0, 50)
mainButton.Position = UDim2.new(0, 10, 0, 10)
mainButton.Text = "Teleport to Player"
mainButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
mainButton.TextColor3 = Color3.white
mainButton.Font = Enum.Font.GothamBold
mainButton.TextSize = 14
mainButton.Parent = screenGui

-- Buat frame popup (awalnya tersembunyi)
local popupFrame = Instance.new("Frame")
popupFrame.Size = UDim2.new(0, 300, 0, 400)
popupFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
popupFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
popupFrame.BorderSizePixel = 0
popupFrame.Visible = false
popupFrame.Parent = screenGui

-- Tambahkan UIStroke untuk efek visual
local uiStroke = Instance.new("UIStroke")
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Color = Color3.fromRGB(100, 100, 100)
uiStroke.Thickness = 2
uiStroke.Parent = popupFrame

-- Tambahkan judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Pilih Pemain untuk Diteleportasi"
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.white
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = popupFrame

-- Tambahkan daftar scroll untuk pemain
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -50)
scrollFrame.Position = UDim2.new(0, 5, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 5
scrollFrame.Parent = popupFrame

-- Tambukan UIListLayout untuk mengatur item pemain
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = scrollFrame

-- Tambahkan tombol tutup
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 100, 0, 30)
closeButton.Position = UDim2.new(0.5, -50, 1, -35)
closeButton.Text = "Tutup"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.TextColor3 = Color3.white
closeButton.Font = Enum.Font.Gotham
closeButton.TextSize = 14
closeButton.Parent = popupFrame

-- Fungsi untuk menampilkan/menyembunyikan popup dengan animasi
local function togglePopup(visible)
    if visible then
        popupFrame.Visible = true
        popupFrame.Size = UDim2.new(0, 10, 0, 10)  -- Mulai dari ukuran kecil
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(popupFrame, tweenInfo, {
            Size = UDim2.new(0, 300, 0, 400)
        })
        tween:Play()
    else
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local tween = TweenService:Create(popupFrame, tweenInfo, {
            Size = UDim2.new(0, 10, 0, 10)
        })
        
        tween.Completed:Connect(function()
            popupFrame.Visible = false
        end)
        tween:Play()
    end
end

-- Fungsi untuk memperbarui daftar pemain
local function updatePlayerList()
    -- Hapus semua item yang ada
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
	
    -- Dapatkan semua pemain kecuali diri sendiri
    local allPlayers = Players:GetPlayers()
    
    for _, otherPlayer in ipairs(allPlayers) do
        if otherPlayer ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, -10, 0, 40)
            playerButton.Position = UDim2.new(0, 5, 0, 0)
            playerButton.Text = otherPlayer.Name
            playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            playerButton.TextColor3 = Color3.white
            playerButton.Font = Enum.Font.Gotham
            playerButton.TextSize = 14
            playerButton.Parent = scrollFrame
            
            -- Tambahkan efek hover
            playerButton.MouseEnter:Connect(function()
                playerButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            end)
            
            playerButton.MouseLeave:Connect(function()
                playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end)
            
            -- Hubungkan event klik untuk teleportasi
            playerButton.MouseButton1Click:Connect(function()
                -- Dapatkan karakter pemain target
                local targetCharacter = otherPlayer.Character
                
                if targetCharacter then
                    local humanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                    
                    if humanoidRootPart then
                        -- Dapatkan karakter pemain sendiri
                        local myCharacter = player.Character
                        
                        if myCharacter then
                            local myRootPart = myCharacter:FindFirstChild("HumanoidRootPart")
                            
                            if myRootPart then
                                -- Teleportasi ke posisi di depan pemain target :cite[5]
                                local offset = humanoidRootPart.CFrame.LookVector * 5
                                local newCFrame = humanoidRootPart.CFrame + offset + Vector3.new(0, 2, 0)
                                myRootPart.CFrame = CFrame.new(newCFrame.Position, humanoidRootPart.Position)
                                
                                -- Tutup popup setelah teleportasi
                                togglePopup(false)
                                
                                -- Tampilkan notifikasi :cite[9]
                                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                                    Text = "Berhasil teleportasi ke " .. otherPlayer.Name,
                                    Color = Color3.new(0, 1, 0),
                                    Font = Enum.Font.GothamBold,
                                    FontSize = Enum.FontSize.Size18
                                })
                            end
                        end
                    else
                        warn("Pemain target tidak memiliki HumanoidRootPart")
                    end
                else
                    warn("Pemain target tidak memiliki karakter")
                end
            end)
        end
    end
	
    -- Perbarui ukuran scroll area berdasarkan jumlah item
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

-- Hubungkan event ke tombol utama
mainButton.MouseButton1Click:Connect(function()
    togglePopup(true)
    updatePlayerList()
end)

-- Hubungkan event ke tombol tutup
closeButton.MouseButton1Click:Connect(function()
    togglePopup(false)
end)

-- Perbarui daftar ketika pemain bergabung/keluar
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Sesuaikan UI dengan perubahan ukuran layar
RunService.Heartbeat:Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end)
