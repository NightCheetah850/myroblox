-- Mod Menu Floating Circle dengan Lua
-- Untuk digunakan di lingkungan Android yang mendukung eksekusi Lua (seperti melalui aplikasi tertentu)

local function createFloatingCircle()
    -- Asumsikan kita memiliki metode untuk membuat window floating
    local floatingWindow = {
        x = 100,
        y = 100,
        radius = 30,
        color = "red",
        visible = true
    }
    
    -- Fungsi untuk menampilkan lingkaran
    function floatingWindow:draw()
        -- Gunakan API grafis yang tersedia untuk menggambar lingkaran
        -- Contoh: drawCircle(self.x, self.y, self.radius, self.color)
        print("Lingkaran digambar di posisi: (" .. self.x .. ", " .. self.y .. ")")
    end
    
    -- Fungsi untuk menangani sentuhan
    function floatingWindow:onTouch()
        self:showPopup()
    end
    
    -- Fungsi untuk menampilkan popup
    function floatingWindow:showPopup()
        -- Gunakan API dialog atau popup yang tersedia
        -- Contoh: ShowPopup("Mod by Milky")
        print("Popup ditampilkan: Mod by Milky")
    end
    
    -- Fungsi untuk menggeser lingkaran
    function floatingWindow:move(newX, newY)
        self.x = newX
        self.y = newY
        self:draw()
    end
    
    return floatingWindow
end

-- Contoh penggunaan
local circle = createFloatingCircle()
circle:draw()  -- Gambar lingkaran awal

-- Simulasi sentuhan
circle:onTouch()  -- Tampilkan popup

-- Simulasi penggeseran
circle:move(150, 200)  -- Geser lingkaran ke posisi baru
