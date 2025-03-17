@echo off
setlocal ENABLEEXTENSIONS
set _=%~1
set CHDIR=cd /d

if not defined HOME set HOME=%HOMEDRIVE%%HOMEPATH%

if not defined _ (cd && goto :eof)
if "%_%"=="/?" goto :usage
if "%_%"=="-" set _=%RADCD_LAST%
if "%_:~0,1%"=="~" set _=%HOME%%_:~1%
if "%_:~0,2%"=="\\" set CHDIR=pushd

endlocal && set RADCD_LAST=%CD% && call %CHDIR% %_% && call :postcd
goto :eof

:postcd
for %%f in ("%~dp0%..\PostCd\*.bat") do @(
  rem echo "%%f"
  call "%%f" || echo Error in "%%f"
)
for %%f in ("%LOCALAPPDATA%\RadCmdPlus\PostCd\*.bat") do @(
  rem echo "%%f"
  call "%%f" || echo Error in "%%f"
)
goto :eof

:usage
echo.RadChDir ^<cd^> - Change current directory
echo.
echo.  Will always change drive when necessary
echo.  "-" will change to last directory
echo.  Network drives will use pushd instead
echo.  "~" will expand to the home directory
echo.
echo.  All batch files in "%LOCALAPPDATA%\RadCmdPlus\PostCd" will be executed after current directory is changed.
goto :eof
