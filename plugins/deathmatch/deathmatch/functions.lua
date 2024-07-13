playerKillStreaks = {}

function UpdateWeapon(player, weapon, bType)
    if bType == "primary" then
        player:SetVar("primarygun", weapon)
        db:Query(string.format("UPDATE `players_guns` SET primarygun = '%s' WHERE steamid = '%s'", weapon, tostring(player:GetSteamID())))
        player:GetWeaponManager():GiveWeapon(weapon)
    elseif bType == "secondary" then
        player:SetVar("secondarygun", weapon)
        db:Query(string.format("UPDATE `players_guns` SET secondarygun = '%s' WHERE steamid = '%s'", weapon, tostring(player:GetSteamID())))
        player:GetWeaponManager():GiveWeapon(weapon)
    end
end

function GetWeaponFromSlot(player, slot_id)
    if not player then
        return nil
    end
    local weapons = player:GetWeaponManager():GetWeapons()
    for i = 1, #weapons do
        if weapons[i]:CCSWeaponBaseVData().GearSlot == slot_id then
            return weapons[i]
        end
    end
    return nil
end

function resetStreaksAndGrenades(playerid, attackerid)
    playerKillStreaks[attackerid] = playerKillStreaks[attackerid] or 0
    playerKillStreaks[playerid] = playerKillStreaks[playerid] or 0
    grenadeCount[attackerid] = grenadeCount[attackerid] or 0
    grenadeCount[playerid] = grenadeCount[playerid] or 0
end


function handlePlayerKill(attackerid, playerid)
    if attackerid and attackerid ~= 0 then
        playerKillStreaks[attackerid] = playerKillStreaks[attackerid] + 1
        if playerid and playerid ~= 0 then
            playerKillStreaks[playerid] = 0
        end
    end
    grenadeCount[playerid] = 0
end


function giveGrenade(attacker)
    if playerKillStreaks[attacker:GetSteamID()] % 3 == 0 and grenadeCount[attacker:GetSteamID()] < 3 then
        attacker:SendMsg(3, "{DEFAULT}imp87.xyz {GREEN}" .. attacker:CBasePlayerController().PlayerName .. " you are receiving a grenade for " .. playerKillStreaks[attacker:GetSteamID()] .. " kills in a streak!")
        attacker:GetWeaponManager():GiveWeapon("weapon_hegrenade")
        grenadeCount[attacker:GetSteamID()] = grenadeCount[attacker:GetSteamID()] + 1
    end
end


function regenerateHealth(attacker, isHeadshot)
    local RegenHP = isHeadshot and config:Fetch("deathmatch.RegenHP_headshot") or config:Fetch("deathmatch.RegenHP")
    NextTick(function()
        attacker:CBaseEntity().Health = math.min(attacker:CBaseEntity().Health + RegenHP, 100)
        attacker:CCSPlayerPawn().HealthShotBoostExpirationTime = server:GetCurrentTime() + 1
    end)
end

