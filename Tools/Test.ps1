
Copy-Item ../Dotter -Recurse -Destination ./Dotter

Copy-Item ../Scripts/Launchers/Dotter.bat -Recurse -Destination ./
Copy-Item ../Scripts/Launchers/Dotter.sh -Recurse -Destination ./

Set-Location Dotter


mkdir Output
Set-Location Output
mkdir Cache
mkdir Libraries
mkdir Data
mkdir Build
Set-Location ..

mkdir Run

mkdir Envoirment
Set-Location Envoirment

Copy-Item "C:\Program Files (x86)\Resource Hacker" -Recurse -Destination ./ResourceHacker

Copy-Item ../../../Tools/Envoirment/Luvit -Recurse -Destination ./
Copy-Item ../../../Tools/Envoirment/ffmpeg -Recurse -Destination ./
Copy-Item ../../../Tools/Envoirment/upx -Recurse -Destination ./

Set-Location ..
Set-Location ..

Copy-Item ../Tools/Envoirment/deps -Recurse -Destination ./Dotter/


$Value = ""
$Value += '{"Tag-Version": "'
$Value += '69.69.69'
$Value += '", "_comment": "DONT CHANGE THIS!!!"}'
Set-Content -Path ./Dotter/Config/VersionData.json -Value $Value

Clear-Host
Write-Output "Done"