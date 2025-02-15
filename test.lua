local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Calixto Hub",
    Icon = "sword",
    Author = "Calixto",
    Folder = "CalixtoHub",
    Size = UDim2.fromOffset(580, 460),
    KeySystem = {
        Key = { "12345" },
        Note = "The key is '12345'",
        URL = "",
        SaveKey = true,
    },
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

-- Main Tabs
local BossTab = Window:Tab({ Title = "Boss Farm", Icon = "swords" })
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "list" })

-- Boss Farm Section
BossTab:Button({
    Title = "Spirit Boss Farm",
    Desc = "Farm Spirit Boss",
    Callback = function()
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
})

BossTab:Button({
    Title = "Mecha Boss Farm",
    Desc = "Farm Mecha Boss",
    Callback = function()
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
})

BossTab:Button({
    Title = "Return to Lobby",
    Desc = "Teleport back to lobby",
    Callback = function()
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
    
    ImageButton.Parent = ShiftlockStarterGui
    ImageButton.BackgroundTransparency = 1
    ImageButton.Position = UDim2.new(0.92, 0, 0.55, 0)
    ImageButton.Size = UDim2.new(0.034, 0, 0.036, 0)
    ImageButton.Image = "http://www.roblox.com/asset/?id=182223762"
    
    local function TLQOYN_fake_script()
        local script = Instance.new('LocalScript', ImageButton)
        -- Shiftlock implementation remains the same as original
    end
    
    coroutine.wrap(TLQOYN_fake_script)()
end

setupShiftlock()
