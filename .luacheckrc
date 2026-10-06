std = "lua51"
max_line_length = false
unused_args = false

ignore = {
    "211/addonName", -- not every file needs the addon name
    "213",           -- unused loop variables
}

globals = {
    "PlayerSpeechDB",
}

read_globals = {
    -- WoW API
    "C_Timer",
    "C_UnitAuras",
    "CreateFrame",
    "GetCVar",
    "GetTime",
    "PlaySound",
    "PlayerIsInCombat",
    "SetCVar",
    "UnitRace",
    "UnitSex",

    -- Settings UI
    "CreateSettingsButtonInitializer",
    "CreateSettingsListSectionHeaderInitializer",
    "MinimalSliderWithSteppersMixin",
    "Settings",

    -- Error message strings
    "ERR_2HANDED_EQUIPPED",
    "ERR_2HSKILLNOTFOUND",
    "ERR_ABILITY_COOLDOWN",
    "ERR_ALREADY_IN_GROUP_S",
    "ERR_ALREADY_IN_GUILD",
    "ERR_AMMO_ONLY",
    "ERR_BAG_FULL",
    "ERR_BAG_IN_BAG",
    "ERR_BANKSLOT_INSUFFICIENT_FUNDS",
    "ERR_CANT_EQUIP_EVER",
    "ERR_CANT_EQUIP_LEVEL_I",
    "ERR_CANT_EQUIP_SKILL",
    "ERR_CANT_SWAP",
    "ERR_CANT_USE_ITEM",
    "ERR_CHEST_IN_USE",
    "ERR_DROP_BOUND_ITEM",
    "ERR_FOOD_COOLDOWN",
    "ERR_GENERIC_NO_TARGET",
    "ERR_GUILD_PERMISSIONS",
    "ERR_INVALID_ATTACK_TARGET",
    "ERR_INVALID_ITEM_TARGET",
    "ERR_INVITE_IN_COMBAT",
    "ERR_INV_FULL",
    "ERR_ITEM_COOLDOWN",
    "ERR_ITEM_LOCKED",
    "ERR_ITEM_MAX_COUNT",
    "ERR_LOOT_BAD_FACING",
    "ERR_LOOT_DIDNT_KILL",
    "ERR_LOOT_LOCKED",
    "ERR_LOOT_TOO_FAR",
    "ERR_MUST_EQUIP_ITEM",
    "ERR_NOAMMO_S",
    "ERR_NOT_A_BAG",
    "ERR_NOT_ENOUGH_MONEY",
    "ERR_NOT_EQUIPPABLE",
    "ERR_NOT_OWNER",
    "ERR_NO_ATTACK_TARGET",
    "ERR_OUT_OF_ENERGY",
    "ERR_OUT_OF_FOCUS",
    "ERR_OUT_OF_MANA",
    "ERR_OUT_OF_RAGE",
    "ERR_POTION_COOLDOWN",
    "ERR_PROFICIENCY_NEEDED",
    "ERR_SPELL_COOLDOWN",
    "ERR_SPELL_OUT_OF_RANGE",
    "ERR_TAXINOTENOUGHMONEY",
    "ERR_TRADE_BOUND_ITEM",
    "ERR_USE_LOCKED",
    "ERR_USE_TOO_FAR",
    "ERR_WRONG_SLOT",
}
