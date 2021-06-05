$Path = Resolve-Path -Path "$PSScriptRoot/.."

Set-Alias -Name Dot-Lua -Value "$PSScriptRoot/Windows.ps1" -Description "Dot-Lua Runtime"

Powershell -Command "$Path/Envoirment/Luvit/luvit $Path/Main.lua Windows $args"

