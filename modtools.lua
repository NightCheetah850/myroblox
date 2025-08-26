-- Roblox Moderator Tools by @NexusTech
-- Fitur: Teleport to Player, Fly Mode, Player Monitoring

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Konfigurasi
local ADMIN_USERNAME = "Rhamaardian" -- Ganti dengan username Roblox Anda
local TELEPORT_DURATION = 1.5 -- Durasi teleportasi dalam detik
local FLY_SPEED = 2 -- Kecepatan terbang

-- Variabel global
local flyEnabled = false
local flyConnections = {}
local playerGui = nil

-- Cek apakah pemain adalah admin/pemilik
local function isAdmin(player)
    return player.Name == ADMIN_USERNAME or player.UserId == game.CreatorId
end

-- Membuat notifikasi
local function createNotification(text, duration)
    if not playerGui then return end
    
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "NotificationGui"
    notificationGui.Parent = playerGui
    notificationGui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.Position = UDim2.new(0.5, -150, 0.1, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Parent = notificationGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, -20)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextWrapped = true
    label.Parent = frame
    
    -- Animasi masuk
    frame.Position = UDim2.new(0.5, -150, 0, -60)
    local tweenIn = TweenService:Create(
        frame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -150, 0.1, 0)}
    )
    tweenIn:Play()
    
    -- Animasi keluar setelah durasi tertentu
    delay(duration, function()
        local tweenOut = TweenService:Create(
            frame,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Position = UDim2.new(0.5, -150, 0, -60)}
        )
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            notificationGui:Destroy()
        end)
    end)
end

-- Fungsi untuk membuat GUI form
local function createTeleportGUI()
    if not playerGui then return end
    
    -- Hapus GUI lama jika ada
    if playerGui:FindFirstChild("TeleportGui") then
        playerGui.TeleportGui:Destroy()
    end
    
    -- Buat GUI baru
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TeleportGui"
    screenGui.Parent = playerGui
    screenGui.ResetOnSpawn = false
    
    -- Frame utama
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Judul
    local title = Instance.new("TextLabel")
    title.Text = "Moderator Tools"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title
    
    -- Tombol tutup
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.Parent = mainFrame
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Daftar pemain
    local playerList = Instance.new("ScrollingFrame")
    playerList.Size = UDim2.new(1, -20, 1, -150)
    playerList.Position = UDim2.new(0, 10, 0, 50)
    playerList.BackgroundTransparency = 1
    playerList.ScrollBarThickness = 5
    playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
    playerList.Parent = mainFrame
    
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = playerList
    uiListLayout.Padding = UDim.new(0, 5)
    
    uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        playerList.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y)
    end)
    
    -- Tombol fly/unfly
    local flyButton = Instance.new("TextButton")
    flyButton.Text = "FLY: OFF"
    flyButton.Size = UDim2.new(1, -20, 0, 40)
    flyButton.Position = UDim2.new(0, 10, 1, -90)
    flyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyButton.Font = Enum.Font.GothamBold
    flyButton.TextSize = 16
    flyButton.Parent = mainFrame
    
    flyButton.MouseButton1Click:Connect(function()
        if flyEnabled then
            flyEnabled = false
            flyButton.Text = "FLY: OFF"
            flyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            createNotification("Fly mode disabled", 2)
        else
            flyEnabled = true
            flyButton.Text = "FLY: ON"
            flyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            createNotification("Fly mode enabled", 2)
        end
    end)
    
    -- Fungsi untuk memperbarui daftar pemain
    local function updatePlayerList()
        for _, child in ipairs(playerList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local localPlayer = Players.LocalPlayer
        if not localPlayer or not localPlayer.Character then return end
        
        local localPosition = localPlayer.Character:GetPivot().Position
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local playerButton = Instance.new("TextButton")
                playerButton.Size = UDim2.new(1, 0, 0, 40)
                playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                playerButton.BorderSizePixel = 0
                
                local distance = (player.Character:GetPivot().Position - localPosition).Magnitude
                playerButton.Text = player.Name .. " | " .. tostring(math.floor(distance)) .. " studs"
                
                playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                playerButton.Font = Enum.Font.Gotham
                playerButton.TextSize = 14
                playerButton.Parent = playerList
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 4)
                buttonCorner.Parent = playerButton
                
                playerButton.MouseButton1Click:Connect(function()
                    local targetCharacter = player.Character
                    if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            -- Simpan posisi sebelumnya untuk kembali
                            local previousPosition = localPlayer.Character:GetPivot()
                            
                            -- Teleportasi ke pemain target dengan tween
                            local tweenInfo = TweenInfo.new(
                                TELEPORT_DURATION,
                                Enum.EasingStyle.Quad,
                                Enum.EasingDirection.Out
                            )
                            
                            local tween = TweenService:Create(
                                localPlayer.Character.HumanoidRootPart,
                                tweenInfo,
                                {CFrame = targetCharacter.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)}
                            )
                            
                            tween:Play()
                            createNotification("Teleporting to " .. player.Name, 2)
                            
                            -- Buat tombol kembali
                            if mainFrame:FindFirstChild("ReturnButton") then
                                mainFrame.ReturnButton:Destroy()
                            end
                            
                            local returnButton = Instance.new("TextButton")
                            returnButton.Name = "ReturnButton"
                            returnButton.Text = "Return to Previous Position"
                            returnButton.Size = UDim2.new(1, -20, 0, 40)
                            returnButton.Position = UDim2.new(0, 10, 1, -40)
                            returnButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
                            returnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                            returnButton.Font = Enum.Font.GothamBold
                            returnButton.TextSize = 14
                            returnButton.Parent = mainFrame
                            
                            local returnCorner = Instance.new("UICorner")
                            returnCorner.CornerRadius = UDim.new(0, 4)
                            returnCorner.Parent = returnButton
                            
                            returnButton.MouseButton1Click:Connect(function()
                                local returnTween = TweenService:Create(
                                    localPlayer.Character.HumanoidRootPart,
                                    tweenInfo,
                                    {CFrame = previousPosition}
                                )
                                
                                returnTween:Play()
                                returnButton:Destroy()
                                createNotification("Returning to previous position", 2)
                            end)
                        end
                    else
                        createNotification("Target player character not found", 2)
                    end
                end)
            end
        end
    end
    
    -- Perbarui daftar pemain secara berkala
    local updateConnection
    updateConnection = RunService.Heartbeat:Connect(function()
        updatePlayerList()
    end)
    
    -- Hentikan update ketika GUI dihancurkan
    screenGui.Destroying:Connect(function()
        updateConnection:Disconnect()
    end)
    
    -- Perbarui daftar pertama kali
    updatePlayerList()
