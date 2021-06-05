$RuntimePath = $args[0]
$ProcessId = $args[1]
$Location = $args[2]
$FileName = $args[3]

$global:ProgressPreference = 'SilentlyContinue'

Copy-Item -Path "$Location" -Destination "$RuntimePath/Cache/Processes/$ProcessId/Archives/"

Move-Item -Path "$RuntimePath/Cache/Processes/$ProcessId/Archives/$FileName" -Destination "$RuntimePath/Cache/Processes/$ProcessId/Archives/$FileName.zip"

Expand-Archive -Path "$RuntimePath/Cache/Processes/$ProcessId/Archives/$FileName.zip" -DestinationPath "$RuntimePath/Cache/Processes/$ProcessId/UnpackCache/"

Move-Item -Path "$RuntimePath/Cache/Processes/$ProcessId/Archives/$FileName.zip" -Destination "$RuntimePath/Cache/Processes/$ProcessId/Archives/$FileName"