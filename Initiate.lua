
local hidegui = getgenv().hideui or false

local cloneref = cloneref or function(x) return x end

local function safeSetFlag(name, value)
    pcall(function()
        setfflag(name, tostring(value))
    end)
end

local Flags = {
    DFIntTaskSchedulerTargetFps = "240",
    RenderingQualityFeatureEnabled = "true",
    DebugDisplayFPS = "true"
}

for name, value in pairs(Flags) do
    safeSetFlag(name, value)
end

local Bloxstrap
local success, result = pcall(function()
    Bloxstrap = loadstring(game:HttpGet("https://raw.githubusercontent.com/coolkid122/Bloxstrap/refs/heads/main/Main/Bloxstrap.lua", true))()
end)

if success and Bloxstrap then
    pcall(function() Bloxstrap.start() end)
    pcall(function() Bloxstrap.Visible(not hidegui) end)
else
    warn("Failed to load Mobile Bloxstrap, but FFlags applied")
end
