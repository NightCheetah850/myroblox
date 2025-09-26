-- 📁 LOCALSCRIPT: Tempatkan di StarterPlayerScripts
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Tunggu sampai player benar-benar siap
local function waitForPlayer()
    repeat 
        task.wait(1) 
    until player and player:IsDescendantOf(game)
    
    local playerGui = player:WaitForChild("PlayerGui")
    print("✅ Player ready:", player.Name)
    return playerGui
end

-- Deteksi currency system
local function detectCurrencySystem()
    local currencyData = {
        currencies = {},
        earningMethods = {},
        remoteEvents = {}
    }
    
    print("🔍 Memulai scan sistem currency...")
    
    -- 1. Deteksi Currency Values
    local function findCurrencies()
        local locations = {
            player,
            player:FindFirstChild("leaderstats"),
            player:FindFirstChild("Data"),
            player:FindFirstChild("Stats"),
            player:FindFirstChild("Currency")
        }
        
        for _, location in pairs(locations) do
            if location then
                for _, child in pairs(location:GetChildren()) do
                    if child:IsA("IntValue") or child:IsA("NumberValue") then
                        local nameLower = child.Name:lower()
                        if not string.find(nameLower, "level") and not string.find(nameLower, "exp") then
                            table.insert(currencyData.currencies, {
                                name = child.Name,
                                value = child.Value,
                                object = child,
                                location = location.Name
                            })
                            print("✅ Currency ditemukan:", child.Name, "=", child.Value)
                        end
                    end
                end
            end
        end
    end

    -- 2. Deteksi Remote Events
    local function findEarningRemotes()
        local remoteFolders = {
            ReplicatedStorage,
            ReplicatedStorage:FindFirstChild("Remotes"),
            ReplicatedStorage:FindFirstChild("Events")
        }
        
        for _, folder in pairs(remoteFolders) do
            if folder then
                for _, item in pairs(folder:GetChildren()) do
                    if item:IsA("RemoteEvent") then
                        local nameLower = item.Name:lower()
                        if string.find(nameLower, "coin") or string.find(nameLower, "money") then
                            table.insert(currencyData.remoteEvents, {
                                name = item.Name,
                                object = item,
                                type = "RemoteEvent"
                            })
                            print("✅ RemoteEvent ditemukan:", item.Name)
                        end
                    end
                end
            end
        end
    end

    -- 3. Deteksi Interaksi
    local function findInteractions()
        -- ClickDetectors
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                local parentName = obj.Parent.Name:lower()
                if string.find(parentName, "coin") or string.find(parentName, "money") then
                    table.insert(currencyData.earningMethods, {
                        type = "ClickDetector",
                        name = obj.Parent.Name,
                        object = obj,
                        description = "Klik: " .. obj.Parent.Name
                    })
                    print("✅ ClickDetector ditemukan:", obj.Parent.Name)
                end
            end
        end
    end

    findCurrencies()
    findEarningRemotes()
    findInteractions()
    
    return currencyData
end

-- Fungsi eksekusi method
local function executeEarningMethod(method)
    local success, result = pcall(function()
        if method.type == "RemoteEvent" then
            method.object:FireServer()
            return "RemoteEvent fired: " .. method.name
        elseif method.type == "ClickDetector" then
            method.object:FireServer()
            return "ClickDetector: " .. method.name
        end
        return "Unknown method type"
    end)
    
    return success, success and result or "Error: " .. tostring(result)
end

