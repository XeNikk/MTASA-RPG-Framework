gamemode = {}

function getGamemodeConfig(data)
    if type(data) == "string" and gamemode[data] then
        return gamemode[data]
    else
        return false
    end
end

function refreshGamemodeConf()
    local query = exports.db:queryTable("SELECT * FROM `gamemode` LIMIT 1", "gamemode")
    if query and #query > 0 then
        gamemode["name"] = query[1].server_name
        gamemode["money_multiplayer"] = query[1].money_multiplayer
        gamemode["free_premium"] = query[1].free_premium == 1 and true or false
        setGameType(query[1].game_type)
    else
        outputDebugString("["..getResourceName(getThisResource()).."/gamemode/gamemode.lua] Nie udało się załadować konfiguracji serwera z bazy danych!", 1)
    end
end
addEventHandler("onResourceStart", resourceRoot, refreshGamemodeConf)