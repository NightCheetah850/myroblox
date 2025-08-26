local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- GUI Elements
local screenGui = script.Parent
local flyToggle = screenGui:WaitForChild("FlyToggle")
local floatToggle = screenGui:WaitForChild("FloatToggle")
local wsSlider = screenGui:WaitForChild("WSSlider")
local wsValue = screenGui:WaitForChild("WSValue")

-- Settings
local flySpeed = 50
local floatHeight = 10
local isFlying = false
local isFloating = false
local flyConnection = nil
local floatConnection = nil

-- Function to enable flying
local function enableFly()
    if isFlying then return end
    isFlying = true
    humanoid.PlatformStand = true

    local camera = workspace.CurrentCamera
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
    bodyVelocity.Parent = rootPart

    flyConnection = RunService.Heartbeat:Connect(function()
        if not isFlying then return end
        
        local direction = Vector3.new(0, 0, 0)
        
        -- For mobile touch controls, you would need to implement touch movement here
        -- This is a simplified version for demonstration
        
        bodyVelocity.Velocity = direction * flySpeed
    end)
end

-- Function to disable flying
local function disableFly()
    if not isFlying then return end
    isFlying = false
    humanoid.PlatformStand = false
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    for _, object in ipairs(rootPart:GetChildren()) do
        if object:IsA("BodyVelocity") then
            object:Destroy()
        end
    end
end

-- Function to enable floating
local function enableFloat()
    if isFloating then return end
    isFloating = true
    humanoid.PlatformStand = true

    floatConnection = RunService.Heartbeat:Connect(function()
        if not isFloating then return end
        
        -- Maintain floating height
        rootPart.Velocity = Vector3.new(rootPart.Velocity.X, floatHeight, rootPart.Velocity.Z)
    end)
end

-- Function to disable floating
local function disableFloat()
    if not isFloating then return end
    isFloating = false
    humanoid.PlatformStand = false
    
    if floatConnection then
        floatConnection:Disconnect()
        floatConnection = nil
    end
end

-- Toggle fly with GUI button
flyToggle.MouseButton1Click:Connect(function()
    if isFlying then
        disableFly()
        flyToggle.Text = "Fly: OFF"
    else
        disableFloat() -- Ensure float is off when fly is on
        enableFly()
        flyToggle.Text = "Fly: ON"
    end
end)

-- Toggle float with GUI button
floatToggle.MouseButton1Click:Connect(function()
    if isFloating then
        disableFloat()
        floatToggle.Text = "Float: OFF"
    else
        disableFly() -- Ensure fly is off when float is on
        enableFloat()
        floatToggle.Text = "Float: ON"
    end
end)

-- Walkspeed change via GUI slider
wsSlider.Changed:Connect(function()
    local newSpeed = wsSlider.Value
    humanoid.WalkSpeed = newSpeed
    wsValue.Text = "WS: " .. newSpeed
end)
