local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Calixto Hub",
    Icon = "sword",
    Author = "Calixto",
    Folder = "CalixtoHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

-- Main Tabs
local BossTab = Window:Tab({ Title = "Boss Farm", Icon = "swords" })
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "list" })

-- Global variables for boss farming
_G.SpiritBossFarm = false
_G.MechaBossFarm = false
_G.IsFighting = false

-- Utility function for teleporting to lobby
local function teleportToLobby()
    local player = game.Players.LocalPlayer
    local lobbyPosition = Vector3.new(467.59, 285.60, 844.08)
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(lobbyPosition)
        WindUI:Notify({
            Title = "Lobby",
            Content = "Teleported to Lobby",
            Duration = 3,
        })
    end
end

-- Function to check if Spirit Boss fight is active
local function isSpiritBossFightActive()
    local success, isDoorOpen = pcall(function()
        return workspace.Lobby.Door:FindFirstChild("OpenDoor") ~= nil
    end)
    
    if success then
        print("[DEBUG] Spirit Boss Door state - OpenDoor exists:", isDoorOpen)
        return isDoorOpen
    else
        print("[DEBUG] Error checking Spirit Boss door state")
        return false
    end
end

-- Function to check if Mecha Boss fight is active
local function isMechaBossFightActive()
    local success, isActive = pcall(function()
        return not workspace.Lobby.ReadyAreass.PhysicalLobbyDisplay.SurfaceGui.Enabled
    end)
    
    if success then
        print("[DEBUG] Mecha Boss state - Active:", isActive)
        return isActive
    else
        print("[DEBUG] Error checking Mecha Boss state")
        return false
    end
end

-- Function to teleport to Spirit Boss
local function teleportToSpiritBoss()
    local player = game.Players.LocalPlayer
    local bossPosition = Vector3.new(483.05, 333.55, 1222.51)
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(bossPosition)
        WindUI:Notify({
            Title = "Spirit Boss",
            Content = "Teleported to Spirit Boss",
            Duration = 3,
        })
    end
end

-- Function to teleport to Mecha Boss
local function teleportToMechaBoss()
    local player = game.Players.LocalPlayer
    local bossPosition = Vector3.new(477.17, 277.60, 1199.48)
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(bossPosition)
        WindUI:Notify({
            Title = "Mecha Boss",
            Content = "Teleported to Mecha Boss",
            Duration = 3,
        })
    end
end

-- Function to handle Spirit Boss farming loop
local function spiritBossFarmLoop()
    spawn(function()
        while wait(1) do
            if _G.SpiritBossFarm then
                local isDoorOpen = isSpiritBossFightActive()
                print("[DEBUG] Spirit Boss Door state:", isDoorOpen and "Open" or "Closed")
                
                if isDoorOpen and not _G.IsFighting then
                    print("[DEBUG] Door open - Going to Spirit Boss")
                    _G.IsFighting = true
                    teleportToSpiritBoss()
                elseif not isDoorOpen and _G.IsFighting then
                    print("[DEBUG] Door closed - Going to lobby")
                    _G.IsFighting = false
                    teleportToLobby()
                    wait(3)
                end
            end
        end
    end)
end

-- Function to handle Mecha Boss farming loop
local function mechaBossFarmLoop()
    spawn(function()
        while wait(1) do
            if _G.MechaBossFarm then
                local isBossActive = isMechaBossFightActive()
                print("[DEBUG] Mecha Boss state:", isBossActive and "Active" or "Inactive")
                
                if isBossActive and not _G.IsFighting then
                    print("[DEBUG] Mecha Boss active - Going to boss")
                    _G.IsFighting = true
                    teleportToMechaBoss()
                elseif not isBossActive and _G.IsFighting then
                    print("[DEBUG] Mecha Boss inactive - Going to lobby")
                    _G.IsFighting = false
                    teleportToLobby()
                    wait(3)
                end
            end
        end
    end)
end

-- Boss Farm Section
BossTab:Toggle({
    Title = "Spirit Boss Farm",
    Default = false,
    Callback = function(state)
        _G.SpiritBossFarm = state
        if state then
            _G.MechaBossFarm = false -- Disable other boss farm if active
            spiritBossFarmLoop()
            WindUI:Notify({
                Title = "Spirit Boss Farm",
                Content = "Auto farming enabled",
                Duration = 3,
            })
        else
            _G.IsFighting = false
            teleportToLobby()
        end
    end
})

BossTab:Toggle({
    Title = "Mecha Boss Farm",
    Default = false,
    Callback = function(state)
        _G.MechaBossFarm = state
        if state then
            _G.SpiritBossFarm = false -- Disable other boss farm if active
            mechaBossFarmLoop()
            WindUI:Notify({
                Title = "Mecha Boss Farm",
                Content = "Auto farming enabled",
                Duration = 3,
            })
        else
            _G.IsFighting = false
            teleportToLobby()
        end
    end
})

