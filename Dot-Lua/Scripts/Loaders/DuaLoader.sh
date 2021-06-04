ProcessId=$1
Location=$2
FileName=$3

echo $ProcessId
echo $Location
echo $FileName

echo Working
cp "$Location" "./Cache/Processes/$ProcessId/Archives/"
unzip ./Cache/Processes/$ProcessId/Archives/$FileName -d ./Cache/Processes/$ProcessId/UnpackCache/