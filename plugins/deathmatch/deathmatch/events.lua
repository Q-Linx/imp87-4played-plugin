playerKillStreaks = {}
grenadeCount = {}

AddEventHandler("OnPluginStart", function(event)
    convar:Set("ammo_grenade_limit_default", "3")
end)

AddEventHandler("OnRoundStart", function(event)
    convar:Set("ammo_grenade_limit_default", "3")
end)

AddEventHandler("OnPlayerConnectFull", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then
        return
    end
    if player:IsFakeClient() then
        return
    end

    db:Query(string.format("SELECT * FROM `players_guns` WHERE steamid = '%s' LIMIT 1", tostring(player:GetSteamID())), function(err, result)
        if #result > 0 then
            local primarygun = result[1]["primarygun"] or "weapon_ak47"
            local secondarygun = result[1]["secondarygun"] or "weapon_deagle"
            player:SetVar("primarygun", primarygun)
            player:SetVar("secondarygun", secondarygun)
        end
    end)


end)

AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then
        return
    end
    if player:IsFakeClient() then
        return
    end

    if player:IsFirstSpawn() then
        db:Query(string.format("SELECT * FROM `players_guns` WHERE steamid = '%s' LIMIT 1", tostring(player:GetSteamID())), function(err, result)
            if #result == 0 then
                db:Query(string.format("INSERT IGNORE INTO `players_guns` (steamid, primarygun, secondarygun) VALUES ('%s', 'weapon_ak47', 'weapon_deagle')", tostring(player:GetSteamID())))
            end
        end)
    end

    if not player:IsFakeClient() then
        player:GetWeaponManager():GiveWeapon(tostring(player:GetVar("primarygun")))
        player:GetWeaponManager():GiveWeapon(tostring(player:GetVar("secondarygun")))
    end

end)

AddEventHandler("OnPlayerDeath", function(event)

    local playerid = event:GetInt("userid")
    local attackerid = event:GetInt("attacker")
    local player = GetPlayer(playerid)
    local attacker = GetPlayer(attackerid)
    local playerSteam = player:GetSteamID()
    local attackerSteam = attacker:GetSteamID()

    if attacker then

        if not player then
            return
        end

        if not playerKillStreaks[attackerid] then
            playerKillStreaks[attackerid] = 0
        end

        if not playerKillStreaks[playerid] then
            playerKillStreaks[playerid] = 0
        end

        if not grenadeCount[attackerid] then
            grenadeCount[attackerid] = 0
        end

        if not grenadeCount[playerid] then
            grenadeCount[playerid] = 0
        end

        if grenadeCount[playerid] == 3 then
            playerKillStreaks[attackerid] = playerKillStreaks[attackerid] -1
            return
        end

        if attackerid and attackerid ~= 0 then
            playerKillStreaks[attackerid] = playerKillStreaks[attackerid] + 1
            if playerid and playerid ~= 0 then
                playerKillStreaks[playerid] = 0
            end
        end

        grenadeCount[playerid] = 0

        if playerKillStreaks[attackerid] % 3 == 0 and grenadeCount[attackerid] < 3 then
            attacker:SendMsg(3, "{DEFAULT}imp87.xyz {GREEN}" .. attacker:CBasePlayerController().PlayerName .. " you are receiving a grenade for " .. playerKillStreaks[attackerid] .. " kills in a streak!")
            attacker:GetWeaponManager():GiveWeapon("weapon_hegrenade")
        end
    end

    if event:GetInt('headshot') == 1 then
        local RegenHP = config:Fetch("deathmatch.RegenHP_headshot")
        NextTick(function()
            attacker:CBaseEntity().Health = math.min(attacker:CBaseEntity().Health + RegenHP, 100)
            attacker:CCSPlayerPawn().HealthShotBoostExpirationTime = server:GetCurrentTime() + 1
        end)
    else
        local RegenHP = config:Fetch("deathmatch.RegenHP")
        NextTick(function()
            attacker:CBaseEntity().Health = math.min(attacker:CBaseEntity().Health + RegenHP, 100)
            attacker:CCSPlayerPawn().HealthShotBoostExpirationTime = server:GetCurrentTime() + 1
        end)
    end
end)

AddEventHandler("OnPlayerHurt", function(event --[[ Event ]])
    local attacker = GetPlayer(event:GetInt('attacker'))
    local dmgHealth = event:GetInt('dmg_health')

    if dmgHealth <= 1 or dmgHealth == 0 or attacker == nil or attacker == 0 then
        return
    end
    attacker:SendMsg(4, '[-' .. dmgHealth .. ' HP]')
end)

AddEventHandler("OnWeaponFire", function(event --[[ Event ]])

    local weaponList = { "weapon_tec9", "weapon_deagle", "weapon_p250", "weapon_hkp2000", "weapon_glock", "weapon_fiveseven", "weapon_usp_silencer" }
    for i = 1, #weaponList do
        for k = 1, playermanager:GetPlayerCap() do
            local player = GetPlayer(k - 1)
            if player then
                local weapons = player:GetWeaponManager():GetWeapons()
                for v = 1, #weapons do
                    local weaponClassname = CBaseEntity(weapons[v]:CBasePlayerWeapon():ToPtr()):GetClassname()
                    if weaponClassname == weaponList[i] then
                        weapons[v]:CBasePlayerWeapon().Clip1 = 999
                        weapons[v]:CBasePlayerWeapon().Clip2 = 999
                        break
                    end
                end
            end
        end
    end
end)

AddEventHandler("OnItemRemove", function(event --[[ Event ]])
    local item = event:GetString("item")
    local player = GetPlayer(event:GetInt("userid"))  -- Beispiel, wie man den Spieler vom Event bekommt
    if player then
        local weaponManager = player:GetWeaponManager()
        local weapons = weaponManager:GetWeapons()
        for i = 1, #weapons do
            local weaponClassname = CBaseEntity(weapons[i]:CBasePlayerWeapon():ToPtr()):GetClassname()
            if weaponClassname == item then
                -- Entferne das Item aus der Welt
                CBaseEntity(weapons[i]:CBasePlayerWeapon():ToPtr()):Remove()
                break
            end
        end
    end
end)

AddEventHandler("OnItemPickup", function(event --[[ Event ]])
    local item = event:GetString('item')
    local playerid = event:GetInt('userid')
    if item == "hegrenade" then

        grenadeCount[playerid] = grenadeCount[playerid] + 1


    end
end)

AddEventHandler("OnGrenadeThrown", function(event --[[ Event ]])
    if event:GetString('weapon') == "hegrenade" and grenadeCount[event:GetInt('userid')] ~= 0 then
        grenadeCount[event:GetInt('userid')] = grenadeCount[event:GetInt('userid')] - 1
        print(grenadeCount[event:GetInt('userid')])
    end
end)