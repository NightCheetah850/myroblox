-- 📁 FULL CLIENT-SIDE CURRENCY AUTOMATION SCRIPT
-- Tempatkan di StarterPlayerScripts atau StarterGui
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Tunggu hingga player ready
player:WaitForChild("PlayerGui")

-- 🎯 VARIABEL UTAMA
local currencyData = {
    currencies = {},
    earningMethods = {},
    remoteEvents = {}
}

local autoFarm = {
    enabled = false,
    interval = 5, -- detik antara eksekusi
    currentCycle = 0,
    totalCycles = 0
}

-- 🔍 SISTEM DETEKSI CURRENCY
local function detectCurrencySystem()
    print("🔍 Memulai scan sistem currency...")
    
    -- 1. DETEKSI CURRENCY VALUES
    local function findCurrencies()
        local locations = {
            player,
            player:FindFirstChild("leaderstats"),
            player:FindFirstChild("Data"),
            player:FindFirstChild("Stats"),
            player:FindFirstChild("Currency"),
            player:FindFirstChild("PlayerData"),
            player:FindFirstChild("Values")
        }
        
        for _, location in pairs(locations) do
            if location then
                for _, child in pairs(location:GetChildren()) do
                    if child:IsA("IntValue") or child:IsA("NumberValue") or child:IsA("StringValue") then
                        local nameLower = child.Name:lower()
                        -- Filter out non-currency values
                        if not string.find(nameLower, "level") and 
                           not string.find(nameLower, "exp") and
                           not string.find(nameLower, "score") and
                           not string.find(nameLower, "point") then
                            
                            table.insert(currencyData.currencies, {
                                name = child.Name,
                                value = child.Value,
                                object = child,
                                location = location.Name,
                                type = child.ClassName
                            })
                            print("✅ Currency: " .. child.Name .. " = " .. tostring(child.Value) .. " (" .. location.Name .. ")")
                        end
                    end
                end
            end
        end
    end

    -- 2. DETEKSI REMOTE EVENTS/FUNCTIONS
    local function findEarningRemotes()
        local remoteFolders = {
            ReplicatedStorage,
            ReplicatedStorage:FindFirstChild("Remotes"),
            ReplicatedStorage:FindFirstChild("Events"),
            ReplicatedStorage:FindFirstChild("RemoteEvents"),
            ReplicatedStorage:FindFirstChild("Network")
        }
        
        for _, folder in pairs(remoteFolders) do
            if folder then
                for _, item in pairs(folder:GetDescendants()) do
                    if item:IsA("RemoteEvent") or item:IsA("RemoteFunction") then
                        local nameLower = item.Name:lower()
                        
                        -- Keyword detection untuk earning-related remotes
                        local earningKeywords = {
                            "coin", "money", "currency", "reward", "collect", 
                            "earn", "claim", "add", "give", "bonus", "daily",
                            "quest", "mission", "task", "achievement"
                        }
                        
                        for _, keyword in pairs(earningKeywords) do
                            if string.find(nameLower, keyword) then
                                table.insert(currencyData.remoteEvents, {
                                    name = item.Name,
                                    object = item,
                                    type = item.ClassName,
                                    path = item:GetFullName()
                                })
                                print("✅ Remote: " .. item.Name .. " (" .. item.ClassName .. ")")
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    -- 3. DETEKSI INTERAKSI FISIK
    local function findPhysicalInteractions()
        -- ClickDetectors
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                local parentName = obj.Parent.Name:lower()
                local earningKeywords = {"coin", "money", "chest", "reward", "treasure", "gold"}
                
                for _, keyword in pairs(earningKeywords) do
                    if string.find(parentName, keyword) then
                        table.insert(currencyData.earningMethods, {
                            type = "ClickDetector",
                            name = obj.Parent.Name,
                            object = obj,
                            description = "Klik: " .. obj.Parent.Name,
                            category = "Physical"
                        })
                        print("✅ Physical: ClickDetector - " .. obj.Parent.Name)
                        break
                    end
                end
            end
            
            -- ProximityPrompts
            if obj:IsA("ProximityPrompt") then
                local parentName = obj.Parent.Name:lower()
                local earningKeywords = {"coin", "money", "quest", "reward", "npc", "vendor"}
                
                for _, keyword in pairs(earningKeywords) do
                    if string.find(parentName, keyword) then
                        table.insert(currencyData.earningMethods, {
                            type = "ProximityPrompt",
                            name = obj.Parent.Name,
                            object = obj,
                            description = "Interaksi: " .. obj.Parent.Name,
                            category = "Physical"
                        })
                        print("✅ Physical: ProximityPrompt - " .. obj.Parent.Name)
                        break
                    end
                end
            end
            
            -- Touch Interests (Trigger pada part)
            if obj:IsA("TouchTransmitter") then
                local parent = obj.Parent
                if parent and parent:IsA("BasePart") then
                    local parentName = parent.Name:lower()
                    local earningKeywords = {"coin", "money", "reward", "zone", "area"}
                    
                    for _, keyword in pairs(earningKeywords) do
                        if string.find(parentName, keyword) then
                            table.insert(currencyData.earningMethods, {
                                type = "TouchInterest",
                                name = parent.Name,
                                object = parent,
                                description = "Sentuh: " .. parent.Name,
                                category = "Physical"
                            })
                            print("✅ Physical: TouchInterest - " .. parent.Name)
                            break
                        end
                    end
                end
            end
        end
    end

    -- 4. DETEKSI GUI INTERACTIONS
    local function findGUIInteractions()
        local gui = player:WaitForChild("PlayerGui")
        
        local function scanGUI(guiObject)
            for _, child in pairs(guiObject:GetChildren()) do
                -- Check buttons
                if child:IsA("TextButton") or child:IsA("ImageButton") then
                    local textLower = (child.Text or ""):lower()
                    local nameLower = child.Name:lower()
                    
                    local earningKeywords = {
                        "claim", "collect", "reward", "earn", "get", "obtain",
                        "redeem", "open", "spin", "daily", "reward"
                    }
                    
                    for _, keyword in pairs(earningKeywords) do
                        if string.find(textLower, keyword) or string.find(nameLower, keyword) then
                            table.insert(currencyData.earningMethods, {
                                type = "GUIButton",
                                name = child.Name,
                                object = child,
                                description = "Button: " .. (child.Text or child.Name),
                                category = "GUI"
                            })
                            print("✅ GUI: Button - " .. child.Name)
                            break
                        end
                    end
                end
                
                -- Check text labels yang bisa diklik (via script)
                if child:IsA("TextLabel") or child:IsA("ImageLabel") then
                    if child:FindFirstChildWhichIsA("ClickDetector") then
                        table.insert(currencyData.earningMethods, {
                            type = "GUIClickable",
                            name = child.Name,
                            object = child,
                            description = "Klik Label: " .. child.Name,
                            category = "GUI"
                        })
                        print("✅ GUI: Clickable Label - " .. child.Name)
                    end
                end
                
                -- Recursive scan
                scanGUI(child)
            end
        end
        
        for _, screenGui in pairs(gui:GetChildren()) do
            if screenGui:IsA("ScreenGui") then
                scanGUI(screenGui)
            end
        end
    end

    -- 5. DETEKSI REMOTE-BASED EARNING METHODS
    local function createRemoteEarningMethods()
        for _, remote in pairs(currencyData.remoteEvents) do
            table.insert(currencyData.earningMethods, {
                type = remote.type,
                name = remote.name,
                object = remote.object,
                description = remote.type .. ": " .. remote.name,
                category = "Remote",
                path = remote.path
            })
        end
    end

    -- EKSEKUSI SEMUA DETEKSI
    findCurrencies()
    findEarningRemotes()
    findPhysicalInteractions()
    findGUIInteractions()
    createRemoteEarningMethods()
    
    print("📊 Scan selesai: " .. #currencyData.currencies .. " currencies, " .. #currencyData.earningMethods .. " metode earning")
    return currencyData
end

-- ⚡ SISTEM EKSEKUSI METHOD
local function executeEarningMethod(method)
    local success, result = pcall(function()
        if method.type == "RemoteEvent" then
            method.object:FireServer()
            return "RemoteEvent fired: " .. method.name
            
        elseif method.type == "RemoteFunction" then
            local result = method.object:InvokeServer()
            return "RemoteFunction invoked: " .. method.name .. " → " .. tostring(result)
            
        elseif method.type == "ClickDetector" then
            -- Cari player character
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart then
                -- Teleport ke objek jika terlalu jauh
                local objPosition = method.object.Parent.Position
                if (humanoidRootPart.Position - objPosition).Magnitude > 10 then
                    humanoidRootPart.CFrame = CFrame.new(objPosition + Vector3.new(0, 3, 0))
                    task.wait(0.5)
                end
            end
            
            method.object:FireServer()
            return "ClickDetector: " .. method.name
            
        elseif method.type == "ProximityPrompt" then
            method.object.Triggered:Wait()
            return "ProximityPrompt: " .. method.name
            
        elseif method.type == "TouchInterest" then
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart then
                humanoidRootPart.CFrame = CFrame.new(method.object.Position + Vector3.new(0, 3, 0))
                task.wait(0.5)
            end
            
            return "TouchInterest: " .. method.name
            
        elseif method.type == "GUIButton" then
            -- Simulate button click
            if method.object:IsA("TextButton") or method.object:IsA("ImageButton") then
                method.object:Fire("MouseButton1Click")
            end
            return "GUI Button: " .. method.name
            
        elseif method.type == "GUIClickable" then
            -- Trigger click detector pada label
            local clickDetector = method.object:FindFirstChildWhichIsA("ClickDetector")
            if clickDetector then
                clickDetector:FireServer()
            end
            return "GUI Clickable: " .. method.name
        end
        
        return "Unknown method type: " .. tostring(method.type)
    end)
    
    return success, success and result or "Error: " .. tostring(result)
end

-- 🤖 SISTEM AUTO-FARM
local function setupAutoFarmSystem()
    local farmLoop = nil
    
    local function startAutoFarm()
        if autoFarm.enabled then return end
        
        autoFarm.enabled = true
        autoFarm.totalCycles = 0
        
        farmLoop = task.spawn(function()
            while autoFarm.enabled do
                autoFarm.currentCycle = 0
                autoFarm.totalCycles += 1
                
                print("🔄 Auto-Farm Cycle #" .. autoFarm.totalCycles)
                
                for i, method in ipairs(currencyData.earningMethods) do
                    if not autoFarm.enabled then break end
                    
                    autoFarm.currentCycle = i
                    local success, result = executeEarningMethod(method)
                    
                    if success then
                        print("✅ [" .. i .. "/" .. #currencyData.earningMethods .. "] " .. result)
                    else
                        print("❌ [" .. i .. "/" .. #currencyData.earningMethods .. "] " .. result)
                    end
                    
                    -- Delay antara methods
                    task.wait(1)
                end
                
                if autoFarm.enabled then
                    print("⏳ Menunggu " .. autoFarm.interval .. " detik hingga cycle berikutnya...")
                    task.wait(autoFarm.interval)
                end
            end
        end)
    end
    
    local function stopAutoFarm()
        autoFarm.enabled = false
        if farmLoop then
            task.cancel(farmLoop)
            farmLoop = nil
        end
    end
    
    local function setInterval(newInterval)
        autoFarm.interval = math.max(1, newInterval) -- Minimum 1 detik
    end
    
    return {
        start = startAutoFarm,
        stop = stopAutoFarm,
        setInterval = setInterval,
        getStatus = function() return autoFarm end
    }
end

-- 🎨 PEMBUATAN GUI
local function createAutomationGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CurrencyAutomationPro"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui

    -- Main Container
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 700)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -350)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.Parent = screenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = mainFrame

    -- Drop Shadow Effect
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.Parent = mainFrame

    -- Header Section
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 70)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "🤖 CURRENCY AUTOMATION PRO"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -20, 0, 20)
    subtitle.Position = UDim2.new(0, 10, 0, 45)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Detected: " .. #currencyData.currencies .. " currencies, " .. #currencyData.earningMethods .. " methods"
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header

    -- Currency Display
    local currencyFrame = Instance.new("Frame")
    currencyFrame.Size = UDim2.new(1, -20, 0, 100)
    currencyFrame.Position = UDim2.new(0, 10, 0, 80)
    currencyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    currencyFrame.Parent = mainFrame

    local currencyCorner = Instance.new("UICorner")
    currencyCorner.CornerRadius = UDim.new(0, 8)
    currencyCorner.Parent = currencyFrame

    local currencyTitle = Instance.new("TextLabel")
    currencyTitle.Size = UDim2.new(1, -10, 0, 25)
    currencyTitle.Position = UDim2.new(0, 10, 0, 5)
    currencyTitle.BackgroundTransparency = 1
    currencyTitle.Text = "💰 CURRENT CURRENCIES"
    currencyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    currencyTitle.Font = Enum.Font.GothamBold
    currencyTitle.TextSize = 14
    currencyTitle.TextXAlignment = Enum.TextXAlignment.Left
    currencyTitle.Parent = currencyFrame

    local currencyScroller = Instance.new("ScrollingFrame")
    currencyScroller.Size = UDim2.new(1, -10, 0, 65)
    currencyScroller.Position = UDim2.new(0, 5, 0, 35)
    currencyScroller.BackgroundTransparency = 1
    currencyScroller.ScrollBarThickness = 4
    currencyScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    currencyScroller.Parent = currencyFrame

    local currencyLayout = Instance.new("UIListLayout")
    currencyLayout.Padding = UDim.new(0, 5)
    currencyLayout.Parent = currencyScroller

    -- Isi currency list
    for _, currency in ipairs(currencyData.currencies) do
        local currencyItem = Instance.new("TextLabel")
        currencyItem.Size = UDim2.new(1, 0, 0, 20)
        currencyItem.BackgroundTransparency = 1
        currencyItem.Text = "• " .. currency.name .. ": " .. tostring(currency.value) .. " (" .. currency.location .. ")"
        currencyItem.TextColor3 = Color3.fromRGB(200, 200, 255)
        currencyItem.Font = Enum.Font.Gotham
        currencyItem.TextSize = 11
        currencyItem.TextXAlignment = Enum.TextXAlignment.Left
        currencyItem.Parent = currencyScroller
    end
    currencyScroller.CanvasSize = UDim2.new(0, 0, 0, #currencyData.currencies * 25)

    -- Auto-Farm Control Section
    local farmFrame = Instance.new("Frame")
    farmFrame.Size = UDim2.new(1, -20, 0, 120)
    farmFrame.Position = UDim2.new(0, 10, 0, 190)
    farmFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    farmFrame.Parent = mainFrame

    local farmCorner = Instance.new("UICorner")
    farmCorner.CornerRadius = UDim.new(0, 8)
    farmCorner.Parent = farmFrame

    local farmTitle = Instance.new("TextLabel")
    farmTitle.Size = UDim2.new(1, -10, 0, 25)
    farmTitle.Position = UDim2.new(0, 10, 0, 5)
    farmTitle.BackgroundTransparency = 1
    farmTitle.Text = "⚡ AUTO-FARM SYSTEM"
    farmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    farmTitle.Font = Enum.Font.GothamBold
    farmTitle.TextSize = 14
    farmTitle.TextXAlignment = Enum.TextXAlignment.Left
    farmTitle.Parent = farmFrame

    -- Interval Control
    local intervalFrame = Instance.new("Frame")
    intervalFrame.Size = UDim2.new(1, -20, 0, 30)
    intervalFrame.Position = UDim2.new(0, 10, 0, 35)
    intervalFrame.BackgroundTransparency = 1
    intervalFrame.Parent = farmFrame

    local intervalLabel = Instance.new("TextLabel")
    intervalLabel.Size = UDim2.new(0.5, 0, 1, 0)
    intervalLabel.Position = UDim2.new(0, 0, 0, 0)
    intervalLabel.BackgroundTransparency = 1
    intervalLabel.Text = "Interval (detik):"
    intervalLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    intervalLabel.Font = Enum.Font.Gotham
    intervalLabel.TextSize = 12
    intervalLabel.TextXAlignment = Enum.TextXAlignment.Left
    intervalLabel.Parent = intervalFrame

    local intervalBox = Instance.new("TextBox")
    intervalBox.Size = UDim2.new(0.3, 0, 1, 0)
    intervalBox.Position = UDim2.new(0.5, 0, 0, 0)
    intervalBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    intervalBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    intervalBox.Text = tostring(autoFarm.interval)
    intervalBox.Font = Enum.Font.Gotham
    intervalBox.TextSize = 12
    intervalBox.Parent = intervalFrame

    local intervalCorner = Instance.new("UICorner")
    intervalCorner.CornerRadius = UDim.new(0, 4)
    intervalCorner.Parent = intervalBox

    -- Farm Control Buttons
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, -20, 0, 40)
    buttonFrame.Position = UDim2.new(0, 10, 0, 70)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = farmFrame

    local startFarmBtn = Instance.new("TextButton")
    startFarmBtn.Size = UDim2.new(0.48, 0, 1, 0)
    startFarmBtn.Position = UDim2.new(0, 0, 0, 0)
    startFarmBtn.Text = "🚀 START FARM"
    startFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
    startFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    startFarmBtn.Font = Enum.Font.GothamBold
    startFarmBtn.TextSize = 12
    startFarmBtn.Parent = buttonFrame

    local stopFarmBtn = Instance.new("TextButton")
    stopFarmBtn.Size = UDim2.new(0.48, 0, 1, 0)
    stopFarmBtn.Position = UDim2.new(0.52, 0, 0, 0)
    stopFarmBtn.Text = "⏹️ STOP FARM"
    stopFarmBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    stopFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopFarmBtn.Font = Enum.Font.GothamBold
    stopFarmBtn.TextSize = 12
    stopFarmBtn.Parent = buttonFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = startFarmBtn
    btnCorner:Clone().Parent = stopFarmBtn

    -- Farm Status
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 0, 95)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: IDLE"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 11
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = farmFrame

    -- Methods List
    local methodsFrame = Instance.new("Frame")
    methodsFrame.Size = UDim2.new(1, -20, 0, 350)
    methodsFrame.Position = UDim2.new(0, 10, 0, 320)
    methodsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    methodsFrame.Parent = mainFrame

    local methodsCorner = Instance.new("UICorner")
    methodsCorner.CornerRadius = UDim.new(0, 8)
    methodsCorner.Parent = methodsFrame

    local methodsTitle = Instance.new("TextLabel")
    methodsTitle.Size = UDim2.new(1, -10, 0, 25)
    methodsTitle.Position = UDim2.new(0, 10, 0, 5)
    methodsTitle.BackgroundTransparency = 1
    methodsTitle.Text = "🎯 DETECTED EARNING METHODS (" .. #currencyData.earningMethods .. ")"
    methodsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    methodsTitle.Font = Enum.Font.GothamBold
    methodsTitle.TextSize = 14
    methodsTitle.TextXAlignment = Enum.TextXAlignment.Left
    methodsTitle.Parent = methodsFrame

    local methodsScroller = Instance.new("ScrollingFrame")
    methodsScroller.Size = UDim2.new(1, -10, 0, 315)
    methodsScroller.Position = UDim2.new(0, 5, 0, 35)
    methodsScroller.BackgroundTransparency = 1
    methodsScroller.ScrollBarThickness = 6
    methodsScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    methodsScroller.Parent = methodsFrame

    local methodsLayout = Instance.new("UIListLayout")
    methodsLayout.Padding = UDim.new(0, 8)
    methodsLayout.Parent = methodsScroller

    -- Manual Execute Section
    local manualFrame = Instance.new("Frame")
    manualFrame.Size = UDim2.new(1, -20, 0, 50)
    manualFrame.Position = UDim2.new(0, 10, 0, 680)
    manualFrame.BackgroundTransparency = 1
    manualFrame.Parent = mainFrame

    local executeAllBtn = Instance.new("TextButton")
    executeAllBtn.Size = UDim2.new(1, 0, 1, 0)
    executeAllBtn.Text = "⚡ EXECUTE ALL METHODS ONCE"
    executeAllBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    executeAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeAllBtn.Font = Enum.Font.GothamBold
    executeAllBtn.TextSize = 14
    executeAllBtn.Parent = manualFrame

    local executeCorner = Instance.new("UICorner")
    executeCorner.CornerRadius = UDim.new(0, 8)
    executeCorner.Parent = executeAllBtn

    -- 🎯 INISIALISASI AUTO-FARM SYSTEM
    local farmSystem = setupAutoFarmSystem()

    -- 📋 FUNGSI UNTUK MENGISI METHODS LIST
    local function populateMethodsList()
        for _, method in ipairs(currencyData.earningMethods) do
            local methodFrame = Instance.new("Frame")
            methodFrame.Size = UDim2.new(1, 0, 0, 60)
            methodFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            methodFrame.Parent = methodsScroller

            local methodCorner = Instance.new("UICorner")
            methodCorner.CornerRadius = UDim.new(0, 6)
            methodCorner.Parent = methodFrame

            -- Method Info
            local infoFrame = Instance.new("Frame")
            infoFrame.Size = UDim2.new(0.7, 0, 1, 0)
            infoFrame.Position = UDim2.new(0, 0, 0, 0)
            infoFrame.BackgroundTransparency = 1
            infoFrame.Parent = methodFrame

            local methodName = Instance.new("TextLabel")
            methodName.Size = UDim2.new(1, -10, 0.5, 0)
            methodName.Position = UDim2.new(0, 10, 0, 5)
            methodName.BackgroundTransparency = 1
            methodName.Text = method.description
            methodName.TextColor3 = Color3.fromRGB(255, 255, 255)
            methodName.Font = Enum.Font.Gotham
            methodName.TextSize = 12
            methodName.TextXAlignment = Enum.TextXAlignment.Left
            methodName.Parent = infoFrame

            local methodDetails = Instance.new("TextLabel")
            methodDetails.Size = UDim2.new(1, -10, 0.5, 0)
            methodDetails.Position = UDim2.new(0, 10, 0.5, 0)
            methodDetails.BackgroundTransparency = 1
            methodDetails.Text = method.type .. " • " .. method.category
            methodDetails.TextColor3 = Color3.fromRGB(200, 200, 200)
            methodDetails.Font = Enum.Font.Gotham
            methodDetails.TextSize = 10
            methodDetails.TextXAlignment = Enum.TextXAlignment.Left
            methodDetails.Parent = infoFrame

            -- Execute Button
            local executeBtn = Instance.new("TextButton")
            executeBtn.Size = UDim2.new(0.25, 0, 0.7, 0)
            executeBtn.Position = UDim2.new(0.73, 0, 0.15, 0)
            executeBtn.Text = "EXECUTE"
            executeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            executeBtn.Font = Enum.Font.GothamBold
            executeBtn.TextSize = 10
            executeBtn.Parent = methodFrame

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = executeBtn

            -- Button Click Handler
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
                    if executeBtn then
                        executeBtn.Text = "EXECUTE"
                        executeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                    end
                end)
            end)
        end

        -- Update scroller size
        methodsScroller.CanvasSize = UDim2.new(0, 0, 0, #currencyData.earningMethods * 68)
    end

    -- 🔄 AUTO-FARM CONTROL HANDLERS
    startFarmBtn.MouseButton1Click:Connect(function()
        local newInterval = tonumber(intervalBox.Text) or autoFarm.interval
        farmSystem.setInterval(newInterval)
        farmSystem.start()
        
        startFarmBtn.Text = "🔄 RUNNING..."
        startFarmBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        statusLabel.Text = "Status: FARMING (Cycle: 1)"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    end)

    stopFarmBtn.MouseButton1Click:Connect(function()
        farmSystem.stop()
        
        startFarmBtn.Text = "🚀 START FARM"
        startFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
        statusLabel.Text = "Status: IDLE"
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    end)

    intervalBox.FocusLost:Connect(function()
        local newInterval = tonumber(intervalBox.Text)
        if newInterval and newInterval >= 1 then
            farmSystem.setInterval(newInterval)
            intervalBox.Text = tostring(newInterval)
        else
            intervalBox.Text = tostring(autoFarm.interval)
        end
    end)

    -- 📊 MANUAL EXECUTE ALL HANDLER
    executeAllBtn.MouseButton1Click:Connect(function()
        executeAllBtn.Text = "⏳ EXECUTING..."
        executeAllBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        
        local successCount = 0
        local errorCount = 0
        
        for i, method in ipairs(currencyData.earningMethods) do
            local success, result = executeEarningMethod(method)
            if success then
                successCount += 1
                print("✅ [" .. i .. "/" .. #currencyData.earningMethods .. "] " .. result)
            else
                errorCount += 1
                print("❌ [" .. i .. "/" .. #currencyData.earningMethods .. "] " .. result)
            end
            task.wait(0.5) -- Delay antara executions
        end
        
        executeAllBtn.Text = "✅ DONE: " .. successCount .. "✓ " .. errorCount .. "✗"
        executeAllBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        
        task.delay(3, function()
            if executeAllBtn then
                executeAllBtn.Text = "⚡ EXECUTE ALL METHODS ONCE"
                executeAllBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            end
        end)
    end)

    -- 🔄 AUTO-UPDATE FARM STATUS
    task.spawn(function()
        while true do
            if autoFarm.enabled then
                local status = farmSystem.getStatus()
                statusLabel.Text = string.format("Status: FARMING (Cycle: %d, Method: %d/%d)", 
                    status.totalCycles, status.currentCycle, #currencyData.earningMethods)
            end
            task.wait(1)
        end
    end)

    -- 🎨 GUI ENHANCEMENTS
    local function addHoverEffects()
        -- Add hover effects to all buttons
        for _, button in pairs(mainFrame:GetDescendants()) do
            if button:IsA("TextButton") then
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundColor3 = button.BackgroundColor3 * 1.2
                    }):Play()
                end)
                
                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundColor3 = button.BackgroundColor3 / 1.2
                    }):Play()
                end)
            end
        end
    end

    -- 📱 TOGGLE GUI WITH KEYBIND
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.F6 then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    -- 🚀 INITIALIZE
    populateMethodsList()
    addHoverEffects()
    
    print("✅ Currency Automation Pro GUI loaded successfully!")
    return screenGui
end

-- 📜 MAIN EXECUTION
task.wait(3) -- Tunggu game fully loaded

print("🎮 Starting Currency Automation Pro...")

-- Jalankan deteksi sistem
local detectedData = detectCurrencySystem()

if #detectedData.earningMethods > 0 then
    -- Buat GUI jika ditemukan methods
    createAutomationGUI()
    
    print("✨ System ready! Press F6 to toggle GUI")
    print("📋 Available methods: " .. #detectedData.earningMethods)
else
    warn("❌ No earning methods detected in this game")
    
    -- Fallback: Simple notification
    local notification = Instance.new("ScreenGui")
    notification.Parent = player.PlayerGui
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 300, 0, 100)
    label.Position = UDim2.new(0.5, -150, 0.8, 0)
    label.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    label.Text = "❌ No earning methods detected!\nThis game might not support automation."
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextWrapped = true
    label.Parent = notification
    
    task.wait(5)
    notification:Destroy()
end
