
local hidegui = getgenv().hideui or false

local cloneref = cloneref or function(x) return x end
local httpservice = cloneref(game:GetService("HttpService"))

local function getasync(url)
    return game:HttpGet(url, true)
end

if not isfolder("Bloxstrap") then
    makefolder("Bloxstrap")
    makefolder("Bloxstrap/Main")
    makefolder("Bloxstrap/Main/Functions")
    makefolder("Bloxstrap/Main/Configs")
    makefolder("Bloxstrap/Main/Fonts")
    makefolder("Bloxstrap/Images")
end

local function install(config)
    config = config or {}

    local mainFiles = httpservice:JSONDecode(getasync("https://api.github.com/repos/coolkid122/Bloxstrap/contents/"))
    for i, v in pairs(mainFiles) do
        if v.name:find(".lua") then
            writefile("Bloxstrap/"..v.name, "return loadstring(game:HttpGet('https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/"..v.name.."', true))()")
        elseif v.name:find(".mp3") or v.name:find(".png") then
            writefile("Bloxstrap/"..v.name, game:HttpGet("https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/"..v.name))
        end
    end

    writefile("Bloxstrap/Main/Bloxstrap.lua", "return loadstring(game:HttpGet('https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/Main/Bloxstrap.lua', true))()")

    local funcFiles = httpservice:JSONDecode(getasync("https://api.github.com/repos/coolkid122/Bloxstrap/contents/Main/Functions"))
    for i, v in pairs(funcFiles) do
        writefile("Bloxstrap/Main/Functions/"..v.name, "return loadstring(game:HttpGet('https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/Main/Functions/"..v.name.."', true))()")
    end

    writefile("Bloxstrap/Main/Configs/Default.json", "{}")
end

if not isfolder("Bloxstrap") or #listfiles("Bloxstrap") <= 6 then
    install({})
end

local Bloxstrap = loadfile("Bloxstrap/Main/Bloxstrap.lua")()
Bloxstrap.start()
Bloxstrap.Visible(not hidegui)
