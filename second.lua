-- Floating Menu dengan Popup untuk Delta Executor
-- Oleh: Milky

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MilkyFloatingMenu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Floating Button
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 50, 0, 50)
FloatingButton.Position = UDim2.new(0, 100, 0, 100)
FloatingButton.Text = "Menu"
FloatingButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
FloatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.TextSize = 14
FloatingButton.AutoButtonColor = false
FloatingButton.Active = true
FloatingButton.Draggable = false
FloatingButton.Selectable = false
FloatingButton.Parent = ScreenGui

-- Popup Window
local PopupFrame = Instance.new("Frame")
PopupFrame.Size = UDim2.new(0, 200, 0, 150)
PopupFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
PopupFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PopupFrame.Visible = false
PopupFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = PopupFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Greeting"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = PopupFrame

local Message = Instance.new("TextLabel")
Message.Size = UDim2.new(1, -20, 0, 50)
Message.Position = UDim2.new(0, 10, 0, 40)
Message.BackgroundTransparency = 1
Message.Text = "halo saya milky"
Message.TextColor3 = Color3.fromRGB(255, 255, 255)
Message.Font = Enum.Font.Gotham
Message.TextSize = 14
Message.Parent = PopupFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = PopupFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = CloseButton

-- Drag Functionality
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    FloatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Popup Controls
FloatingButton.MouseButton1Click:Connect(function()
    PopupFrame.Visible = true
    PopupFrame.Size = UDim2.new(0, 0, 0, 0)
    PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(
        PopupFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 200, 0, 150), Position = UDim2.new(0.5, -100, 0.5, -75)}
    ):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(
        PopupFrame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    ):Play()
    
    wait(0.2)
    PopupFrame.Visible = false
end)
