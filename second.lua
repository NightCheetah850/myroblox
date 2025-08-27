-- Floating Menu Milky dengan Fitur Fly dan Float yang Diperbaiki
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
PopupFrame.Size = UDim2.new(0, 300, 0, 250)
PopupFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
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
FlyLabel.Text = "Fly:"
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
FloatFrame.Position = UDim2.new(0, 20, 0, 140)
FloatFrame.BackgroundTransparency = 1
FloatFrame.Parent = PopupFrame

local FloatLabel = Instance.new("TextLabel")
FloatLabel.Size = UDim2.new(0, 100, 1, 0)
FloatLabel.Position = UDim2.new(0, 0, 0, 0)
FloatLabel.BackgroundTransparency = 1
FloatLabel.Text = "Float:"
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

-- Variabel untuk drag functionality
local dragging = false
local dragInput, dragStart, startPos

-- Variabel untuk fly dan float
local isFlying = false
local isFloating = false
local flyAlignPos, flyAlignOri
local floatBodyVelocity

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

-- Fungsi Fly yang Diperbaiki (seperti Infinite Yield)
local function toggleFly()
    if isFlying then
        -- Nonaktifkan fly
        if flyAlignPos then
            flyAlignPos:Destroy()
            flyAlignPos = nil
        end
        if flyAlignOri then
            flyAlignOri:Destroy()
            flyAlignOri = nil
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
            if flyAlignPos then flyAlignPos:Destroy() end
            if flyAlignOri then flyAlignOri:Destroy() end
            
            -- Gunakan AlignPosition dan AlignOrientation seperti Infinite Yield
            flyAlignPos = Instance.new("AlignPosition")
            flyAlignPos.MaxForce = 9e9
            flyAlignPos.Responsiveness = 200
            flyAlignPos.Parent = character.HumanoidRootPart
            
            flyAlignOri = Instance.new("AlignOrientation")
            flyAlignOri.MaxTorque = 9e9
            flyAlignOri.Responsiveness = 200
            flyAlignOri.Parent = character.HumanoidRootPart
            
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
            
            -- Fly movement handler
            local flySpeed = 50
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not isFlying or not flyAlignPos then
                    connection:Disconnect()
                    return
                end
                
                local camera = workspace.CurrentCamera
                local rootPart = character.HumanoidRootPart
                
                -- Update orientation to match camera
                flyAlignOri.CFrame = camera.CFrame
                
                -- Calculate movement direction
                local moveDirection = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, 1, 0)
                end
                
                -- Normalize and apply speed
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit * flySpeed
                end
                
                -- Apply movement
                flyAlignPos.Position = rootPart.Position + moveDirection
            end)
        end
    end
end

-- Fungsi Float yang Diperbaiki
local function toggleFloat()
    if isFloating then
        -- Nonaktifkan float
        if floatBodyVelocity then
            floatBodyVelocity:Destroy()
            floatBodyVelocity = nil
        end
        isFloating = false
        
        -- Update UI
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
    else
        -- Aktifkan float
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if floatBodyVelocity then floatBodyVelocity:Destroy() end
            
            floatBodyVelocity = Instance.new("BodyVelocity")
            floatBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            floatBodyVelocity.MaxForce = Vector3.new(0, 9e9, 0)
            floatBodyVelocity.Parent = character.HumanoidRootPart
            
            -- Buat karakter mengambang
            floatBodyVelocity.Velocity = Vector3.new(0, 5, 0)
            
            isFloating = true
            
            -- Update UI
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
            
            -- Float maintenance loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not isFloating or not floatBodyVelocity then
                    connection:Disconnect()
                    return
                end
                
                -- Pertahankan kecepatan float
                floatBodyVelocity.Velocity = Vector3.new(0, 5, 0)
            end)
        end
    end
end

-- Event handlers untuk switch
FlySwitch.MouseButton1Click:Connect(toggleFly)
FloatSwitch.MouseButton1Click:Connect(toggleFloat)

-- Popup Controls
FloatingButton.MouseButton1Click:Connect(function()
    PopupFrame.Visible = true
    PopupFrame.Size = UDim2.new(0, 0, 0, 0)
    PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    -- Animasi muncul
    TweenService:Create(
        PopupFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 300, 0, 250), Position = UDim2.new(0.5, -150, 0.5, -125)}
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
setupSwitchHover(FloatSwitch, FloatToggle)

-- Auto clean up saat karakter mati atau respawn
local function onCharacterAdded(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if isFlying then
            toggleFly()
        end
        if isFloating then
            toggleFloat()
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

-- Kontrol fly dengan keyboard (WASD, Space, Shift)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if isFlying then
        if input.KeyCode == Enum.KeyCode.Space then
            -- Ditangani dalam fly loop
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            -- Ditangani dalam fly loop
        end
    end
end)

-- Notifikasi
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Milky Menu Loaded",
    Text = "Fly and Float features improved!",
    Duration = 5
})
