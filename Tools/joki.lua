--<>----<>----<>----< Main Script >----<>----<>----<>--
print("[Akbar Hub | Fisch : loading...")
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/FischMain.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/saveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/InterfaceManager.lua"))()

task.wait(5)
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local events_upvr = ReplicatedStorage:WaitForChild("events")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character
local PlayerGui = LocalPlayer.PlayerGui
local PlayerGUI = LocalPlayer:FindFirstChildOfClass("PlayerGui")
local coin = 0
local Folder = "kidds"
local fullPath = Folder .. "/Jokian/" .. (LocalPlayer.Name) .. ".txt"
local moneyReal
local Moneyx
local Money
local jumlahcoin = 0
local Window = Fluent:CreateWindow({
    Title = "Akbar Hub | ",
    SubTitle = "v1.6",
    TabWidth = 150,
    Size = UDim2.fromOffset(600, 400),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

function notif(conten, duration)
    Fluent:Notify({
        Title = "akbar Hub - Notify",
        Content = conten,
        Duration = duration
    })
end

function fireproximitypromptx(ProximityPrompt, Amount, Skip)
    assert(ProximityPrompt, "Argument #1 Missing or nil")
    assert(typeof(ProximityPrompt) == "Instance" and ProximityPrompt:IsA("ProximityPrompt"), "Attempted to fire a Value that is not a ProximityPrompt")

    local HoldDuration = ProximityPrompt.HoldDuration
    if Skip then
        ProximityPrompt.HoldDuration = 0
    end

    for i = 1, Amount or 1 do
        ProximityPrompt:InputHoldBegin()
        if Skip then
            local RunService = game:GetService("RunService")
            local Start = time()
            repeat
                RunService.Heartbeat:Wait(0.1)
            until time() - Start > HoldDuration
        end
        ProximityPrompt:InputHoldEnd()
    end
    ProximityPrompt.HoldDuration = HoldDuration
end

-- Creating tabs
local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
}
local textBrickRod = Tabs.Home:AddParagraph({
    Title = "Information Account",
    Content = "Get Info Player",
})
--[[
Tabs.Home:AddButton("button1",{
    Title = "Show/Hide Valentine Ui",
    Description = "",
    Callback = function()
        local valentineshowUi = PlayerGui.ValentinesEventUI.ValentinesRewards
        valentineshowUi.Visible = not valentineshowUi:GetAttribute("Visible")
    end
})
]]
local showNotif = false
local notifier = Tabs.Home:AddToggle("Auto", {Title = "Show Notif", Default = false })
notifier:OnChanged(function(Value)
    showNotif = Value
end)

local instantInteraction = Tabs.Home:AddToggle("InstantInteraksi", {
    Title = "Instant Interaction",
    Description = "",
    Default = false
})
local instantInteractioxn = false
local instantInteractEnabled = false
instantInteraction:OnChanged(function()
    instantInteractioxn = instantInteraction.Value
    if instantInteractioxn then
        ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt, player)
            if instantInteractEnabled then
                fireproximitypromptx(prompt, 1, true)
            end
        end)
        game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
            fireproximitypromptx(prompt, 1, true)
        end)
    end
end)

local ToggleWalkspeed = Tabs.Home:AddToggle("Auto", {Title = "Play Auto Joki", Default = false })

local Inputxx = Tabs.Home:AddInput("Speed", {
    Title = "Money Jokian",
    Default = "1000000",
    Placeholder = "Masukan Jumlah Koin",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
    end
})

Inputxx.OnChanged = function()
    if ToggleWalkspeed:Get() and not isfile(fullPath) then
        local koinvalue = Inputxx.Value
        local moneyRealxxx = LocalPlayer.leaderstats["C$"].Value
        local Moneyxxx = string.gsub(moneyRealxxx, ",", "")
        local Moneyxxx = Moneyxxx:split("C$")
        if tonumber(koinvalue) then
            jumlahcoin = tonumber(koinvalue) + tonumber(Moneyxxx[1])
        end
    end
end

ToggleWalkspeed:OnChanged(function(State)
    if State and not isfile(fullPath) then
        local moneyRealxx = LocalPlayer.leaderstats["C$"].Value
        task.wait(1)
        local Moneyxx = string.gsub(moneyRealxx, ",", "")
        task.wait(1)
        local Moneyxx = Moneyxx:split("C$")
        jumlahcoin = tonumber(Inputxx.Value) + tonumber(Moneyxx[1])
        Save(tostring(jumlahcoin))
    end
end)

local delayx = 1
function Save(datax)
    if isfile(fullPath) then
        if delayx == 1 then delayx = 3 end
        coin = readfile(fullPath)
        moneyReal = LocalPlayer.leaderstats["C$"].Value
        task.wait(1)
        Moneyx = string.gsub(moneyReal, ",", "")
        task.wait(1)
        Money = Moneyx:split("C$")
        task.wait(1)
        if tonumber(Money[1]) >= tonumber(coin) then
            delfile(fullPath)
            game.Players.LocalPlayer:Kick("Jokian Done!!!")
        else
            textBrickRod:Destroy()
            if not game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.statuses:WaitForChild("statusUI") and tonumber(Money[1]) >= 11000 then
                workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Merlin"):WaitForChild("Merlin"):WaitForChild("luck"):InvokeServer()
            end
            if showNotif then
                notif("Akun Coin = "..Money[1].." C$   ->   "..coin.." C$", 2)
            end
            textBrickRod = Tabs.Home:AddParagraph({
                Title = "Information Account",
                Content = "Akun Coin = "..Money[1].." C$  ->  "..coin.." C$",
            })
        end
    else
        writefile(fullPath, datax)
    end
    return true
end

while task.wait(delayx) do
    if isfile(fullPath) then
        if ToggleWalkspeed then ToggleWalkspeed:Destroy() end
        if Inputxx then Inputxx:Destroy() end
        moneyReal = LocalPlayer.leaderstats["C$"].Value
        task.wait(1)
        Moneyx = string.gsub(moneyReal, ",", "")
        task.wait(1)
        Money = Moneyx:split("C$")
        Save(Money[1])
    end
    for _, v_2 in ipairs(PlayerGui.ValentinesEventUI.ValentinesRewards.BottomContainer.ProgessBar:GetChildren()) do
        if v_2:IsA("ImageLabel") then
            local tonumber_result1_upvr = tonumber(v_2.Name:match("Item(%d+)"))
            game:GetService("ReplicatedStorage"):WaitForChild("packages").Net["RE/ValentineClaimRequest"]:FireServer(tonumber_result1_upvr)
        end
    end
end


-- Addons:
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder(Folder)
SaveManager:SetFolder(Folder.."/Fisch")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()
