echo off

:select
echo.
echo ======================
echo = 1 -- dump settings =
echo = 2 -- load settings =
echo = 0 -- exit          =
echo ======================
echo.

set /p choice="Select: "

if %choice%==1 goto :dump
if %choice%==2 goto :load
if %choice%==0 goto :eof

echo Wrong choice!
goto select

:dump
copy "%APPDATA%\VSCodium\User\settings.json" .\settings.json
call codium --list-extensions > vscodium.txt
goto :select

:load
copy .\settings.json "%APPDATA%\VSCodium\User\"
for /f %%l in (vscodium.txt) do (
	call codium --install-extension %%l --force
)
goto :select
