local addonName, addon = ...
local eventListenerFrame = CreateFrame("Frame", "UIErrorEventListenerFrame")

local lastGlobalSoundTime = 0
local RACE_ERROR_MAPS = {}
local IGNORED_SPELL_IDS = {
    [1297434] = true,
}
local lastIgnoredFailTime = -1

setmetatable(RACE_ERROR_MAPS, {
    __index = function(t, key)
        local factoryFunc = addon.ERR_MAP_FACTORY[key]

        if factoryFunc then
            t[key] = factoryFunc()
            return t[key]
        end
        return nil
    end
})

local function GetErrorSoundIdFrom(errConst, raceName, gender)
    local raceMap = RACE_ERROR_MAPS[raceName]

    if not raceMap then
        return nil
    end

    local soundId = raceMap[errConst]

    if soundId then
        return soundId[gender]
    end

    return nil
end

local function HandleErrorMessage(soundId, errorTime)
    if lastIgnoredFailTime == errorTime then
        return
    end

    if not PlayerIsInCombat() and addon.db.visage then
        local visageAura = C_UnitAuras.GetPlayerAuraBySpellID(372014)
        if visageAura then
            return
        end
    end

    local currentTime = GetTime()
    if (currentTime - lastGlobalSoundTime) < addon.db.soundCooldown then
        return
    end
    lastGlobalSoundTime = currentTime

    PlaySound(soundId, "Dialog", true)
end

local function OnEvent(self, event, ...)
    if not addon.db.enabled then
        return
    end

    if event == "UNIT_SPELLCAST_FAILED" then
        local _, _, spellID = ...
        if IGNORED_SPELL_IDS[spellID] then
            lastIgnoredFailTime = GetTime()
        end
        return
    end

    local _, msg = ...
    if addon.db.eventToggles[msg] == false then
        return
    end

    local soundId = GetErrorSoundIdFrom(msg, addon.db.race, addon.db.gender)
    if not soundId then
        return
    end

    local errorTime = GetTime()
    C_Timer.After(0, function()
        HandleErrorMessage(soundId, errorTime)
    end)
end

eventListenerFrame:RegisterEvent("UI_ERROR_MESSAGE")
eventListenerFrame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player")
eventListenerFrame:SetScript("OnEvent", OnEvent)
