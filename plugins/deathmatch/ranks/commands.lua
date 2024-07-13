commands:Register("ranks", function(playerid)
    local player = GetPlayer(playerid)
    if not player then
        return
    end
    db:Query(string.format("SELECT NAME, score, kills, deaths, player_rank, total_players, steamID64 FROM (SELECT NAME, score, kills, deaths, steamID64, DENSE_RANK() OVER (ORDER BY score DESC) AS player_rank, COUNT(*) OVER () AS total_players FROM player_stats) AS ranked_players WHERE steamID64 = '%s';", tostring(player:GetSteamID())), function(err, result)
        if #result == 0 then
            return
        else
            local kd_ratio = result[1].kills / result[1].deaths

            local kd_ratio_formatted = string.format("%.2f", kd_ratio)
            player:SendMsg(3, "{DEFAULT}imp87.xyz Rank {GREEN}" .. result[1].player_rank .. "/" .. result[1].total_players .. "{DEFAULT}: {RED}" .. player:CBasePlayerController().PlayerName .. " {DEFAULT}with a score of {GREEN}" .. result[1].score)
            player:SendMsg(3, "{DEFAULT}★ {GREEN}" .. result[1].kills .. " {DEFAULT}kills, {GREEN}" .. result[1].deaths .. " {DEFAULT}deaths, Ø {GREEN}" .. kd_ratio_formatted)
        end
    end)

end)