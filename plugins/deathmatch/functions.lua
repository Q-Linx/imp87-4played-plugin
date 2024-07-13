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

-- Funktion zur Validierung und Verteilung der Granaten
function validateNextGrenade(playerid)
    local player = GetPlayer(playerid)
    if not player then return end

    -- Hole die SteamID des Spielers
    local steamID = player:GetSteamID()

    -- Initialisiere die Kill-Zählung für den Spieler, falls erforderlich
    if not playerKillStreaks[steamID] then
        playerKillStreaks[steamID] = 0
    end

    -- Erhöhe die Kill-Zählung
    playerKillStreaks[steamID] = playerKillStreaks[steamID] + 1

    -- Überprüfe, ob der Spieler 3 Kills hintereinander hat
    if playerKillStreaks[steamID] == 3 then
        -- Sende eine Nachricht an den Spieler
        player:SendMsg(3, "{DEFAULT}imp87.xyz {GREEN}" .. player:CBasePlayerController().PlayerName .. " you are receiving a grenade for 3 kills in a streak!")

        -- Setze die Kill-Zählung zurück
        playerKillStreaks[steamID] = 0

        -- Gib dem Spieler eine Granate
        player:GetWeaponManager():GiveWeapon("weapon_hegrenade")
    end
end