BossTab:Button({
    Title = "Return to Lobby",
    Desc = "Teleport back to lobby",
    Callback = function()
        _G.SpiritBossFarm = false
        _G.MechaBossFarm = false
        _G.IsFighting = false
        teleportToLobby()
    end
})

-- Settings Section
SettingsTab:Toggle({
    Title = "Low Graphics Mode",
    Default = false,
    Callback = function(state)
        if state then
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = w.Terrain
            
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
            t.WaterTransparency = 0
            l.GlobalShadows = false
            l.FogEnd = 9e9
            l.Brightness = 0
            settings().Rendering.QualityLevel = "Level01"
            
            for _, v in pairs(g:GetDescendants()) do
                if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
            
            WindUI:Notify({
                Title = "Graphics",
                Content = "Low graphics mode enabled",
                Duration = 3,
            })
        end
    end
})

SettingsTab:Toggle({
    Title = "AFK Mode",
    Default = false,
    Callback = function(state)
        if state then
            local bb = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
                WindUI:Notify({
                    Title = "AFK",
                    Content = "Anti-AFK activated",
                    Duration = 3,
                })
            end)
        end
    end
})

-- Misc Section
MiscTab:Toggle({
    Title = "Auto Camera Lock",
    Default = false,
    Callback = function(state)
        _G.CameraLock = state
        if state then
            local function updateCamera()
                if _G.CameraLock then
                    local camera = game.Workspace.CurrentCamera
                    local targetPos = Vector3.new(452.17, 253.60, 1202.48)
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPos)
                end
            end
            
            game:GetService("RunService").RenderStepped:Connect(updateCamera)
        end
    end
})

MiscTab:Button({
    Title = "Credits",
    Desc = "Show credits",
    Callback = function()
        WindUI:Notify({
            Title = "Credits",
            Content = "Created by Calixto and Copilot AI",
            Duration = 5,
        })
    end
})

-- Initialize shiftlock
local function setupShiftlock()
    local ShiftlockStarterGui = Instance.new("ScreenGui")
    local ImageButton = Instance.new("ImageButton")
    
    ShiftlockStarterGui.Name = "Shiftlock (StarterGui)"
    ShiftlockStarterGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ShiftlockStarterGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    ImageButton.Parent = ShiftlockStarterGui
    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageButton.BackgroundTransparency = 1.000
    ImageButton.Position = UDim2.new(0.921914339, 0, 0.552375436, 0)
    ImageButton.Size = UDim2.new(0.0336147112, 0, 0.0361305636, 0)
    ImageButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
    ImageButton.Image = "http://www.roblox.com/asset/?id=182223762"
    
    local function TLQOYN_fake_script()
        local script = Instance.new('LocalScript', ImageButton)
        
        local MobileCameraFramework = {}
        local players = game:GetService("Players")
        local runservice = game:GetService("RunService")
        local CAS = game:GetService("ContextActionService")
        local player = players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local humanoid = character.Humanoid
        local camera = workspace.CurrentCamera
        local button = script.Parent
        
        -- Visibility
        local uis = game:GetService("UserInputService")
        local ismobile = uis.TouchEnabled
        button.Visible = not ismobile
        
        local MAX_LENGTH = 900000
        local active = false
        local ENABLED_OFFSET = CFrame.new(1.7, 0, 0)
        local DISABLED_OFFSET = CFrame.new(-1.7, 0, 0)
        
        local function UpdateAutoRotate(BOOL)
            humanoid.AutoRotate = BOOL
        end
        
        local function GetUpdatedCameraCFrame(ROOT, CAMERA)
            return CFrame.new(root.Position, Vector3.new(CAMERA.CFrame.LookVector.X * MAX_LENGTH, root.Position.Y, CAMERA.CFrame.LookVector.Z * MAX_LENGTH))
        end
        
        local function EnableShiftlock()
            UpdateAutoRotate(false)
            root.CFrame = GetUpdatedCameraCFrame(root, camera)
            camera.CFrame = camera.CFrame * ENABLED_OFFSET
        end
        
        local function DisableShiftlock()
            UpdateAutoRotate(true)
            camera.CFrame = camera.CFrame * DISABLED_OFFSET
            pcall(function()
                active:Disconnect()
                active = nil
            end)
        end
        
        active = false
        
        function ShiftLock()
            if not active then
                active = runservice.RenderStepped:Connect(function()
                    EnableShiftlock()
                end)
            else
                DisableShiftlock()
            end
        end
        
        local ShiftLockButton = CAS:BindAction("ShiftLOCK", ShiftLock, false, Enum.KeyCode.LeftShift)
        CAS:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))
        
        button.MouseButton1Click:Connect(ShiftLock)
        
        return MobileCameraFramework
    end
    
    coroutine.wrap(TLQOYN_fake_script)()
end

setupShiftlock()
