return function(flag: string): (string) -> (string?)
    if type(flag) ~= "string" then return task.spawn(error, "string expected, got "..type(flag)) end
    
    local cleanFlag = flag:gsub("^[DF]*Flag", ""):gsub("^[DF]*Int", ""):gsub("^[DF]*String", "")
    
    local value = getfflag(cleanFlag)
    if value ~= nil then
        return value
    else
        return task.spawn(error, "FFlag expected, got "..cleanFlag)
    end
end
