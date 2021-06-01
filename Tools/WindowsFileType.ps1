if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Write-Output "assoc"
cmd /c assoc .dua=DuaArchive
Write-Output "ftype"

$Path = Resolve-Path -Path "$PSScriptRoot/../Dot-Lua/Launchers/WindowsFileLauncher.bat"

cmd /c ftype DuaArchive=$Path %1 %*
Write-Output done
Write-Output ""
pause