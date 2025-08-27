-- Floating Menu Milky dengan Kontrol Joystick untuk Mobile
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MilkyFloatingMenu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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

-- Popup Window
local PopupFrame = Instance.new("Frame")
PopupFrame.Size = UDim2.new(0, 300, 0, 200)
PopupFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
PopupFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PopupFrame.BorderSizePixel = 0
PopupFrame.Visible = false
PopupFrame.Parent = ScreenGui

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 12)
PopupCorner.Parent = PopupFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Title.Text = "Milky Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = PopupFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

local Message = Instance.new("TextLabel")
Message.Size = UDim2.new(1, -20, 0, 40)
Message.Position = UDim2.new(0, 10, 0, 50)
Message.BackgroundTransparency = 1
Message.Text = "halo saya milky"
Message.TextColor3 = Color3.fromRGB(255, 255, 255)
Message.Font = Enum.Font.Gotham
Message.TextSize = 16
Message.Parent = PopupFrame

-- Fly Switch
local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(0, 260, 0, 30)
FlyFrame.Position = UDim2.new(0, 20, 0, 100)
FlyFrame.BackgroundTransparency = 1
FlyFrame.Parent = PopupFrame

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

-- Joystick untuk kontrol mobile
local JoystickFrame = Instance.new("Frame")
JoystickFrame.Size = UDim2.new(0, 120, 0, 120)
JoystickFrame.Position = UDim2.new(0, 50, 1, -170)
JoystickFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JoystickFrame.BackgroundTransparency = 0.5
JoystickFrame.BorderSizePixel = 0
JoystickFrame.Visible = false
JoystickFrame.Parent = ScreenGui

local JoystickCorner = Instance.new("UICorner")
JoystickCorner.CornerRadius = UDim.new(1, 0)
JoystickCorner.Parent = JoystickFrame

local JoystickThumb = Instance.new("Frame")
JoystickThumb.Size = UDim2.new(0, 50, 0, 50)
JoystickThumb.Position = UDim2.new(0.5, -25, 0.5, -25)
JoystickThumb.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
JoystickThumb.BorderSizePixel = 0
JoystickThumb.Parent = JoystickFrame

local JoystickThumbCorner = Instance.new("UICorner")
JoystickThumbCorner.CornerRadius = UDim.new(1, 0)
JoystickThumbCorner.Parent = JoystickThumb

-- Tombol untuk naik/turun (mobile)
local UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0, 60, 0, 60)
UpButton.Position = UDim2.new(1, -150, 1, -180)
UpButton.Text = "↑"
UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpButton.Font = Enum.Font.GothamBold
UpButton.TextSize = 24
UpButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
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

-- Variabel untuk joystick
local joystickActive = false
local joystickCenter = Vector2.new(0, 0)
local joystickRadius = 50

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