end

-- Fungsi untuk mengaktifkan/menonaktifkan fly mode
local function toggleFlyMode()
    local player = Players.LocalPlayer
    if not player or not player.Character then return end
    
    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    if flyEnabled then
        -- Aktifkan fly mode
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
        bodyVelocity.Name = "FlyBodyVelocity"
        bodyVelocity.Parent = humanoidRootPart
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.P = 1000
        bodyGyro.D = 100
        bodyGyro.Name = "FlyBodyGyro"
        bodyGyro.Parent = humanoidRootPart
        
        -- Simpan koneksi untuk kontrol fly
        table.insert(flyConnections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == Enum.KeyCode.Space then
                bodyVelocity.Velocity = Vector3.new(0, FLY_SPEED, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                bodyVelocity.Velocity = Vector3.new(0, -FLY_SPEED, 0)
            end
        end))
        
        table.insert(flyConnections, UserInputService.InputEnded:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
        end))
        
        createNotification("Fly mode enabled. Use SPACE to go up, SHIFT to go down.", 3)
    else
        -- Nonaktifkan fly mode
        for _, connection in ipairs(flyConnections) do
            connection:Disconnect()
        end
        flyConnections = {}
        
        if humanoidRootPart:FindFirstChild("FlyBodyVelocity") then
            humanoidRootPart.FlyBodyVelocity:Destroy()
        end
        
        if humanoidRootPart:FindFirstChild("FlyBodyGyro") then
            humanoidRootPart.FlyBodyGyro:Destroy()
        end
        
        createNotification("Fly mode disabled", 2)
    end
end

-- Fungsi untuk membuka GUI dengan command
local function onChatMessage(message, player)
    if not isAdmin(player) then return end
    
    if string.lower(message) == "/modtools" then
        createTeleportGUI()
        return
    end
end

-- Inisialisasi
local function initialize()
    local player = Players.LocalPlayer
    if not player then return end
    
    -- Cek apakah pemain adalah admin
    if not isAdmin(player) then
        createNotification("Moderator tools are only available for admins", 5)
        return
    end
    
    playerGui = player:WaitForChild("PlayerGui")
    
    -- Buat notifikasi bahwa tools tersedia
    createNotification("Moderator tools loaded. Type /modtools to open the menu.", 5)
    
    -- Daftarkan event listener untuk chat
    Players.PlayerChatted:Connect(onChatMessage)
    
    -- Update fly mode secara berkala
    RunService.Heartbeat:Connect(function()
        toggleFlyMode()
    end)
end

-- Jalankan inisialisasi
if Players.LocalPlayer then
    initialize()
else
    Players.PlayerAdded:Connect(initialize)
end
