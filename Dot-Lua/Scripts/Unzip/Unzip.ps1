# file gotten from
# https://stackoverflow.com/questions/32526175/extract-a-certain-file-from-zip-via-powershell-seems-like-not-to-look-in-sub-fol

$sourceFile = $args[0]

Add-Type -Assembly System.IO.Compression.FileSystem
$zip = [IO.Compression.ZipFile]::OpenRead($sourceFile)
$zip.Entries | Where-Object {$_.Name -like '*.update'} | ForEach-Object {[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "C:\temp\test", $true)}
$zip.Dispose()