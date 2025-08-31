local cloneref = cloneref or function(...) return ... end
local HttpService = cloneref(game.GetService(game, "HttpService"))
return function(flag: string, value: any): (string, any) -> ()
    local type = type or typeof
    if type(flag) ~= "string" then return task.spawn(error, "string expected, got "..type(flag)) end
    
    local cleanFlag = flag:gsub("^[DF]*Flag", ""):gsub("^[DF]*Int", ""):gsub("^[DF]*String", "")
    
    local stringValue
    if type(value) == "boolean" then
        stringValue = value and "true" or "false"
    else
        stringValue = tostring(value)
    end

    if pcall(function() return getfflag(cleanFlag) end) then
        local fflagfile = HttpService:JSONDecode(readfile("Bloxstrap/FFlags.json"))
        fflagfile[flag] = stringValue
        writefile("Bloxstrap/FFlags.json", HttpService:JSONEncode(fflagfile))
        return setfflag(cleanFlag, stringValue)
    else
        local err = isfile(errorlog) and readfile(errorlog) or "Error while loading FFlags: "
        return writefile(errorlog, err.."\nFFlag expected, got "..cleanFlag)
    end
end;
