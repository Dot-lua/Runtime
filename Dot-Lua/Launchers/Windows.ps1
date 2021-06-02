$Path = Resolve-Path -Path "$PSScriptRoot/.."

Powershell -Command "$Path/Envoirment/Luvit/luvit $Path/Main.lua Windows $args"