function RegisterMenus()
    menus:Register("guns", "Guns Menu", "FF0000", {
        { "Rifles", "riflemenu" },
        { "Pistols", "pistolmenu" }
    });
    menus:Register("riflemenu", "Rifle Menu", "FF0000", {
        { "AK-47", "sw_ak47" },
        { "M4A4", "sw_m4a4" },
        { "M4A1-S", "sw_m4a1" },
        { "AWP", "sw_awp" },
        { "AK-47", "sw_ak47" },
        { "SSG-08", "sw_ssg" },
        { "SG-553", "sw_sg" },
        { "Pistols", "pistolmenu" }
    });
    menus:Register("pistolmenu", "Pistol Menu", "FF0000", {
        { "Deagle", "sw_deagle" },
        { "USP-S", "sw_usp" },
        { "P250", "sw_p250" }
    });
end