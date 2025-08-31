# Bloxstrap
A script that attempts to recreate Bloxstrap, so you can use FFlags without installing a program.

## Installation
```lua
getgenv().autosetup = {
    path = 'Bloxstrap', -- doesnt work rn
    setup = true -- init after installation
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/coolkid122/Bloxstrap/master/Initiate.lua", true))()
```