-- 🎨 BUAT GUI YANG PASTI MUNCUL
local function createCurrencyGUI(currencyData)
    -- Tunggu sampai PlayerGui siap
    local playerGui = waitForPlayer()
    
    -- Hapus GUI lama jika ada
    local oldGUI = playerGui:FindFirstChild("CurrencyAutomationGUI")
    if oldGUI then
        oldGUI:Destroy()
    end

    -- Buat ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CurrencyAutomationGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    screenGui.Enabled = true  -- PASTIKAN ENABLED TRUE

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = true  -- PASTIKAN VISIBLE TRUE
    mainFrame.Parent = screenGui

    -- UI Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = mainFrame

    -- Drop Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.Parent = mainFrame

    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 60)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    header.BorderSizePixel = 0
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "💰 CURRENCY AUTOMATION"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local subtitle = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "💰 CURRENCY AUTOMATION"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -20, 0, 20)
    subtitle.Position = UDim2.new(0, 10, 0, 35)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Methods: " .. #currencyData.earningMethods .. " | Currencies: " .. #currencyData.currencies
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header

    -- Content Area
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 0, 400)
    contentFrame.Position = UDim2.new(0, 10, 0, 70)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- Currency Display
    local currencyLabel = Instance.new("TextLabel")
    currencyLabel.Size = UDim2.new(1, 0, 0, 30)
    currencyLabel.Position = UDim2.new(0, 0, 0, 0)
    currencyLabel.BackgroundTransparency = 1
    currencyLabel.Text = "💰 Currencies:"
    currencyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    currencyLabel.Font = Enum.Font.GothamBold
    currencyLabel.TextSize = 14
    currencyLabel.TextXAlignment = Enum.TextXAlignment.Left
    currencyLabel.Parent = contentFrame

    local currencyText = Instance.new("TextLabel")
    currencyText.Size = UDim2.new(1, 0, 0, 60)
    currencyText.Position = UDim2.new(0, 0, 0, 30)
    currencyText.BackgroundTransparency = 1
    currencyText.Text = "Loading..."
    currencyText.TextColor3 = Color3.fromRGB(200, 200, 200)
    currencyText.Font = Enum.Font.Gotham
    currencyText.TextSize = 11
    currencyText.TextXAlignment = Enum.TextXAlignment.Left
    currencyText.TextYAlignment = Enum.TextYAlignment.Top
    currencyText.TextWrapped = true
    currencyText.Parent = contentFrame

    -- Update currency text
    local currencyInfo = ""
    for i, currency in ipairs(currencyData.currencies) do
        if i <= 3 then
            currencyInfo = currencyInfo .. "• " .. currency.name .. ": " .. tostring(currency.value) .. "\n"
        end
    end
    currencyText.Text = currencyInfo ~= "" and currencyInfo or "No currencies detected"

    -- Methods Section
    local methodsLabel = Instance.new("TextLabel")
    methodsLabel.Size = UDim2.new(1, 0, 0, 30)
    methodsLabel.Position = UDim2.new(0, 0, 0, 100)
    methodsLabel.BackgroundTransparency = 1
    methodsLabel.Text = "🎯 Earning Methods:"
    methodsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    methodsLabel.Font = Enum.Font.GothamBold
    methodsLabel.TextSize = 14
    methodsLabel.TextXAlignment = Enum.TextXAlignment.Left
    methodsLabel.Parent = contentFrame

    -- Methods Scroll Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, 0, 0, 200)
    scrollFrame.Position = UDim2.new(0, 0, 0, 130)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = contentFrame

    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 8)
    scrollCorner.Parent = scrollFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = scrollFrame

    -- Add methods to scroll frame
    for _, method in ipairs(currencyData.earningMethods) do
        local methodFrame = Instance.new("Frame")
        methodFrame.Size = UDim2.new(1, -10, 0, 50)
        methodFrame.Position = UDim2.new(0, 5, 0, 0)
        methodFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        methodFrame.Parent = scrollFrame

        local methodCorner = Instance.new("UICorner")
        methodCorner.CornerRadius = UDim.new(0, 6)
        methodCorner.Parent = methodFrame

        local methodName = Instance.new("TextLabel")
        methodName.Size = UDim2.new(0.7, 0, 1, 0)
        methodName.Position = UDim2.new(0, 10, 0, 0)
        methodName.BackgroundTransparency = 1
        methodName.Text = method.description
        methodName.TextColor3 = Color3.fromRGB(255, 255, 255)
        methodName.Font = Enum.Font.Gotham
        methodName.TextSize = 12
        methodName.TextXAlignment = Enum.TextXAlignment.Left
        methodName.Parent = methodFrame

        local executeBtn = Instance.new("TextButton")
        executeBtn.Size = UDim2.new(0.25, 0, 0.6, 0)
        executeBtn.Position = UDim2.new(0.73, 0, 0.2, 0)
        executeBtn.Text = "EXECUTE"
        executeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        executeBtn.Font = Enum.Font.GothamBold
        executeBtn.TextSize = 10
        executeBtn.Parent = methodFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = executeBtn

        -- Button functionality
        executeBtn.MouseButton1Click:Connect(function()
            executeBtn.Text = "⏳"
            executeBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
            
            local success, result = executeEarningMethod(method)
            
            if success then
                executeBtn.Text = "✅"
                executeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                print("✅ " .. result)
            else
                executeBtn.Text = "❌"
                executeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
                warn("❌ " .. result)
            end
            
            task.delay(2, function()
                executeBtn.Text = "EXECUTE"
                executeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            end)
        end)
    end

    -- Update scroll frame size
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #currencyData.earningMethods * 55)

    -- Control Buttons
    local controlFrame = Instance.new("Frame")
    controlFrame.Size = UDim2.new(1, 0, 0, 80)
    controlFrame.Position = UDim2.new(0, 0, 0, 340)
    controlFrame.BackgroundTransparency = 1
    controlFrame.Parent = contentFrame

    -- Execute All Button
    local executeAllBtn = Instance.new("TextButton")
    executeAllBtn.Size = UDim2.new(1, 0, 0, 40)
    executeAllBtn.Position = UDim2.new(0, 0, 0, 0)
    executeAllBtn.Text = "⚡ EXECUTE ALL METHODS"
    executeAllBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
    executeAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeAllBtn.Font = Enum.Font.GothamBold
    executeAllBtn.TextSize = 14
    executeAllBtn.Parent = controlFrame

    local executeCorner = Instance.new("UICorner")
    executeCorner.CornerRadius = UDim.new(0, 8)
    executeCorner.Parent = executeAllBtn

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(1, 0, 0, 30)
    closeBtn.Position = UDim2.new(0, 0, 0, 45)
    closeBtn.Text = "✕ CLOSE"
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 12
    closeBtn.Parent = controlFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    -- Execute All functionality
    executeAllBtn.MouseButton1Click:Connect(function()
        executeAllBtn.Text = "⏳ EXECUTING..."
        executeAllBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        
        local successCount = 0
        for i, method in ipairs(currencyData.earningMethods) do
            local success, result = executeEarningMethod(method)
            if success then
                successCount = successCount + 1
                print("✅ [" .. i .. "/" .. #currencyData.earningMethods .. "] " .. result)
            else
                print("❌ [" .. i .. "/" .. #currencyData.earningMethods .. "] " .. result)
            end
            task.wait(0.5)
        end
        
        executeAllBtn.Text = "✅ DONE (" .. successCount .. "/" .. #currencyData.earningMethods .. ")"
        executeAllBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        
        task.delay(3, function()
            executeAllBtn.Text = "⚡ EXECUTE ALL METHODS"
            executeAllBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
        end)
    end)

    -- Close functionality
    closeBtn.MouseButton1Click:Connect(function()
        screenGui.Enabled = false
    end)

    -- Toggle GUI with F6 key
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.F6 then
            screenGui.Enabled = not screenGui.Enabled
            print("GUI Toggled:", screenGui.Enabled)
        end
    end)

    -- Animation when opening
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 400, 0, 500),
        Position = UDim2.new(0.5, -200, 0.5, -250)
    })
    
    openTween:Play()

    print("✅ GUI created successfully!")
    return screenGui
end

-- 🚀 MAIN EXECUTION
local function main()
    print("🎮 Starting Currency Automation System...")
    
    -- Tunggu sampai game fully loaded
    task.wait(3)
    
    -- Deteksi sistem currency
    local currencyData = detectCurrencySystem()
    
    if #currencyData.earningMethods > 0 then
        -- Buat GUI
        local gui = createCurrencyGUI(currencyData)
        
        print("✨ System ready! Press F6 to toggle GUI")
        print("📊 Detected: " .. #currencyData.earningMethods .. " methods, " .. #currencyData.currencies .. " currencies")
        
        -- Notifikasi sukses
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Currency Automation",
            Text = "System loaded! Press F6 to open GUI",
            Duration = 5
        })
    else
        warn("❌ No earning methods detected!")
        
        -- Notifikasi error
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Currency Automation",
            Text = "No earning methods found in this game",
            Duration = 5
        })
    end
end

-- Jalankan main function dengan error handling
local success, errorMsg = pcall(main)
if not success then
    warn("❌ Error in main function:", errorMsg)
    
    -- Error notification
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Error",
        Text = "Check output for details",
        Duration = 5
    })
end
