commands:Register("ak47", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_RIFLE)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_ak47", "primary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "AK-47"))
    player:HideMenu()
end)
commands:RegisterAlias("ak47", "ak")

commands:Register("awp", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_RIFLE)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_awp", "primary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "AWP"))
    player:HideMenu()
end)

commands:Register("m4a4", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_RIFLE)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_m4a1", "primary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "M4A4"))
    player:HideMenu()
end)

commands:Register("m4a1", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_RIFLE)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_m4a1_silencer", "primary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "M4A1-S"))
    player:HideMenu()
end)

commands:Register("sg", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_RIFLE)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_sg553", "primary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "SG-553"))
    player:HideMenu()
end)

commands:Register("ssg", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_RIFLE)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_ssg08", "primary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "SSG-08"))
    player:HideMenu()
end)

commands:Register("deagle", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_PISTOL)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_deagle", "secondary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "Deagle"))
    player:HideMenu()
end)

commands:Register("p250", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_PISTOL)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_p250", "secondary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "P250"))
    player:HideMenu()
end)

commands:Register("usp", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    local currentweapon = GetWeaponFromSlot(player, gear_slot_t.GEAR_SLOT_PISTOL)
    currentweapon:Remove()
    UpdateWeapon(player, "weapon_usp_silencer", "secondary")
    ReplyToCommand(playerid, config:Fetch("deathmatch.prefix"),
        FetchTranslation("deathmatch.changed.weapon"):gsub("{WEAPON_NAME}", "USP-S"))
    player:HideMenu()
end)

commands:Register("guns", function(playerid, args, argsCount, silent)
    local player = GetPlayer(playerid)
    if not player then return end

    player:ShowMenu("guns")
end)
