$ProcessId = $args[1]
$Location = $args[2]
$FileName = $args[3]

Get-Location
Copy-Item -Path $Location -Destination ./Cache/Processes/$ProcessId/Archives/