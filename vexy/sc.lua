VirtualUser = game:GetService("VirtualUser")
Workspace = game:GetService("Workspace")
GuiService = game:GetService("GuiService")
UserInputService = game:GetService("UserInputService")
local v_u_1 = game:GetService("ReplicatedStorage")
-- Locals
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character
local PlayerGui = LocalPlayer.PlayerGui
local PlayerGUI = LocalPlayer:FindFirstChildOfClass("PlayerGui")
local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
local ActiveFolder = Workspace:FindFirstChild("active")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ProximityPromptService = game:GetService("ProximityPromptService")
local instantInteractEnabled = false
local instantInteractioxn = false
local useSlots = ""
local useRelic = ""
local v5 = require(v_u_1.packages.Net)
local BPEquip = v5:RemoteEvent("Backpack/Equip")
local BPFav = v5:RemoteEvent("Backpack/Favourite")

--<>----<>----<>----< Anti Afk >----<>----<>----<>--
game.Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
warn("[Anti Afk] - loaded successfully") 

--<>----<>----<>----< Main Script >----<>----<>----<>--
print("[Akbar Hub | Fisch | Native Support]: loading...")
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/FischMain.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/saveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/InterfaceManager.lua"))()

local autoAppraise = false

local Window = Fluent:CreateWindow({
    Title = "Vexy Reborn | Fisch | Native Support",
    SubTitle = "v1.6",
    TabWidth = 150,
    Size = UDim2.fromOffset(600, 400),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Creating tabs
local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
    Main = Window:AddTab({ Title = "Main", Icon = "code" }),
}

local Options = Fluent.Options

function notif(conten, duration)
    Fluent:Notify({
        Title = "Vexy Reborn - Notify",
        Content = conten,
        Duration = duration
    })
end

local BackgroundTransparencyappraise

function Pidoras(slot)
    spawn(function()
        while autoAppraise do
            task.wait()
            local player = game.Players.LocalPlayer
            local character = player.Character
            local nativeGet
            if character then
                local tool = character:FindFirstChildOfClass("Tool")
                if tool == nil then
                    for a, b in pairs( game:GetService("CoreGui"):GetChildren()) do
                        for c, d in pairs( b:GetChildren()) do
                            if d:WaitForChild("Native") then
                                nativeGet = d:WaitForChild("Native").MainContainerFrame.MainFrame.ContainerFrame:GetChildren()
                                for i, v in pairs(nativeGet) do
                                    if v.Name == "SectionListFrame" then
                                        for x, z in pairs(v:GetChildren()) do
                                            if z.Name == "ScrollingFrame" then
                                                for a, b in pairs(z:GetChildren()) do
                                                    if b.Name ~= "UIListLayout" and b.Name ~= "UIPadding" and b.Name ~= "Main" then
                                                        if b.Name == "Appraise" and (useSlots ~= "" and useSlots ~= nil) then
                                                            local pos = b.ScrollingFrame.Appraise.InputBox.OuterBar.Bar.AbsolutePosition
                                                            BackgroundTransparencyappraise = b.ScrollingFrame.Appraise.InputBox.OuterBar.BackgroundTransparency
                                                            local Pointer = b.ScrollingFrame.Appraise.InputBox.OuterBar.Bar.Pointer
                                                            if BackgroundTransparencyappraise == 1 and game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.backpack.hotbar[slot]:WaitForChild("raritystar") then
                                                                local button = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.backpack.hotbar[slot]
                                                                if button:IsA("ImageButton") and Pointer:IsA("ImageButton") then
                                                                    task.wait(1)
                                                                    GuiService.SelectedObject = button
                                                                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                                                                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                                                                    task.wait(1)
                                                                    GuiService.SelectedObject = nil
                                                                    task.wait(1)
                                                                    --GuiService.SelectedObject = Pointer
                                                                    local posx = Vector2.new(pos.X + 15,pos.Y+50)
                                                                    UserInputService:TouchTap(posx, true)
                                                                    UserInputService:TouchTap(posx, false)
                                                                end
                                                            end
                                                        end
                                                    end
                                                    task.wait()
                                                end
                                            end
                                            task.wait()
                                        end
                                    end
                                    task.wait()
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end


local DropdownH = Tabs.Main:AddDropdown("DropdownH", {
    Title = "Use Slot",
    Values = {'1', '2', '3', '4', '5', '6', '7', '8', '9'},
    Multi = false,
})
DropdownH:OnChanged(function(Value)
    if Value == nil then
        return
    end
    useSlots = Value
end)

local section = Tabs.Home:AddSection("Change Log:")
Tabs.Home:AddParagraph({
    Title = "Information",
    Content = "[🟩] - Open native Script -> Autos -> Appraise \n[🟩] - Scroll Tab Appraise To Top"
})

local AutoFreezeT = Tabs.Main:AddToggle("MyFreeze", {
    Title = "Auto On Appraise",
    Description = "Read On Tutorial in Tab Home",
    Default = false
})

AutoFreezeT:OnChanged(function()
    autoAppraise = AutoFreezeT.Value
    if autoAppraise then
        if useSlots ~= "" and useSlots ~= nil then
            Pidoras(useSlots)
        else
            notif("Pls Select Use Slot First", 5)
        end
    end
end)
