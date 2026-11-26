local addonName = ...

-- Name shown in the PlayerSpeech race dropdown. Must be unique if you use several custom voices.
local VOICE_NAME = "Custom"

-- Sound files go into the "sounds" folder next to this file (.ogg or .mp3).
-- WoW only finds new sound files after a full game restart, /reload is not enough.
local path = "Interface\\AddOns\\" .. addonName .. "\\sounds\\"

-- Uncomment the errors you have a sound for. Errors left out stay silent.
-- Use a single file for both genders, or { [2] = male, [3] = female } for separate files.
-- Example: [ERR_SPELL_OUT_OF_RANGE] = { [2] = path .. "out_of_range.ogg", [3] = path .. "out_of_range_female.ogg" },
PlayerSpeech.RegisterVoice(VOICE_NAME, function()
    return {
        -- Combat
        -- [ERR_SPELL_OUT_OF_RANGE] = path .. "out_of_range.ogg",
        -- [ERR_GENERIC_NO_TARGET] = path .. "no_target.ogg",
        -- [ERR_NO_ATTACK_TARGET] = path .. "no_attack_target.ogg",
        -- [ERR_INVALID_ATTACK_TARGET] = path .. "invalid_attack_target.ogg",
        -- [ERR_SPELL_COOLDOWN] = path .. "spell_cooldown.ogg",
        -- [ERR_ABILITY_COOLDOWN] = path .. "ability_cooldown.ogg",
        -- [ERR_OUT_OF_MANA] = path .. "out_of_mana.ogg",
        -- [ERR_OUT_OF_RAGE] = path .. "out_of_rage.ogg",
        -- [ERR_OUT_OF_ENERGY] = path .. "out_of_energy.ogg",
        -- [ERR_OUT_OF_FOCUS] = path .. "out_of_focus.ogg",
        -- [ERR_NOAMMO_S] = path .. "no_ammo.ogg",

        -- Items and inventory
        -- [ERR_INV_FULL] = path .. "inventory_full.ogg",
        -- [ERR_BAG_FULL] = path .. "bag_full.ogg",
        -- [ERR_ITEM_MAX_COUNT] = path .. "item_max_count.ogg",
        -- [ERR_ITEM_COOLDOWN] = path .. "item_cooldown.ogg",
        -- [ERR_POTION_COOLDOWN] = path .. "potion_cooldown.ogg",
        -- [ERR_FOOD_COOLDOWN] = path .. "food_cooldown.ogg",
        -- [ERR_ITEM_LOCKED] = path .. "item_locked.ogg",
        -- [ERR_CANT_USE_ITEM] = path .. "cant_use_item.ogg",
        -- [ERR_CANT_EQUIP_LEVEL_I] = path .. "cant_equip_level.ogg",
        -- [ERR_CANT_EQUIP_EVER] = path .. "cant_equip_ever.ogg",
        -- [ERR_CANT_EQUIP_SKILL] = path .. "cant_equip_skill.ogg",
        -- [ERR_NOT_EQUIPPABLE] = path .. "not_equippable.ogg",
        -- [ERR_MUST_EQUIP_ITEM] = path .. "must_equip_item.ogg",
        -- [ERR_PROFICIENCY_NEEDED] = path .. "proficiency_needed.ogg",
        -- [ERR_2HANDED_EQUIPPED] = path .. "two_handed_equipped.ogg",
        -- [ERR_2HSKILLNOTFOUND] = path .. "two_handed_skill_not_found.ogg",
        -- [ERR_WRONG_SLOT] = path .. "wrong_slot.ogg",
        -- [ERR_CANT_SWAP] = path .. "cant_swap.ogg",
        -- [ERR_NOT_A_BAG] = path .. "not_a_bag.ogg",
        -- [ERR_BAG_IN_BAG] = path .. "bag_in_bag.ogg",
        -- [ERR_AMMO_ONLY] = path .. "ammo_only.ogg",
        -- [ERR_DROP_BOUND_ITEM] = path .. "drop_bound_item.ogg",
        -- [ERR_TRADE_BOUND_ITEM] = path .. "trade_bound_item.ogg",
        -- [ERR_NOT_OWNER] = path .. "not_owner.ogg",

        -- Looting and objects
        -- [ERR_LOOT_DIDNT_KILL] = path .. "loot_didnt_kill.ogg",
        -- [ERR_LOOT_BAD_FACING] = path .. "loot_bad_facing.ogg",
        -- [ERR_LOOT_LOCKED] = path .. "loot_locked.ogg",
        -- [ERR_LOOT_TOO_FAR] = path .. "loot_too_far.ogg",
        -- [ERR_CHEST_IN_USE] = path .. "chest_in_use.ogg",
        -- [ERR_USE_LOCKED] = path .. "use_locked.ogg",
        -- [ERR_USE_TOO_FAR] = path .. "use_too_far.ogg",

        -- Money
        -- [ERR_NOT_ENOUGH_MONEY] = path .. "not_enough_money.ogg",
        -- [ERR_BANKSLOT_INSUFFICIENT_FUNDS] = path .. "bankslot_insufficient_funds.ogg",
        -- [ERR_TAXINOTENOUGHMONEY] = path .. "taxi_not_enough_money.ogg",

        -- Groups and guilds
        -- [ERR_INVITE_IN_COMBAT] = path .. "invite_in_combat.ogg",
        -- [ERR_ALREADY_IN_GROUP_S] = path .. "already_in_group.ogg",
        -- [ERR_ALREADY_IN_GUILD] = path .. "already_in_guild.ogg",
        -- [ERR_GUILD_PERMISSIONS] = path .. "guild_permissions.ogg",
    }
end)
