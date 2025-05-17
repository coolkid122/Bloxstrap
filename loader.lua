repeat task.wait() until game:IsLoaded()
if getgenv().whenbloxisntstrapping then return end
local data = {...}
data = data[1]
local cloneref = cloneref or function(ref)
    return ref
end
getgenv().error = function(msg, lvl)
    appendfile('bloxstrap/logs/error.txt', `{msg}\n`)
    if getgenv().developer then
        task.spawn(getrenv().error, msg, lvl)
    end
end
getgenv().rewindCommit = data.Rewind or 0
getgenv().developer = data.Developer or false
getgenv().noshow = data.HideMenu or false
getgenv().assert = function(statement, err)
    if not statement then
        error(err)
    end
end
if isfolder('bloxstrap') and not isfile('reset') then
    writefile('reset', 'gg')
    if not getgenv().developer then
        for i,v in listfiles('bloxstrap') do
            if v ~= 'bloxstrap/logs' then
                if table.find({'.lua', '.txt'}, v:sub(#v - 3, #v)) then
                    delfile(v)
                else
                    delfolder(v)
                end
            end
        end 
    end
end
if not isfolder('bloxstrap') or not isfolder('bloxstrap/logs') then
    makefolder('bloxstrap')
    for i: number, v: string in {'audios', 'core', 'images', 'logs', 'fonts', 'logs/cache'} do
        makefolder(`bloxstrap/{v}`)
    end
    writefile('bloxstrap/loader.lua', `loadstring(game:HttpGet('https://raw.githubusercontent.com/new-qwertyui/Bloxstrap/refs/heads/main/loader.lua', true))()`)
    writefile('bloxstrap/main.lua', `loadstring(game:HttpGet('https://raw.githubusercontent.com/new-qwertyui/Bloxstrap/refs/heads/main/main.lua', true))()`)
    writefile('bloxstrap/audios/oof sound.mp3', game:HttpGet('https://raw.githubusercontent.com/new-qwertyui/Bloxstrap/refs/heads/main/audios/oof sound.mp3', true))
end
if not isfile('bloxstrap/selected.txt') then
    writefile('bloxstrap/selected.txt', 'fluent')
end
if not isfolder('bloxstrap/logs/cache') then
    makefolder('bloxstrap/logs/cache')
end
if not isfolder('bloxstrap/songs') then
    makefolder('bloxstrap/songs')
end
if not isfolder('bloxstrap/logs/blacklisted') then
    makefolder('bloxstrap/logs/blacklisted')
end
if not isfolder('bloxstrap/logs/blacklisted') then
    makefolder('bloxstrap/logs/blacklisted')
end
assert(setfflag, `Your executor ({identifyexecutor()}) doesn't have the required functions for this to work.`)
writefile('bloxstrap/logs/error.txt', '')

if getconnections and not developer then
    for i,v in getconnections(cloneref(game:GetService('LogService')).MessageOut) do
        v:Disable()
    end
    for i,v in getconnections(cloneref(game:GetService('ScriptContext')).Error) do
        v:Disable()
    end
end

return loadfile('bloxstrap/main.lua')()
