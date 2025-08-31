
local hidegui = getgenv().hideui or false
local cloneref = cloneref or function(...) return ... end
local httpservice = cloneref(game:GetService('HttpService'))
local getasync = function(string)
    return game:HttpGet(string, true)
end

makefolder('Bloxstrap')
makefolder('Bloxstrap/Main')
makefolder('Bloxstrap/Main/Functions')
makefolder('Bloxstrap/Main/Configs')
makefolder('Bloxstrap/Main/Fonts')
makefolder('Bloxstrap/Images')

local install = function(config)
    config = config or {}
    
    for i, v in pairs(httpservice:JSONDecode(getasync('https://api.github.com/repos/coolkid122/Bloxstrap/contents/'))) do
        if v.name:find('.lua$') then
            writefile('Bloxstrap/' .. v.name, getasync('https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/' .. v.name))
        elseif v.name:find('.mp3$') or v.name:find('.png$') then
            writefile('Bloxstrap/' .. v.name, getasync('https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/' .. v.name))
        end
    end
    
    writefile('Bloxstrap/Main/Bloxstrap.lua', getasync('https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/Main/Bloxstrap.lua'))
    
    for i, v in pairs(httpservice:JSONDecode(getasync('https://api.github.com/repos/coolkid122/Bloxstrap/contents/Main/Functions'))) do
        writefile('Bloxstrap/Main/Functions/' .. v.name, getasync('https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/Main/Functions/' .. v.name))
    end
    
    writefile("Bloxstrap/Main/Configs/Default.json", "{}")
end

if not isfolder('Bloxstrap') or #listfiles('Bloxstrap') <= 6 then
    install({})
end

local success, result = pcall(function()
    return loadfile('Bloxstrap/Main/Bloxstrap.lua')()
end)

if success then
    local Bloxstrap = result
    Bloxstrap.start() 
    Bloxstrap.Visible(not hidegui)
else
    warn("Failed to load Bloxstrap: " .. tostring(result))
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Bloxstrap Error",
        Text = "Failed to load UI. Check console for details.",
        Duration = 10
    })
end
