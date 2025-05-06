@echo off
setlocal ENABLEDELAYEDEXPANSION
prompt $G$S
set command=%~1

rem TODO May fail if its the last path

if not defined command (call RadPrintPath.bat & goto :eof)
if "%command%" == "add" shift & goto :add
if "%command%" == "remove" shift & goto :remove
if "%command%" == "list" shift & goto :list
if "%command%" == "/?" goto :usage
echo Unknown command: %1 >&2
goto :eof

:usage
echo.%0 - Path management
echo.
echo.%0 add ^<target^>      Add a directory to the path
echo.%0 remove ^<target^>   Remove a directory from the path
echo.%0 list              List directories in the path
goto :eof

:add
rem echo Adding %1
rem echo on
if not exist %1 (echo Directory doesn't exist: %1 >&2 & exit /b 1)
set _=%PATH%
set _=!_:%~1;=!
set _=!_:;%~1=!
if not "%_%" == "%PATH%" (echo Path already added: %1 >&2 & exit /b 1)
endlocal
path %1;%PATH%
goto :eof

:remove
set _=%PATH%
set _=!_:%~1;=!
set _=!_:;%~1=!
if "%_%" == "%PATH%" (echo Directory not in path: %1 >&2 & exit /b 1)
endlocal & path %_%
goto :eof
