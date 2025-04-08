@echo off
if "%~1"=="/?" goto :usage

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
echo.%~n0 - Processing after change of directory
echo.
echo.  All batch files in "%LOCALAPPDATA%\RadCmdPlus\PostCd" will be executed after current directory is changed.
goto :eof
