$SendArguments = args[0]

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("%TEMP%/DuaTemp.lnk")
$shortcut.IconLocation = "../../Assets/Logo.png"
$shortcut.TargetPath = "../../Launchers/Windows.ps1"
$shortcut.Arguments = "$SendArguments -nogui"
$shortcut.Save()