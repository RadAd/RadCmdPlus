@echo off

Rem does cmd line contain "/C" and therefore will not enter interactive mode
setlocal
set _="%CMDCMDLINE%"
set _=%_:>=_%
set _=%_:<=_%
set _=%_:|=_%
set _=%_:&=_%
set _=%_:"=_%
rem ((echo. "%_%" | findstr /I /C:" /C ") > NUL 2> NUL) && echo done && goto :eof
if not "%_:* /C =%" == "%_%" (goto :eof)
endlocal

set RADCMDPLUSDIR=%~dp0
set RADCMDPLUSUSERDIR=%LOCALAPPDATA%\RadCmdPlus
set RADCMDPLUSALLDIR=%PROGRAMDATA%\RadCmdPlus

for %%i in (
    "%RADCMDPLUSDIR%bin"
    "%RADCMDPLUSALLDIR%\Shims"
    "%RADCMDPLUSUSERDIR%\Shims"
) do if exist %%i call "%RADCMDPLUSDIR%bin\RadPath.bat" /q add %%i

if not defined RADCMDPLUS_CHDIR set RADCMDPLUS_CHDIR=RadChDir

Rem ver > nul to clear error
for %%f in ("%RADCMDPLUSUSERDIR%\Startup\*.bat") do (
    rem echo --- "%%f"
    call "%%f" || echo Error in "%%f" & ver > nul
)

for %%f in ("%RADCMDPLUSUSERDIR%\Startup\%COMPUTERNAME%\*.bat") do (
    rem echo --- "%%f"
    call "%%f" || echo Error in "%%f" & ver > nul
)

Rem running in the built-in terminal has problems with this
call RadPostCd.bat
