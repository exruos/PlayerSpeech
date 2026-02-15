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
        "Human", "Gilnean", "Dwarf","Night Elf","Night Elf (DH)","Gnome","Draenei","Worgen","Pandaren",
        "Orc","Undead","Tauren","Troll","Blood Elf","Blood Elf (DH)","Goblin","Nightborne",
        "Highmountain Tauren","Void Elf","Lightforged Draenei","Mag'har Orc",
        "Dark Iron Dwarf","Kul Tiran","Zandalari Troll","Mechagnome","Vulpera","Dracthyr", "Dracthyr (Visage)", "Haranir"
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
    Settings.CreateCheckbox(category, visageSetting, "Only play while not in Dracthyr Visage (fix for Dracthyr Dragon Form). Requires CVar to be enabled to play default visage sounds.")

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
    Settings.CreateCheckbox(category, cvarSetting, "Toggle Sound_EnableErrorSpeech as found in the default sound options. Should be disable to prevent overlapping sounds.")

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

        InitializeSettings()
    end
end)