
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local events_upvr = ReplicatedStorage:WaitForChild("events")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character
local PlayerGui = LocalPlayer.PlayerGui
local PlayerGUI = LocalPlayer:FindFirstChildOfClass("PlayerGui")

function notif(Text, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = 'Akbar Hub ~ Notify';
        Text = Text;
        Duration = Duration;
    })
end

local module = require(game:GetService("ReplicatedStorage"):WaitForChild("modules"):WaitForChild("library"):WaitForChild("rods"))
for i,v in pairs(Config.Rod) do
	if type(i) ~= 'number' then 
		if v.status then
			if module[i].Price == nil then
				price = "Inf"
			else
				price = module[i].Price
			end
			local moneyReal = LocalPlayer.leaderstats["C$"].Value
            local Moneyx = string.gsub(moneyReal, ",", "")
            local Money = Moneyx:split("C$")
			print(price)
			if PlayerGUI.hud.safezone.equipment.rods.scroll.safezone:FindFirstChild(i) == nil then
                if price ~= "Inf" then
                    if tonumber(Money[1]) >= tonumber(price) then
                        events_upvr:WaitForChild("purchase"):FireServer(i, "rod", price, 1)
                    else
                        notif("Not Enough Money.!!", 3)
                    end
                else
                    notif("cant Buy This Rod.!!", 3)
                end
            else
                notif("You Already Have This Item.!!", 3)
            end
		end
	end
end
