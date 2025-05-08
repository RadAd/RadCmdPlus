@echo off
setlocal ENABLEDELAYEDEXPANSION
prompt $G$S
set command=%~1
if "%command%" == "/q" shift & set RADPATH_QUIET=true & set command=%~2

rem TODO May fail if its the last path

if not defined command (call RadPrintPath.bat & goto :eof)
if "%command%" == "add" shift & goto :add
if "%command%" == "addend" shift & goto :addend
if "%command%" == "remove" shift & goto :remove
if "%command%" == "list" shift & goto :list
if "%command%" == "/?" goto :usage
echo Unknown command: %1>&2
goto :eof

:usage
for %%i in (
    "{white}%~n0{reset} - Path management"
    ""
    "{white}%~n0{reset} {yellow}add{reset} {lt}{yellow}target{reset}{gt}      Add a directory to the path"
    "{white}%~n0{reset} {yellow}remove{reset} {lt}{yellow}target{reset}{gt}   Remove a directory from the path"
    "{white}%~n0{reset} {yellow}list{reset}              List directories in the path"
) do call RadColorEcho %%~i
goto :eof

:add
rem echo Adding %1
rem echo on
if not exist %1 (echo Directory doesn't exist: %1>&2 & exit /b 1)
set _=%PATH%
set _=!_:%~1;=!
set _=!_:;%~1=!
if not "%_%" == "%PATH%" ((if not defined RADPATH_QUIET echo Path already added: %1>&2) & exit /b 1)
endlocal
path %~1;%PATH%
goto :eof

:addend
rem echo Adding %1
rem echo on
if not exist %1 (echo Directory doesn't exist: %1>&2 & exit /b 1)
set _=%PATH%
set _=!_:%~1;=!
set _=!_:;%~1=!
if not "%_%" == "%PATH%" ((if not defined RADPATH_QUIET echo Path already added: %1>&2) & exit /b 1)
endlocal
path %PATH%;%~1
goto :eof

:remove
set _=%PATH%
set _=!_:%~1;=!
set _=!_:;%~1=!
if "%_%" == "%PATH%" ((if not defined RADPATH_QUIET echo Directory not in path: %1>&2) & exit /b 1)
endlocal & path %_%
goto :eof
