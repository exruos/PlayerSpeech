local addonName, addon = ...
local eventListenerFrame = CreateFrame("Frame", "UIErrorEventListenerFrame")

local lastGlobalSoundTime = 0
local RACE_ERROR_MAPS = {}

setmetatable(RACE_ERROR_MAPS, {
    __index = function(t, key)
        local factoryFunc = ERR_MAP_FACTORY[key]

        if factoryFunc then
            t[key] = factoryFunc()
            return t[key]
        end
        return nil
    end
})

function GetErrorSoundIdFrom(errConst, raceName, gender)
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

local function OnEvent(self, event, messageType, msg)
    if not addon.db.enabled then
        return
    end

    if not PlayerIsInCombat() and addon.db.visage then
        local visageAura = C_UnitAuras.GetPlayerAuraBySpellID(372014)
            if visageAura then
                return
            end
    end

    local soundId = GetErrorSoundIdFrom(msg, addon.db.race, addon.db.gender)
    if soundId then
        if msg == ERR_ABILITY_COOLDOWN then
            local currentTime = GetTime()
            if (currentTime - lastGlobalSoundTime) < 1.5 then
                return
            end
            lastGlobalSoundTime = currentTime
        end

        PlaySound(soundId, "Dialog", true)
    end
end

eventListenerFrame:RegisterEvent("UI_ERROR_MESSAGE")
eventListenerFrame:SetScript("OnEvent", OnEvent)

