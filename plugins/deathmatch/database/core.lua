AddEventHandler("OnPluginStart", function(event)
    db = Database("deathmatch")
    if not db:IsConnected() then
        return
    end

    local startuptext = [[
       {BLUE}__ ___________   ___       __          _       ______
  {BLUE}/ ____/ ___/__ \ /   | ____/ /___ ___  (_)___  / ____/___  ________
 {BLUE}/ /    \__ \__/ // /| |/ __  / __ `__ \/ / __ \/ /   / __ \/ ___/ _ \
{BLUE}/ /___ ___/ / __// ___ / /_/ / / / / / / / / / / /___/ /_/ / /  /  __/
{BLUE}\____//____/____/_/  |_\__,_/_/ /_/ /_/_/_/ /_/\____/\____/_/   \___/  by q-linx
    ]]

    print(startuptext)
    db:Query("CREATE TABLE IF NOT EXISTS `" .. config:Fetch("deathmatch.tablename") .. "` (`steamid` varchar(128) NOT NULL, `primarygun` varchar(128) NOT NULL, `secondarygun` varchar(128) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;")
    db:Query([[ CREATE TABLE IF NOT EXISTS game_events ( event_id INT AUTO_INCREMENT PRIMARY KEY, player VARCHAR(255), attacker VARCHAR(255), assister VARCHAR(255), assisted_flash BOOLEAN, weapon VARCHAR(255),headshot INT, dominated BOOLEAN, revenge BOOLEAN, wipe BOOLEAN, penetrated BOOLEAN, noreplay BOOLEAN, noscope BOOLEAN, thrusmoke BOOLEAN, attacker_blind BOOLEAN, distance DOUBLE, dmg_health INT,dmg_armor INT, hitgroup INT, points_attacker VARCHAR(255), points_assiter VARCHAR(255), timestamp DATETIME DEFAULT CURRENT_TIMESTAMP ); ]])
    db:Query([[ CREATE TABLE IF NOT EXISTS `player_data` (`id` int(11) NOT NULL AUTO_INCREMENT, `steamID64` varchar(50) NOT NULL DEFAULT '0', `name` varchar(50) NOT NULL DEFAULT '0', `firstSeen` timestamp NOT NULL DEFAULT current_timestamp(), `lastSeen` timestamp NULL DEFAULT NULL, `connects` int(11) NOT NULL DEFAULT 0, `last_ip` varchar(50) NOT NULL DEFAULT '0', PRIMARY KEY (`id`), UNIQUE KEY `steamID64` (`steamID64`) ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; ]])
    db:Query([[ CREATE TABLE IF NOT EXISTS `player_stats` ( `id` int(11) NOT NULL AUTO_INCREMENT, `steamID64` varchar(50) DEFAULT '0', `name` varchar(50) DEFAULT '0', `kills` int(11) NOT NULL DEFAULT 0, `deaths` int(11) NOT NULL DEFAULT 0, `headshots` int(11) NOT NULL DEFAULT 0, `throughWall` int(11) NOT NULL DEFAULT 0, `score` int(11) DEFAULT 0, PRIMARY KEY (`id`), UNIQUE KEY `steamID64` (`steamID64`) ) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; ]])

    RegisterMenus()

end)