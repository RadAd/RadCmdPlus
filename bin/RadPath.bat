@echo off
setlocal ENABLEDELAYEDEXPANSION
prompt $G$S
if "%~1" == "/q" shift & set RADPATH_QUIET=true
set command=%~1& shift
if "%~1" == "/q" shift & set RADPATH_QUIET=true

rem TODO 'Remove' may fail if its the last path

if not defined command (call RadPrintPath.bat & goto :eof)
if "%command%" == "add" goto :add
if "%command%" == "addend" goto :addend
if "%command%" == "remove" goto :remove
if "%command%" == "list" (call RadPrintPath.bat & goto :eof)
if "%command%" == "/?" goto :usage
echo Unknown command: %1>&2
goto :eof

:usage
for %%i in (
    "{white}%~n0{reset} - Path management"
    ""
    "{white}%~n0{reset} {yellow}add{reset} {lt}{yellow}target{reset}{gt}      Add a directory to the start of path"
    "{white}%~n0{reset} {yellow}addend{reset} {lt}{yellow}target{reset}{gt}   Add a directory to the end of path"
    "{white}%~n0{reset} {yellow}remove{reset} {lt}{yellow}target{reset}{gt}   Remove a directory from the path"
    "{white}%~n0{reset} {yellow}list{reset}              List directories in the path"
) do call RadColorEcho %%~i
goto :eof

:add
rem echo Adding %1
rem echo on
if not exist %1 (echo Directory doesn't exist: %1>&2 & exit /b 1)
set _=%PATH%
set _=!_:%~dpnx1;=!
set _=!_:;%~dpnx1=!
if not "%_%" == "%PATH%" ((if not defined RADPATH_QUIET echo Path already added: %1>&2) & exit /b 1)
endlocal
path %~dpnx1;%PATH%
goto :eof

:addend
rem echo Adding %1
rem echo on
if not exist %1 (echo Directory doesn't exist: %1>&2 & exit /b 1)
set _=%PATH%
set _=!_:%~dpnx1;=!
set _=!_:;%~dpnx1=!
if not "%_%" == "%PATH%" ((if not defined RADPATH_QUIET echo Path already added: %1>&2) & exit /b 1)
endlocal
path %PATH%;%~dpnx1
goto :eof

:remove
set _=%PATH%
set _=!_:%~dpnx1;=!
set _=!_:;%~dpnx1=!
if "%_%" == "%PATH%" ((if not defined RADPATH_QUIET echo Directory not in path: %1>&2) & exit /b 1)
endlocal & path %_%
goto :eof
