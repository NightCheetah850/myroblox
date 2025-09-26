-- LocalScript dalam StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MoneyEditorEvent = ReplicatedStorage:WaitForChild("MoneyEditorEvent")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 380, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Text = "Admin Money Editor"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.Parent = Frame

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 380, 0, 60)
StatusLabel.Position = UDim2.new(0, 10, 0, 60)
StatusLabel.Text = "Langkah 1: Masukkan User ID target player"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextWrapped = true
StatusLabel.Parent = Frame

-- Input Box
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0, 380, 0, 40)
InputBox.Position = UDim2.new(0, 10, 0, 130)
InputBox.PlaceholderText = "Masukkan User ID"
InputBox.Parent = Frame

-- Money Type Selection
local MoneyTypeLabel = Instance.new("TextLabel")
MoneyTypeLabel.Size = UDim2.new(0, 380, 0, 30)
MoneyTypeLabel.Position = UDim2.new(0, 10, 0, 180)
MoneyTypeLabel.Text = "Pilih Jenis Mata Uang:"
MoneyTypeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MoneyTypeLabel.BackgroundTransparency = 1
MoneyTypeLabel.Visible = false
MoneyTypeLabel.Parent = Frame

local MoneyTypeDropdown = Instance.new("TextButton")
MoneyTypeDropdown.Size = UDim2.new(0, 380, 0, 40)
MoneyTypeDropdown.Position = UDim2.new(0, 10, 0, 210)
MoneyTypeDropdown.Text = "Pilih..."
MoneyTypeDropdown.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MoneyTypeDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
MoneyTypeDropdown.Visible = false
MoneyTypeDropdown.Parent = Frame

-- Submit Button
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 380, 0, 40)
SubmitButton.Position = UDim2.new(0, 10, 0, 260)
SubmitButton.Text = "Dapatkan Data Player"
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Parent = Frame

-- Variables
local currentStep = 1
local targetUserId = nil
local playerData = nil
local selectedMoneyType = nil

-- Money Types
local moneyTypes = {"Money", "Gold", "Gems"}

-- Fungsi untuk update UI berdasarkan step
local function updateUIForStep(step)
    if step == 1 then
        StatusLabel.Text = "Langkah 1: Masukkan User ID target player"
        InputBox.PlaceholderText = "Contoh: 123456789"
        InputBox.Text = ""
        MoneyTypeLabel.Visible = false
        MoneyTypeDropdown.Visible = false
        SubmitButton.Text = "Dapatkan Data Player"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        
    elseif step == 2 then
        StatusLabel.Text = "Pilih jenis mata uang yang ingin diubah:"
        InputBox.Visible = false
        MoneyTypeLabel.Visible = true
        MoneyTypeDropdown.Visible = true
        SubmitButton.Text = "Pilih Mata Uang"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        
    elseif step == 3 then
        StatusLabel.Text = "Masukkan nilai BARU untuk " .. selectedMoneyType .. ":\nNilai saat ini: " .. (playerData and playerData[selectedMoneyType] or "Unknown")
        InputBox.Visible = true
        InputBox.PlaceholderText = "Masukkan nilai baru"
        InputBox.Text = ""
        MoneyTypeLabel.Visible = false
        MoneyTypeDropdown.Visible = false
        SubmitButton.Text = "Terapkan Perubahan"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end

-- Event untuk dropdown money type
MoneyTypeDropdown.MouseButton1Click:Connect(function()
    -- Simple dropdown implementation
    for i, moneyType in ipairs(moneyTypes) do
        local option = Instance.new("TextButton")
        option.Size = UDim2.new(0, 380, 0, 30)
        option.Position = UDim2.new(0, 0, 0, 40 + (i-1)*35)
        option.Text = moneyType .. ": " .. (playerData and playerData[moneyType] or "?")
        option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        option.TextColor3 = Color3.fromRGB(255, 255, 255)
        option.Parent = MoneyTypeDropdown
        
        option.MouseButton1Click:Connect(function()
            selectedMoneyType = moneyType
            MoneyTypeDropdown.Text = moneyType .. ": " .. (playerData and playerData[moneyType] or "?")
            -- Hapus semua option
            for _, child in ipairs(MoneyTypeDropdown:GetChildren()) do
                if child:IsA("TextButton") and child ~= MoneyTypeDropdown then
                    child:Destroy()
                end
            end
        end)
    end
end)

-- Event untuk submit button
SubmitButton.MouseButton1Click:Connect(function()
    if currentStep == 1 then
        -- Step 1: Get User ID
        local userId = tonumber(InputBox.Text)
        if userId then
            targetUserId = userId
            MoneyEditorEvent:FireServer("GetPlayerData", {TargetUserId = userId})
        else
            warn("Masukkan User ID yang valid!")
        end
        
    elseif currentStep == 2 then
        -- Step 2: Select money type
        if selectedMoneyType then
            currentStep = 3
            updateUIForStep(3)
        else
            warn("Pilih jenis mata uang terlebih dahulu!")
        end
        
    elseif currentStep == 3 then
        -- Step 3: Apply changes
        local newValue = tonumber(InputBox.Text)
        if newValue and selectedMoneyType and targetUserId then
            MoneyEditorEvent:FireServer("UpdateMoney", {
                TargetUserId = targetUserId,
                MoneyType = selectedMoneyType,
                NewValue = newValue
            })
        else
            warn("Masukkan nilai yang valid!")
        end
    end
end)

-- Handle responses dari server
MoneyEditorEvent.OnClientEvent:Connect(function(action, data)
    if action == "PlayerDataResponse" then
        playerData = data
        currentStep = 2
        updateUIForStep(2)
        warn("Data player berhasil didapatkan!")
        
    elseif action == "UpdateResult" then
        if data.Success then
            warn("SUKSES: " .. data.Message)
            -- Reset ke step 1
            currentStep = 1
            updateUIForStep(1)
            targetUserId = nil
            playerData = nil
            selectedMoneyType = nil
        else
            warn("GAGAL: " .. data.Message)
        end
    end
end)

-- Initialize UI
updateUIForStep(1)
