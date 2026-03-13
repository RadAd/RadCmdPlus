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

Rem shortcircuit if inheriting from a process where it is already setup
if defined RADCMDPLUSDIR goto :end

set RADCMDPLUSDIR=%~dp0
set RADCMDPLUSUSERDIR=%LOCALAPPDATA%\RadCmdPlus
set RADCMDPLUSALLDIR=%PROGRAMDATA%\RadCmdPlus

call "%RADCMDPLUSDIR%bin\RadPath.bat" /q add "%RADCMDPLUSDIR%bin"

if not defined RADCMDPLUS_CHDIR set RADCMDPLUS_CHDIR=RadChDir

Rem ver > nul to clear error
for %%f in ("%RADCMDPLUSUSERDIR%\Startup\*.bat") do (
    rem echo --- "%%f"
    call "%%f" || echo Error in "%%f" & ver > nul
)

:end
Rem TODO Need a better way for always run batch files
if not defined RADLINE_DIR call "%RADCMDPLUSUSERDIR%\Startup\RadLine.bat"
call RadPostCd.bat
