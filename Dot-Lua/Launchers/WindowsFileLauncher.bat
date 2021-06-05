echo Start

echo %*

pushd %~dp0
set script_dir=%CD%
popd

powershell -NoProfile -ExecutionPolicy unrestricted -File "%script_dir%/./Windows.ps1" "run %1"

pause