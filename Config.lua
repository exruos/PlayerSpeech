local addonName, addon = ...
_G[addonName] = addon

local _, raceName = UnitRace("player")
local defaultGender = UnitSex("player")

local category = Settings.RegisterVerticalLayoutCategory("PlayerSpeech")

local function InitializeSettings()
    -- SPEECH_ENABLED

    local enableAddonSetting = Settings.RegisterAddOnSetting(
        category,
        "SPEECH_ENABLED",
        "enabled",
        addon.db,
        type(true),
        "Enable Feature",
        true
    )
    Settings.CreateCheckbox(category, enableAddonSetting, "Enable Player Error Speech")

    -- SPEECH_RACE

    local races = {
        "Human", "Gilnean", "Dwarf", "Night Elf", "Night Elf (DH)", "Gnome", "Draenei", "Worgen", "Pandaren",
        "Orc", "Undead", "Tauren", "Troll", "Blood Elf", "Blood Elf (DH)", "Goblin", "Nightborne",
        "Highmountain Tauren", "Void Elf", "Lightforged Draenei", "Mag'har Orc",
        "Dark Iron Dwarf", "Kul Tiran", "Zandalari Troll", "Mechagnome", "Vulpera", "Dracthyr", "Dracthyr (Visage)",
        "Haranir"
    }

    local function GetRaceValue()
        for i, race in next, races do
            if race == addon.db.race then
                return race
            end
        end
        return raceName
    end

    local function SetRaceValue(value)
        addon.db.race = value
    end

    local function GetRaceOptions()
        local container = Settings.CreateControlTextContainer()
        for i, race in next, races do
            container:Add(race, race)
        end
        return container:GetData()
    end

    local raceSetting = Settings.RegisterProxySetting(
        category,
        "SPEECH_RACE",
        Settings.VarType.String,
        "Race",
        "Dwarf",
        GetRaceValue,
        SetRaceValue
    )
    Settings.CreateDropdown(category, raceSetting, GetRaceOptions)


    -- SPEECH_GENDER

    local genders = { "Male", "Female" }

    local function GetGenderValue()
        return addon.db.gender or defaultGender
    end

    local function SetGenderValue(value)
        addon.db.gender = value
    end

    local function GetGenderOptions()
        local container = Settings.CreateControlTextContainer()
        for i, g in next, genders do
            container:Add(i + 1, g)
        end
        return container:GetData()
    end

    local genderSetting = Settings.RegisterProxySetting(
        category,
        "SPEECH_GENDER",
        "number",
        "Gender",
        2,
        GetGenderValue,
        SetGenderValue
    )
    Settings.CreateDropdown(category, genderSetting, GetGenderOptions)

    -- SPEECH_VISAGE_TOGGLE

    local visageSetting = Settings.RegisterAddOnSetting(
        category,
        "SPEECH_VISAGE_TOGGLE",
        "visage",
        addon.db,
        type(true),
        "Dracthyr Fix",
        true
    )
    Settings.CreateCheckbox(category, visageSetting,
        "Only play while not in Dracthyr Visage (fix for Dracthyr Dragon Form). Requires CVar to be enabled to play default visage sounds.")

    -- SPEECH_CVAR_TOGGLE

    local cvarSetting = Settings.RegisterProxySetting(
        category,
        "SPEECH_CVAR_TOGGLE",
        type(true),
        "Error Speech (CVar)",
        false,
        function() return GetCVar("Sound_EnableErrorSpeech") == "1" end,
        function(value) SetCVar("Sound_EnableErrorSpeech", value and 1 or 0) end
    )
    Settings.CreateCheckbox(category, cvarSetting,
        "Toggle Sound_EnableErrorSpeech as found in the default sound options. Should be disable to prevent overlapping sounds.")

    -- SPEECH_EVENT_TOGGLES

    local subcategory, subLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Event Toggles")
    subLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer(
        "You can find the correct one by searching for the red error message\n" ..
        "displayed and entering it into the search box in the top-right corner."
    ))

    local factory = ERR_MAP_FACTORY["Human"]

    if factory then
        local map = factory()

        local function SetAllEvents(state)
            for errConst, _ in pairs(map) do
                addon.db.eventToggles[errConst] = state
                local safeId = "SPEECH_EVENT_" .. tostring(errConst):gsub("%W", "_"):upper()
                local setting = Settings.GetSetting(safeId)
                if setting then
                    setting:SetValue(state)
                end
            end
        end

        local enableAllInit = CreateSettingsButtonInitializer(
            "",
            "Enable all",
            function() SetAllEvents(true) end,
            "Check all event boxes.",
            true
        )
        subLayout:AddInitializer(enableAllInit)

        local disableAllInit = CreateSettingsButtonInitializer(
            "",
            "Disable all",
            function() SetAllEvents(false) end,
            "Uncheck all event boxes.",
            true
        )
        subLayout:AddInitializer(disableAllInit)

        for errConst, _ in pairs(map) do
            local displayName = errConst
            if errConst == "%s" then
                displayName = "Out of Ammunition"
            end

            local safeId = "SPEECH_EVENT_" .. tostring(errConst):gsub("%W", "_"):upper()

            if not Settings.GetSetting(safeId) then
                if addon.db.eventToggles[errConst] == nil then
                    addon.db.eventToggles[errConst] = true
                end

                local currentErr = errConst
                local function GetEventValue() return addon.db.eventToggles[currentErr] end
                local function SetEventValue(value) addon.db.eventToggles[currentErr] = value end

                local eventSetting = Settings.RegisterProxySetting(
                    subcategory,
                    safeId,
                    type(true),
                    displayName,
                    true,
                    GetEventValue,
                    SetEventValue
                )
                Settings.CreateCheckbox(subcategory, eventSetting, displayName)
            end
        end
    end

    Settings.RegisterAddOnCategory(category)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, name)
    if name == addonName then
        PlayerSpeechDB = PlayerSpeechDB or {}
        addon.db = PlayerSpeechDB

        -- Set Defaults
        if addon.db.enabled == nil then addon.db.enabled = true end
        if addon.db.race == nil then addon.db.race = raceName end
        if addon.db.gender == nil then addon.db.gender = defaultGender end
        if addon.db.visage == nil then addon.db.visage = true end
        if addon.db.eventToggles == nil then addon.db.eventToggles = {} end

        InitializeSettings()
    end
end)
