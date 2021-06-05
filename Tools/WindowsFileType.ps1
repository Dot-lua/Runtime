if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Write-Output "assoc"
cmd /c assoc .dua=DuaArchive
Write-Output "ftype"

$Launcher = Resolve-Path -Path "$PSScriptRoot/../Dot-Lua/Launchers/WindowsFileLauncher.bat"
$Icon = Resolve-Path -Path "$PSScriptRoot/../Dot-Lua/Assets/Logo.png"
Write-Output $Launcher

cmd /c ftype DuaArchive=$Launcher %%1 %%*
Write-Output done
Write-Output ""

#cmd /c REG ADD HKEY_CLASSES_ROOT\DuaArchive\DefaultIcon /v $Icon,1 /t REG_EXPAND_SZ /d $Icon,1

cmd /c ftype DuaArchive
cmd /c reg query HKCR\DuaArchive\SHELL\OPEN\COMMAND /ve

pause