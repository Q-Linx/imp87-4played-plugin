AddEventHandler("OnPlayerDeath", function(event --[[ Event ]])
    local attacker = GetPlayer(event:GetInt("attacker"))
    local player = GetPlayer(event:GetInt("userid"))
    local playerSteam = player:GetSteamID()
    local attackerSteam = attacker:GetSteamID()

    if not player then
        return
    end

    if not attacker then
        return
    end

    db:Query(string.format("UPDATE player_stats SET kills = kills+1 WHERE steamID64 = '%s'", attackerSteam), function(err, result)
        if #result > 0 then
        end
    end)

    db:Query(string.format("UPDATE player_stats SET deaths = deaths+1 WHERE steamID64 = '%s'", playerSteam), function(err, result)
        if #result > 0 then
            return
        end
    end)

end)

AddEventHandler("OnClientDisconnect", function(event --[[ Event ]], playerid --[[ number ]])
    playerLeave(playerid)
end)


AddEventHandler("OnPlayerConnectFull", function(event)
    local playerid = event:GetInt("userid")
    checkPlayer(playerid)
end)
