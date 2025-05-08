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
for %%i in (
    "{white}%~n0{reset} - Processing after change of directory"
    ""
    "All batch files in {white}%LOCALAPPDATA%\RadCmdPlus\PostCd{reset} will be executed after current directory is changed."
) do call RadColorEcho %%~i
goto :eof
