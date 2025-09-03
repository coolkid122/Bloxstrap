
local hidegui = getgenv().hideui or false
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

if not isfolder("Bloxstrap") then
    makefolder("Bloxstrap")
    makefolder("Bloxstrap/Main")
    makefolder("Bloxstrap/Main/Functions")
    makefolder("Bloxstrap/Main/Configs")
    makefolder("Bloxstrap/Main/Fonts")
    makefolder("Bloxstrap/Images")
end

local function getasync(url)
    return game:HttpGet(url, true)
end

local function install()
    local files = game:GetService("HttpService"):JSONDecode(getasync("https://api.github.com/repos/coolkid122/Bloxstrap/contents/"))
    for _,v in pairs(files) do
        if v.name:find(".lua") or v.name:find(".mp3") or v.name:find(".png") then
            pcall(function() getasync("https://raw.githubusercontent.com/coolkid122/Bloxstrap/main/"..v.name) end)
        end
    end
end

if not isfolder("Bloxstrap") or #listfiles("Bloxstrap") <= 6 then
    install()
end

local success, Bloxstrap = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/coolkid122/Bloxstrap/main/Main/Bloxstrap.lua", true))()
end)

if success and Bloxstrap then
    pcall(function() Bloxstrap.start() end)
    task.defer(function()
        pcall(function()
            Bloxstrap.Visible(true)
            for _, gui in pairs(Bloxstrap:GetGuiObjects()) do
                if gui:IsA("ScreenGui") then
                    gui.Parent = CoreGui
                    gui.Enabled = true
                    gui.ResetOnSpawn = false
                    gui.IgnoreGuiInset = true
                end
            end
        end)
    end)
end
