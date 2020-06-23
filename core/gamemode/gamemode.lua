gamemode = {}

function getGamemodeConfig(data)
    if type(data) == "string" and gamemode[data] then
        return gamemode[data]
    else
        return false
    end
end

function refreshGamemodeConf()
    local results = exports.db:queryTable("SELECT * FROM %s LIMIT 1", "gamemode")
    if results and #results > 0 then
        gamemode["serverName"] = results[1].serverName
        gamemode["moneyMultiplier"] = results[1].moneyMultiplier
        gamemode["freePremium"] = results[1].freePremium == 1 and true or false
        setGameType(results[1].gameType)
    else
        outputDebugString("["..getResourceName(getThisResource()).."/gamemode/gamemode.lua] Nie udało się załadować konfiguracji serwera z bazy danych!", 1)
    end
end
addEventHandler("onResourceStart", resourceRoot, refreshGamemodeConf)
