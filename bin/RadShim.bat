@echo off
setlocal
set command=%~1

if not defined command (goto :usage)
if "%command%" == "create" shift & goto :create
if "%command%" == "/?" goto :usage
echo Unknown command: %1 >&2
goto :eof

:create
if "%~1" == "" (echo Missing target >&2 & exit /b 1)
if not "%~2" == "" (echo Too many parameters >&2 & exit /b 1)

if not exist %1 (echo Cannot find target >&2 & exit /b 1)
if not exist %LOCALAPPDATA%\RadCmdPlus\Shims md %LOCALAPPDATA%\RadCmdPlus\Shims
echo.Shim: %1
echo.@rem Prog=%1> "%LOCALAPPDATA%\RadCmdPlus\Shims\%~n1.bat"
echo.@%1 %%*>> "%LOCALAPPDATA%\RadCmdPlus\Shims\%~n1.bat"
echo.@%1 %%*> "%LOCALAPPDATA%\RadCmdPlus\Shims\%~nx1.bat"
echo.@%1 %%*>> "%LOCALAPPDATA%\RadCmdPlus\Shims\%~nx1.bat"
goto :eof

:usage
echo.%0 - Shim management
echo.
echo.%0 create ^<target^>    Create a shim for the target executable
goto :eof
