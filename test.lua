-- Previous code remains the same until isHealthTextVisible function

-- Function to detect HEALTH text in Roblox UI
local function isHealthTextVisible()
    local player = game.Players.LocalPlayer
    if not player or not player.PlayerGui then 
        print("[DEBUG] Player or PlayerGui not found")
        return false 
    end

    print("[DEBUG] Checking for HEALTH text...")

    -- Check if a specific UI element from PlayerGui contains the word "HEALTH"
    for _, gui in pairs(player.PlayerGui:GetDescendants()) do
        if gui:IsA("TextLabel") or gui:IsA("TextButton") then
            local success, text = pcall(function() return gui.Text end)
            if success and text then
                print("[DEBUG] Found UI text:", text)
                if string.find(string.upper(text), "HEALTH") then
                    print("[DEBUG] HEALTH text found in:", gui:GetFullName())
                    return true
                end
            end
        end
    end

    -- Also check for specific UI framework that might be used in the game
    local function checkGuiContainer(container, containerName)
        if not container then 
            print("[DEBUG]", containerName, "container not found")
            return false 
        end
        
        print("[DEBUG] Checking", containerName)
        for _, gui in pairs(container:GetChildren()) do
            if gui:IsA("Frame") or gui:IsA("ScreenGui") then
                for _, element in pairs(gui:GetDescendants()) do
                    if element:IsA("TextLabel") or element:IsA("TextButton") then
                        local success, text = pcall(function() return element.Text end)
                        if success and text then
                            print("[DEBUG] Found text in", containerName .. ":", text)
                            if string.find(string.upper(text), "HEALTH") then
                                print("[DEBUG] HEALTH text found in", containerName, ":", element:GetFullName())
                                return true
                            end
                        end
                    end
                end
            end
        end
        return false
    end

    -- Check in StarterGui
    if checkGuiContainer(game:GetService("StarterGui"), "StarterGui") then
        return true
    end

    -- Check in CoreGui
    local success, result = pcall(function()
        return checkGuiContainer(game:GetService("CoreGui"), "CoreGui")
    end)
    if success and result then
        return true
    end

    print("[DEBUG] No HEALTH text found in any UI")
    return false
end

-- Function to handle Spirit Boss farming loop
local function spiritBossFarmLoop()
    spawn(function()
        while wait(0.5) do
            if _G.SpiritBossFarm then
                print("[DEBUG] Spirit Boss Farm Loop - Checking health...")
                local isHealth = isHealthTextVisible()
                print("[DEBUG] Health visible:", isHealth)
                print("[DEBUG] Current fighting state:", _G.IsFighting)
                
                if not isHealth and _G.IsFighting then
                    print("[DEBUG] No health found and was fighting - returning to lobby")
                    _G.IsFighting = false
                    wait(1)
                    teleportToLobby()
                elseif not _G.IsFighting then
                    print("[DEBUG] Not fighting - teleporting to Spirit Boss")
                    _G.IsFighting = true
                    wait(1)
                    teleportToSpiritBoss()
                end
            end
        end
    end)
end

-- Function to handle Mecha Boss farming loop
local function mechaBossFarmLoop()
    spawn(function()
        while wait(0.5) do
            if _G.MechaBossFarm then
                print("[DEBUG] Mecha Boss Farm Loop - Checking health...")
                local isHealth = isHealthTextVisible()
                print("[DEBUG] Health visible:", isHealth)
                print("[DEBUG] Current fighting state:", _G.IsFighting)
                
                if not isHealth and _G.IsFighting then
                    print("[DEBUG] No health found and was fighting - returning to lobby")
                    _G.IsFighting = false
                    wait(1)
                    teleportToLobby()
                elseif not _G.IsFighting then
                    print("[DEBUG] Not fighting - teleporting to Mecha Boss")
                    _G.IsFighting = true
                    wait(1)
                    teleportToMechaBoss()
                end
            end
        end
    end)
end

-- Rest of the code remains the same
