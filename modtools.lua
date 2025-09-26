-- LocalScript: Tempatkan di StarterPlayerScripts
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Deteksi sistem currency
local function detectCurrencySystem()
    local currencyData = {
        currencies = {},
        earningMethods = {},
        remoteEvents = {}
    }
    
    print("🔍 Memindai sistem currency...")
    
    -- 1. Deteksi Currency Values di Player
    local function findCurrencies()
        local locations = {
            player,
            player:WaitForChild("leaderstats"),
            player:FindFirstChild("Data"),
            player:FindFirstChild("Stats"),
            player:FindFirstChild("Currency"),
            player:FindFirstChild("PlayerData")
        }
        
        for _, location in pairs(locations) do
            if location then
                for _, child in pairs(location:GetChildren()) do
                    if child:IsA("IntValue") or child:IsA("NumberValue") or child:IsA("StringValue") then
                        if not string.find(child.Name:lower(), "level") and 
                           not string.find(child.Name:lower(), "exp") then
                            
                            table.insert(currencyData.currencies, {
                                name = child.Name,
                                value = child.Value,
                                object = child,
                                location = location.Name
                            })
                            print("✅ Currency ditemukan: " .. child.Name .. " di " .. location.Name)
                        end
                    end
                end
            end
        end
    end
    
    -- 2. Deteksi RemoteEvents untuk earning currency
    local function findEarningRemotes()
        local remoteFolders = {
            ReplicatedStorage,
            ReplicatedStorage:FindFirstChild("Remotes"),
            ReplicatedStorage:FindFirstChild("Events"),
            ReplicatedStorage:FindFirstChild("RemoteEvents")
        }
        
        for _, folder in pairs(remoteFolders) do
            if folder then
                for _, item in pairs(folder:GetChildren()) do
                    if item:IsA("RemoteEvent") or item:IsA("RemoteFunction") then
                        local nameLower = item.Name:lower()
                        
                        -- Deteksi berdasarkan nama event
                        if string.find(nameLower, "coin") or 
                           string.find(nameLower, "money") or 
                           string.find(nameLower, "currency") or
                           string.find(nameLower, "reward") or
                           string.find(nameLower, "collect") or
                           string.find(nameLower, "earn") or
                           string.find(nameLower, "claim") then
                            
                            table.insert(currencyData.remoteEvents, {
                                name = item.Name,
                                object = item,
                                type = item.ClassName
                            })
                            print("✅ RemoteEvent earning: " .. item.Name)
                        end
                    end
                end
            end
        end
    end
    
    -- 3. Deteksi Interaksi yang menghasilkan currency
    local function findEarningInteractions()
        -- Deteksi ClickDetectors di workspace
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                local parentName = obj.Parent.Name:lower()
                if string.find(parentName, "coin") or 
                   string.find(parentName, "money") or 
                   string.find(parentName, "chest") or
                   string.find(parentName, "reward") then
                    
                    table.insert(currencyData.earningMethods, {
                        type = "ClickDetector",
                        name = obj.Parent.Name,
                        object = obj,
                        description = "Klik objek " .. obj.Parent.Name
                    })
                    print("✅ Earning method: ClickDetector - " .. obj.Parent.Name)
                end
            end
            
            -- Deteksi ProximityPrompts
            if obj:IsA("ProximityPrompt") then
                local parentName = obj.Parent.Name:lower()
                if string.find(parentName, "coin") or 
                   string.find(parentName, "money") or 
                   string.find(parentName, "quest") or
                   string.find(parentName, "reward") then
                    
                    table.insert(currencyData.earningMethods, {
                        type = "ProximityPrompt",
                        name = obj.Parent.Name,
                        object = obj,
                        description = "Interaksi dengan " .. obj.Parent.Name
                    })
                    print("✅ Earning method: ProximityPrompt - " .. obj.Parent.Name)
                end
            end
        end
    end
    
    -- 4. Deteksi GUI Buttons untuk claiming rewards
    local function findGUIEarningMethods()
        local gui = player:WaitForChild("PlayerGui")
        for _, screenGui in pairs(gui:GetChildren()) do
            if screenGui:IsA("ScreenGui") then
                local function scanGUI(guiObject)
                    for _, child in pairs(guiObject:GetChildren()) do
                        if child:IsA("TextButton") or child:IsA("ImageButton") then
                            local textLower = (child.Text or ""):lower()
                            local nameLower = child.Name:lower()
                            
                            if string.find(textLower, "claim") or 
                               string.find(textLower, "collect") or 
                               string.find(textLower, "reward") or
                               string.find(textLower, "earn") or
                               string.find(nameLower, "claim") or
                               string.find(nameLower, "collect") then
                                
                                table.insert(currencyData.earningMethods, {
                                    type = "GUIButton",
                                    name = child.Name,
                                    object = child,
                                    description = "Klik button: " .. (child.Text or child.Name)
                                })
                                print("✅ Earning method: GUI Button - " .. child.Name)
                            end
                        end
                        scanGUI(child) -- Recursive scan
                    end
                end
                scanGUI(screenGui)
            end
        end
    end
    
    -- Jalankan semua deteksi
    findCurrencies()
    findEarningRemotes()
    findEarningInteractions()
    findGUIEarningMethods()
    
    return currencyData
