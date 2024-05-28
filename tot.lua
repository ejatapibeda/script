-- Memuat library Orion
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

-- Membuat jendela baru
local Window = OrionLib:MakeWindow({
    Name = "Scriptors HUB 🦁 | PET SIMULATOR 99 🐾",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest"
})

-- Membuat tab baru untuk Pet Spawner
local PetTab = Window:MakeTab({
    Name = "Pet Spawner",
    Icon = "rbxassetid://14968277226",
    PremiumOnly = false
})

-- Menambahkan bagian untuk Pet Spawner
PetTab:AddSection({
    Name = "Pet Spawner 🐾",
    Default = "default box input",
    TextDisappear = true,
    Callback = function(Value)
    end      
})

-- Menambahkan input teks untuk nama Pet
PetTab:AddTextbox({
    Name = "Pet Name 🐾",
    Default = "",
    Callback = function(Value)
        print("Pet Name: " .. Value)
    end
})

-- Menambahkan tombol untuk Spawn Pet
PetTab:AddButton({
    Name = "Spawn Pet 🐾",
    Callback = function()
        print("Spawn Pet button pressed")
    end
})

-- Menambahkan paragraf teks untuk cara penggunaan Pet Spawner
PetTab:AddParagraph("How To Use Pet Spawner 🐾", "YOU MUST click on 'Spawn Pet' after entering the EXACT Name of The Pet You Want To Spawn!")

-- Menambahkan peringatan untuk akun alternatif
PetTab:AddParagraph("Alt Account Warning! ⚠️", "If you are using An Alt Account/Another Account besides your Main. All of the Exploits will not work!")

-- Membuat tab baru untuk Gems Spawner
local GemsTab = Window:MakeTab({
    Name = "Gems Spawner",
    Icon = "rbxassetid://7628736558", -- Ganti dengan ID ikon Gems yang sesuai
    PremiumOnly = false -- Sesuaikan dengan kebutuhan
})

-- Menambahkan bagian untuk Gems Spawner
GemsTab:AddSection({
    Name = "Gems Spawner 💎",
    Default = "default box input",
    TextDisappear = true,
    Callback = function(Value)
    end      
})

-- Menambahkan input teks untuk nama Gems
GemsTab:AddTextbox({
    Name = "Gems Ammount 💎",
    Default = "",
    Callback = function(Value)
        print("Gems Type: " .. Value)
    end
})

-- Menambahkan tombol untuk Spawn Gems
GemsTab:AddButton({
    Name = "Spawn Gems 💎",
    Callback = function()
        print("Spawn Gems button pressed")
    end
})

-- Menambahkan paragraf teks untuk cara penggunaan Gems Spawner
GemsTab:AddParagraph("How To Use Gems Spawner 💎", "You MUST click on 'Spawn Gems' after entering the EXACT type of Gems you want to spawn!")

-- Menambahkan peringatan untuk akun alternatif
GemsTab:AddParagraph("Alt Account Warning! ⚠️", "If you are using an Alt Account/Another Account besides your Main, some features may not work as expected!")
