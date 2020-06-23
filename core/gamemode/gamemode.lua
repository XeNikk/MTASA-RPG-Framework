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
        gamemode["name"] = results[1].server_name
        gamemode["money_multiplayer"] = results[1].money_multiplayer
        gamemode["free_premium"] = results[1].free_premium == 1 and true or false
        setGameType(results[1].game_type)
    else
        outputDebugString("["..getResourceName(getThisResource()).."/gamemode/gamemode.lua] Nie udało się załadować konfiguracji serwera z bazy danych!", 1)
    end
end
addEventHandler("onResourceStart", resourceRoot, refreshGamemodeConf)