end

-- Fungsi untuk membuat GUI automation
local function createAutomationGUI(currencyData)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CurrencyAutomation"
    screenGui.Parent = player.PlayerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 450, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.Parent = screenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 60)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "🤖 CURRENCY AUTOMATION"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = header
    
    -- Currency Display
    local currencyFrame = Instance.new("Frame")
    currencyFrame.Size = UDim2.new(1, -20, 0, 80)
    currencyFrame.Position = UDim2.new(0, 10, 0, 70)
    currencyFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    currencyFrame.Parent = mainFrame
    
    local currencyCorner = Instance.new("UICorner")
    currencyCorner.CornerRadius = UDim.new(0, 8)
    currencyCorner.Parent = currencyFrame
    
    local currencyTitle = Instance.new("TextLabel")
    currencyTitle.Size = UDim2.new(1, 0, 0, 25)
    currencyTitle.Position = UDim2.new(0, 10, 0, 5)
    currencyTitle.BackgroundTransparency = 1
    currencyTitle.Text = "💰 Currency Terdeteksi:"
    currencyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    currencyTitle.Font = Enum.Font.GothamBold
    currencyTitle.TextSize = 14
    currencyTitle.TextXAlignment = Enum.TextXAlignment.Left
    currencyTitle.Parent = currencyFrame
    
    local currencyList = Instance.new("TextLabel")
    currencyList.Size = UDim2.new(1, -20, 0, 50)
    currencyList.Position = UDim2.new(0, 10, 0, 30)
    currencyList.BackgroundTransparency = 1
    currencyList.Text = "Loading..."
    currencyList.TextColor3 = Color3.fromRGB(200, 200, 200)
    currencyList.Font = Enum.Font.Gotham
    currencyList.TextSize = 12
    currencyList.TextXAlignment = Enum.TextXAlignment.Left
    currencyList.TextYAlignment = Enum.TextYAlignment.Top
    currencyList.TextWrapped = true
    currencyList.Parent = currencyFrame
    
    -- Update currency list
    local currencyText = ""
    for i, currency in ipairs(currencyData.currencies) do
        if i <= 3 then -- Tampilkan maksimal 3
            currencyText = currencyText .. "• " .. currency.name .. ": " .. tostring(currency.value) .. "\n"
        end
    end
    if #currencyData.currencies > 3 then
        currencyText = currencyText .. "... dan " .. (#currencyData.currencies - 3) .. " lainnya"
    end
    currencyList.Text = currencyText
    
    -- Earning Methods
    local methodsFrame = Instance.new("Frame")
    methodsFrame.Size = UDim2.new(1, -20, 0, 400)
    methodsFrame.Position = UDim2.new(0, 10, 0, 160)
    methodsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    methodsFrame.Parent = mainFrame
    
    local methodsCorner = Instance.new("UICorner")
    methodsCorner.CornerRadius = UDim.new(0, 8)
    methodsCorner.Parent = methodsFrame
    
    local methodsTitle = Instance.new("TextLabel")
    methodsTitle.Size = UDim2.new(1, 0, 0, 30)
    methodsTitle.Position = UDim2.new(0, 10, 0, 5)
    methodsTitle.BackgroundTransparency = 1
    methodsTitle.Text = "🎯 Metode Earning Terdeteksi:"
    methodsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    methodsTitle.Font = Enum.Font.GothamBold
    methodsTitle.TextSize = 14
    methodsTitle.TextXAlignment = Enum.TextXAlignment.Left
    methodsTitle.Parent = methodsFrame
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 0, 360)
    scrollFrame.Position = UDim2.new(0, 5, 0, 40)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = methodsFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = scrollFrame
    
    -- Auto-execute section
    local autoFrame = Instance.new("Frame")
    autoFrame.Size = UDim2.new(1, -20, 0, 80)
    autoFrame.Position = UDim2.new(0, 10, 0, 570)
    autoFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    autoFrame.Parent = mainFrame
    
    local autoCorner = Instance.new("UICorner")
    autoCorner.CornerRadius = UDim.new(0, 8)
    autoCorner.Parent = autoFrame
    
    local autoTitle = Instance.new("TextLabel")
    autoTitle.Size = UDim2.new(1, 0, 0, 25)
    autoTitle.Position = UDim2.new(0, 10, 0, 5)
    autoTitle.BackgroundTransparency = 1
    autoTitle.Text = "⚡ Auto-Execute:"
    autoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoTitle.Font = Enum.Font.GothamBold
    autoTitle.TextSize = 14
    autoTitle.TextXAlignment = Enum.TextXAlignment.Left
    autoTitle.Parent = autoFrame
    
    local autoAllButton = Instance.new("TextButton")
    autoAllButton.Size = UDim2.new(0.8, 0, 0, 35)
    autoAllButton.Position = UDim2.new(0.1, 0, 0, 35)
    autoAllButton.Text = "🚀 EXECUTE ALL METHODS"
    autoAllButton.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
    autoAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoAllButton.Font = Enum.Font.GothamBold
    autoAllButton.TextSize = 12
    autoAllButton.Parent = autoFrame
    
    local autoCornerBtn = Instance.new("UICorner")
    autoCornerBtn.CornerRadius = UDim.new(0, 6)
    autoCornerBtn.Parent = autoAllButton
    
    -- Fungsi untuk mengeksekusi metode earning
    local function executeEarningMethod(method)
        local success, message = pcall(function()
            if method.type == "RemoteEvent" then
                -- Fire RemoteEvent ke server
                method.object:FireServer()
                return "RemoteEvent fired: " .. method.name
                
            elseif method.type == "RemoteFunction" then
                -- Invoke RemoteFunction
                method.object:InvokeServer()
                return "RemoteFunction invoked: " .. method.name
                
            elseif method.type == "ClickDetector" then
                -- Simulate click
                method.object:FireServer()
                return "ClickDetector activated: " .. method.name
                
            elseif method.type == "ProximityPrompt" then
                -- Trigger proximity prompt
                method.object:InputHoldBegin()
                task.wait(0.5)
                method.object:InputHoldEnd()
                return "ProximityPrompt triggered: " .. method.name
                
            elseif method.type == "GUIButton" then
                -- Simulate button click
                if method.object:IsA("TextButton") or method.object:IsA("ImageButton") then
                    method.object:Fire("MouseButton1Click")
                end
                return "GUI Button clicked: " .. method.name
            end
        end)
        
        return success, success and message or "Error: " .. tostring(message)
    end
    
    -- Tambahkan methods ke scroll frame
    for _, method in ipairs(currencyData.earningMethods) do
        local methodFrame = Instance.new("Frame")
        methodFrame.Size = UDim2.new(1, 0, 0, 60)
        methodFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        methodFrame.Parent = scrollFrame
        
        local methodCorner = Instance.new("UICorner")
        methodCorner.CornerRadius = UDim.new(0, 6)
        methodCorner.Parent = methodFrame
        
        local methodDesc = Instance.new("TextLabel")
        methodDesc.Size = UDim2.new(0.7, 0, 0.5, 0)
        methodDesc.Position = UDim2.new(0, 10, 0, 5)
        methodDesc.BackgroundTransparency = 1
        methodDesc.Text = method.description
        methodDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
        methodDesc.Font = Enum.Font.Gotham
        methodDesc.TextSize = 11
        methodDesc.TextXAlignment = Enum.TextXAlignment.Left
        methodDesc.Parent = methodFrame
        
        local methodType = Instance.new("TextLabel")
        methodType.Size = UDim2.new(0.7, 0, 0.5, 0)
        methodType.Position = UDim2.new(0, 10, 0.5, 0)
        methodType.BackgroundTransparency = 1
        methodType.Text = "Type: " .. method.type
        methodType.TextColor3 = Color3.fromRGB(200, 200, 200)
        methodType.Font = Enum.Font.Gotham
        methodType.TextSize = 10
        methodType.TextXAlignment = Enum.TextXAlignment.Left
        methodType.Parent = methodFrame
        
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
        
        executeBtn.MouseButton1Click:Connect(function()
            executeBtn.Text = "⏳..."
            executeBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
            
            local success, result = executeEarningMethod(method)
            
            if success then
                executeBtn.Text = "✅ DONE"
                executeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                print("✅ " .. result)
            else
                executeBtn.Text = "❌ ERROR"
                executeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
                warn("❌ " .. result)
            end
            
            task.wait(1.5)
            executeBtn.Text = "EXECUTE"
            executeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        end)
    end
    
    -- Auto-execute all function
    autoAllButton.MouseButton1Click:Connect(function()
        autoAllButton.Text = "⏳ EXECUTING..."
        autoAllButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        
        local executed = 0
        local errors = 0
        
        for _, method in ipairs(currencyData.earningMethods) do
            local success, result = executeEarningMethod(method)
            if success then
                executed = executed + 1
                print("✅ (" .. executed .. ") " .. result)
            else
                errors = errors + 1
                warn("❌ (" .. errors .. ") " .. result)
            end
            task.wait(0.5) -- Delay antara eksekusi
        end
        
        autoAllButton.Text = "✅ DONE: " .. executed .. " success, " .. errors .. " errors"
        autoAllButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        
        task.wait(3)
        autoAllButton.Text = "🚀 EXECUTE ALL METHODS"
        autoAllButton.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
    end)
    
    -- Update scroll frame size
    local function updateScrollSize()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateScrollSize)
    updateScrollSize()
    
    return screenGui
end

-- Main execution
task.wait(3) -- Tunggu game loading

local currencyData = detectCurrencySystem()

if #currencyData.earningMethods > 0 then
    createAutomationGUI(currencyData)
    print("✅ Currency Automation GUI loaded with " .. #currencyData.earningMethods .. " methods!")
else
    warn("❌ No earning methods detected!")
    
    -- Fallback: Basic currency editor
    local function createFallbackGUI()
        -- ... (kode fallback GUI)
    end
    createFallbackGUI()
end
