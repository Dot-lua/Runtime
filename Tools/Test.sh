
cp -rv ../Dot-Lua ./

#cp ../Scripts/Launchers/Dotter.bat ./
#cp ../Scripts/Launchers/Dotter.sh ./

chmod +x ./Dotter.sh

chmod +x ./Dotter/Scripts/Builders/Build.sh
chmod +x ./Dotter/Scripts/Init/DownloadTemplate.sh

cd Dotter


mkdir Output
cd Output
mkdir Cache
mkdir Libraries
mkdir Data
mkdir Build
cd ..

mkdir Run
mkdir deps

mkdir Envoirment
cd Envoirment

#cp "C:\Program Files (x86)\Resource Hacker" ./ResourceHacker

cp -rv ../../../Tools/Envoirment/Luvit ./

cd ..
cd ..

cp -rv ../Tools/Envoirment/deps ./Dotter

touch "./Dotter/Config/VersionData.json"

echo '{"Tag-Version": "69.69.69", "_comment": "DONT CHANGE THIS!!!"}' > "./Dotter/Config/VersionData.json"

#echo $Value > "./Dotter/Config/VersionData.json"


clear
echo $Value
echo "Done"