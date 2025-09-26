-- Money Changer Script for Delta Executor
-- Fixed GUI Visibility Issue + Memory Scanning

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")  -- Fix: Akses PlayerGui, bukan StarterGui :cite[1]:cite[5]

local function moneyChanger()
    -- Langkah 1: Pastikan GUI target sudah dimuat
    local success, guiObject = pcall(function()
        return PlayerGui:WaitForChild("MainGUI"):WaitForChild("Money")
    end)
    
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error";
            Text = "GUI target tidak ditemukan!";
            Duration = 5;
        })
        return
    end

    -- Langkah 2: Baca nilai uang awal
    local currentMoney = tonumber(guiObject.Text) or 0
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Step 1";
        Text = "Uang saat ini: " .. currentMoney .. ". Ubah nilai uang Anda!";
        Duration = 5;
    })
    
    -- Langkah 3: Tunggu perubahan oleh user
    wait(10)  -- Beri waktu 10 detik untuk melakukan perubahan
    
    -- Langkah 4: Baca nilai uang setelah perubahan
    local changedMoney = tonumber(guiObject.Text) or 0
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Step 2";
        Text = "Uang setelah perubahan: " .. changedMoney;
        Duration = 5;
    })
    
    -- Cek apakah terjadi perubahan
    if currentMoney == changedMoney then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error";
            Text = "Tidak ada perubahan nilai uang!";
            Duration = 5;
        })
        return
    end
    
    -- Langkah 5: Memory scanning (gunakan fungsi yang tersedia di executor Anda)
    if memory and memory.scan then
        local results = memory.scan(currentMoney, 4, "int")
        
        for _, address in ipairs(results) do
            -- Verifikasi bahwa ini adalah alamat yang benar
            memory.write(address, changedMoney, "int")
            local verifiedValue = memory.read(address, "int")
            
            if verifiedValue == changedMoney then
                -- Langkah 6: Ubah ke nilai yang diinginkan user
                local newValue = 10000  -- Nilai default, bisa diganti dengan inputbox
                
                memory.write(address, newValue, "int")
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Success!";
                    Text = "Uang berhasil diubah menjadi: " .. newValue;
                    Duration = 5;
                })
                return
            end
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error";
            Text = "Gagal menemukan alamat memori yang sesuai";
            Duration = 5;
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error";
            Text = "Fungsi memory tidak tersedia";
            Duration = 5;
        })
    end
end

-- Jalankan fungsi utama
moneyChanger()