-- Fungsi untuk mengontrol joystick
local function initJoystick()
    JoystickFrame.Visible = true
    UpButton.Visible = true
    DownButton.Visible = true
    
    local joystickConnection
    local upButtonPressed = false
    local downButtonPressed = false
    
    -- Joystick movement
    JoystickFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            joystickActive = true
            joystickCenter = input.Position
        end
    end)
    
    JoystickFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch and joystickActive then
            local touchPos = input.Position
            local delta = touchPos - joystickCenter
            local direction = delta.Unit
            local magnitude = math.min(delta.Magnitude, joystickRadius)
            
            -- Update joystick thumb position
            JoystickThumb.Position = UDim2.new(0.5, direction.X * magnitude - 25, 0.5, direction.Y * magnitude - 25)
            
            -- Calculate movement direction based on camera
            local camera = workspace.CurrentCamera
            local moveDirection = Vector3.new(0, 0, 0)
            
            if magnitude > 10 then  -- Deadzone
                -- Horizontal movement (forward/backward/left/right)
                moveDirection = moveDirection + camera.CFrame.LookVector * direction.Y * flySpeed
                moveDirection = moveDirection + camera.CFrame.RightVector * direction.X * flySpeed
            end
            
            -- Apply movement
            if flyBodyVelocity then
                flyBodyVelocity.Velocity = Vector3.new(moveDirection.X, flyBodyVelocity.Velocity.Y, moveDirection.Z)
            end
        end
    end)
    
    JoystickFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            joystickActive = false
            -- Reset joystick position
            TweenService:Create(
                JoystickThumb,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0.5, -25, 0.5, -25)}
            ):Play()
            
            -- Stop horizontal movement
            if flyBodyVelocity then
                flyBodyVelocity.Velocity = Vector3.new(0, flyBodyVelocity.Velocity.Y, 0)
            end
        end
    end)
    
    -- Up button
    UpButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            upButtonPressed = true
            if flyBodyVelocity then
                flyBodyVelocity.Velocity = Vector3.new(flyBodyVelocity.Velocity.X, flySpeed, flyBodyVelocity.Velocity.Z)
            end
        end
    end)
    
    UpButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            upButtonPressed = false
            if flyBodyVelocity and not downButtonPressed then
                flyBodyVelocity.Velocity = Vector3.new(flyBodyVelocity.Velocity.X, 0, flyBodyVelocity.Velocity.Z)
            end
        end
    end)
    
    -- Down button
    DownButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            downButtonPressed = true
            if flyBodyVelocity then
                flyBodyVelocity.Velocity = Vector3.new(flyBodyVelocity.Velocity.X, -flySpeed, flyBodyVelocity.Velocity.Z)
            end
        end
    end)
    
    DownButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            downButtonPressed = false
            if flyBodyVelocity and not upButtonPressed then
                flyBodyVelocity.Velocity = Vector3.new(flyBodyVelocity.Velocity.X, 0, flyBodyVelocity.Velocity.Z)
            end
        end
    end)
end

-- Fungsi Fly yang Diperbaiki dengan Joystick
local function toggleFly()
    if isFlying then
        -- Nonaktifkan fly
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
        if flyBodyGyro then
            flyBodyGyro:Destroy()
            flyBodyGyro = nil
        end
        
        -- Sembunyikan joystick
        JoystickFrame.Visible = false
        UpButton.Visible = false
        DownButton.Visible = false
        
        -- Kembalikan gravitasi
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
        end
        
        isFlying = false
        
        -- Update UI
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
    else
        -- Aktifkan fly
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            if flyBodyGyro then flyBodyGyro:Destroy() end
            
            -- Buat BodyVelocity dan BodyGyro
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            flyBodyVelocity.Parent = character.HumanoidRootPart
            
            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            flyBodyGyro.P = 1000
            flyBodyGyro.D = 50
            flyBodyGyro.Parent = character.HumanoidRootPart
            
            -- Nonaktifkan gravitasi
            if character:FindFirstChildOfClass("Humanoid") then
                character:FindFirstChildOfClass("Humanoid").PlatformStand = true
            end
            
            -- Tampilkan joystick dan tombol kontrol
            initJoystick()
            
            isFlying = true
            
            -- Update UI
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
            
            -- Update orientation to match camera
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not isFlying or not flyBodyGyro then
                    connection:Disconnect()
                    return
                end
                
                local camera = workspace.CurrentCamera
                flyBodyGyro.CFrame = camera.CFrame
            end)
        end
    end
end

-- Event handlers untuk switch
FlySwitch.MouseButton1Click:Connect(toggleFly)

-- Popup Controls
FloatingButton.MouseButton1Click:Connect(function()
    PopupFrame.Visible = true
    PopupFrame.Size = UDim2.new(0, 0, 0, 0)
    PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    -- Animasi muncul
    TweenService:Create(
        PopupFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 300, 0, 200), Position = UDim2.new(0.5, -150, 0.5, -100)}
    ):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    -- Animasi menghilang
    TweenService:Create(
        PopupFrame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    ):Play()
    
    wait(0.2)
    PopupFrame.Visible = false
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

-- Auto clean up saat karakter mati atau respawn
local function onCharacterAdded(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if isFlying then
            toggleFly()
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

-- Notifikasi
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Milky Menu Loaded",
    Text = "Fly feature dengan joystick untuk mobile!",
    Duration = 5
})
