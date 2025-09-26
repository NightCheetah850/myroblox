-- Script untuk Delta Executor - Money Changer
-- Oleh: Penulis Script

local function change_money()
    -- Langkah 1: Input data awal
    local currentMoney = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Money.Text) or 0
    print("[INFO] Uang saat ini: " .. currentMoney)
    
    -- Tunggu perubahan data oleh pemain
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Money Changer";
        Text = "Ubah uang Anda (beli/jual) lalu konfirmasi";
        Duration = 5;
    })
    
    -- Langkah 2: Input data setelah perubahan
    wait(10) -- Beri waktu 10 detik untuk melakukan perubahan
    local changedMoney = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Money.Text) or 0
    print("[INFO] Uang setelah perubahan: " .. changedMoney)
    
    -- Cek apakah terjadi perubahan
    if currentMoney == changedMoney then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error";
            Text = "Tidak ada perubahan nilai uang!";
            Duration = 5;
        })
        return
    end
    
    -- Langkah 3: Memory scanning untuk menemukan alamat memori
    local targetAddress = nil
    local memory = getrenv().memory or nil
    
    if memory then
        -- Scan memori untuk nilai uang awal
        local results = memory.scan(currentMoney, 4, "int") -- Asumsikan tipe data integer
        for _, addr in ipairs(results) do
            -- Cek perubahan nilai di alamat yang sama
            memory.write(addr, changedMoney, "int")
            if memory.read(addr, "int") == changedMoney then
                targetAddress = addr
                break
            end
        end
    end
    
    -- Langkah 4: Input nilai baru dan terapkan perubahan
    if targetAddress then
        local newValue = tonumber(inputbox("Masukkan nilai uang baru:", "Money Changer", "10000"))
        if newValue then
            memory.write(targetAddress, newValue, "int")
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Success";
                Text = "Uang berhasil diubah menjadi: " .. newValue;
                Duration = 5;
            })
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error";
            Text = "Gagal menemukan alamat memori!";
            Duration = 5;
        })
    end
end

-- Eksekusi fungsi
change_money()
