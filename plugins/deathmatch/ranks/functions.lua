function GetNumberOfGrenades(playerid)
    local player = GetPlayer(playerid)
    local grenades = {
        ["weapon_hegrenade"] = true
    };


    local weapons = player:GetWeaponManager():GetWeapons()
    local weaponCount = 0
    for i=1,#weapons do
        if grenades[CBaseEntity(weapons[i]:CBasePlayerWeapon():ToPtr()):GetClassname()] then
            weaponCount = weaponCount + 1
        end
    end
    return weaponCount
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

function checkPlayer(playerid)
    local player = GetPlayer(playerid)
    if not player then
        return false
    end
    local steamid = player:GetSteamID()
    local name = player:CBasePlayerController().PlayerName
    local ip = player:GetIPAddress()

    db:Query(string.format("SELECT * FROM player_data WHERE steamID64 = '%s'", steamid), function(err, result)
        if #result == 0 then
            db:Query(string.format("INSERT INTO player_data (name, steamID64, firstSeen, last_ip) VALUES ('%s', '%s', NOW(), '%s')", name, steamid, ip))
            db:Query(string.format("INSERT INTO player_stats (steamID64, name, kills, deaths, headshots, throughWall) VALUES ('%s', '%s', %i, %i, %i, %i)", steamid, name, 0, 0, 0, 0))
        else
            db:Query(string.format("UPDATE player_data SET last_ip = '%s', lastSeen = NOW(), connects = connects+1 WHERE steamID64 = '%s'", ip, steamid))
        end
    end)
end


