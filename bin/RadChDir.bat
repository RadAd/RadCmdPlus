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

endlocal && set RADCD_LAST=%CD% && call %CHDIR% %_% && call RadPostCd.bat
goto :eof

:usage
for %%i in (
    "{white}%~n0{reset} - Change current directory"
    ""
    "{white}%~n0{reset} {lt}{yellow}dir{reset}{gt}       - change directory to dir"
    ""
    "Will always change drive when necessary"
    "{quote}{white}-{reset}{quote} will change to last directory"
    "Network drives will use pushd instead"
    "{quote}{white}~{reset}{quote} will expand to the home directory"
    ""
    "All batch files in {white}%LOCALAPPDATA%\RadCmdPlus\PostCd{reset} will be executed after current directory is changed."
) do call RadColorEcho %%~i
goto :eof
