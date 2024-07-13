playerKillStreaks = {}

-- Funktion zur Validierung und Verteilung der Granaten
function validateNextGrenade(playerid, event)
    local player = GetPlayer(playerid)
    if not player then
        return
    end
    local steamID = player:GetSteamID()

    if not playerKillStreaks[steamID] then
        playerKillStreaks[steamID] = 0
    end

    if event == "kill" then
        playerKillStreaks[steamID] = playerKillStreaks[steamID] + 1
    else
        playerKillStreaks[steamID] = 0
    end
    if event == "kill" then
        if playerKillStreaks[steamID] == 3 or 6 or 9 or 12 then
            player:SendMsg(3, "{DEFAULT}imp87.xyz {GREEN}" .. player:CBasePlayerController().PlayerName .. " you are receiving a grenade for " .. playerKillStreaks[steamID] .." kills in a streak!")
            player:GetWeaponManager():GiveWeapon("weapon_hegrenade")
        end
    end
end

function playerLeave(playerid)
    local player = GetPlayer(playerid)
    local steamID = player:GetSteamID()

    if not playerKillStreaks[steamID] then
        return
    else
        playerKillStreaks[steamID] = nil
    end
end
