-- LocalScript dalam StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 280, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Text = "Money Editor"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.Parent = Frame

-- Input fields
local CurrentMoneyLabel = Instance.new("TextLabel")
CurrentMoneyLabel.Size = UDim2.new(0, 280, 0, 30)
CurrentMoneyLabel.Position = UDim2.new(0, 10, 0, 60)
CurrentMoneyLabel.Text = "Data Pertama (Sebelum perubahan):"
CurrentMoneyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrentMoneyLabel.BackgroundTransparency = 1
CurrentMoneyLabel.Parent = Frame

local CurrentMoneyBox = Instance.new("TextBox")
CurrentMoneyBox.Size = UDim2.new(0, 280, 0, 40)
CurrentMoneyBox.Position = UDim2.new(0, 10, 0, 90)
CurrentMoneyBox.PlaceholderText = "Masukkan nilai uang awal"
CurrentMoneyBox.Parent = Frame

local ChangedMoneyLabel = Instance.new("TextLabel")
ChangedMoneyLabel.Size = UDim2.new(0, 280, 0, 30)
ChangedMoneyLabel.Position = UDim2.new(0, 10, 0, 140)
ChangedMoneyLabel.Text = "Data Kedua (Setelah perubahan):"
ChangedMoneyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangedMoneyLabel.BackgroundTransparency = 1
ChangedMoneyLabel.Parent = Frame

local ChangedMoneyBox = Instance.new("TextBox")
ChangedMoneyBox.Size = UDim2.new(0, 280, 0, 40)
ChangedMoneyBox.Position = UDim2.new(0, 10, 0, 170)
ChangedMoneyBox.PlaceholderText = "Masukkan nilai uang setelah perubahan"
ChangedMoneyBox.Parent = Frame

local NewValueLabel = Instance.new("TextLabel")
NewValueLabel.Size = UDim2.new(0, 280, 0, 30)
NewValueLabel.Position = UDim2.new(0, 10, 0, 220)
NewValueLabel.Text = "Nilai Baru yang Diinginkan:"
NewValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NewValueLabel.BackgroundTransparency = 1
NewValueLabel.Parent = Frame

local NewValueBox = Instance.new("TextBox")
NewValueBox.Size = UDim2.new(0, 280, 0, 40)
NewValueBox.Position = UDim2.new(0, 10, 0, 250)
NewValueBox.PlaceholderText = "Masukkan nilai uang baru"
NewValueBox.Parent = Frame

-- Buttons
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(0, 280, 0, 40)
ScanButton.Position = UDim2.new(0, 10, 0, 300)
ScanButton.Text = "Scan Perubahan"
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Parent = Frame

local ApplyButton = Instance.new("TextButton")
ApplyButton.Size = UDim2.new(0, 280, 0, 40)
ApplyButton.Position = UDim2.new(0, 10, 0, 350)
ApplyButton.Text = "Terapkan Nilai Baru"
ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.Parent = Frame

-- Variables untuk menyimpan data
local detectedAddress = nil
local originalValue = 0
local changedValue = 0

-- Fungsi untuk mencari perubahan memori (simulasi)
local function scanForChanges(oldValue, newValue)
    -- Dalam implementasi nyata, ini akan melakukan scan memori
    -- Untuk demo, kita simulasikan saja
    local difference = newValue - oldValue
    
    if difference ~= 0 then
        -- Simulasi menemukan alamat memori
        detectedAddress = "money_value_" .. tostring(math.random(1000, 9999))
        originalValue = oldValue
        changedValue = newValue
        
        return true, detectedAddress
    else
        return false, "Tidak ada perubahan yang terdeteksi"
    end
end

-- Fungsi untuk menerapkan nilai baru
local function applyNewValue(newValue)
    if detectedAddress then
        -- Dalam implementasi nyata, ini akan menulis ke memori
        print("Mengubah nilai di " .. detectedAddress .. " dari " .. changedValue .. " menjadi " .. newValue)
        
        -- Simulasi perubahan berhasil
        return true
    else
        return false, "Scan perubahan belum dilakukan"
    end
end

-- Event handlers
ScanButton.MouseButton1Click:Connect(function()
    local oldVal = tonumber(CurrentMoneyBox.Text)
    local newVal = tonumber(ChangedMoneyBox.Text)
    
    if not oldVal or not newVal then
        warn("Masukkan nilai yang valid")
        return
    end
    
    local success, result = scanForChanges(oldVal, newVal)
    
    if success then
        print("Perubahan ditemukan di: " .. result)
        warn("Scan berhasil! Alamat terdeteksi: " .. result)
    else
        warn("Scan gagal: " .. result)
    end
end)

ApplyButton.MouseButton1Click:Connect(function()
    local newVal = tonumber(NewValueBox.Text)
    
    if not newVal then
        warn("Masukkan nilai baru yang valid")
        return
    end
    
    local success, errorMsg = applyNewValue(newVal)
    
    if success then
        print("Nilai berhasil diubah menjadi: " .. newVal)
        warn("Perubahan berhasil diterapkan!")
    else
        warn("Gagal menerapkan perubahan: " .. errorMsg)
    end
end)
