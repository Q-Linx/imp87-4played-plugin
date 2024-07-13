AddEventHandler("OnPlayerDeath", function(event --[[ Event ]])
    local attacker = GetPlayer(event:GetInt("attacker"))
    local player = GetPlayer(event:GetInt("userid"))
    local playerSteam = player:GetSteamID()
    local attackerSteam = attacker:GetSteamID()

    print('onplayerdeath')

    if not player then
        print("noplayer")
        return
    end

    if not attacker then
        print("noattacker")
        return
    end

    db:Query(string.format("UPDATE player_stats SET kills = kills+1 WHERE steamID64 = '%s'", attackerSteam), function(err, result)
        print(err)
        print(result)
        if #result > 0 then
            print("Kill in Datenbank erfasst")
        end
    end)

    db:Query(string.format("UPDATE player_stats SET deaths = deaths+1 WHERE steamID64 = '%s'", playerSteam), function(err, result)
        print(err)
        print(result)
        if #result > 0 then
            print("Death in Datenbank erfasst")
        end
    end)

end)

