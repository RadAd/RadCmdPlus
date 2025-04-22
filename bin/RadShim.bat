@echo off
setlocal
if not defined RAD_SHIM_DIR set RAD_SHIM_DIR=%LOCALAPPDATA%\RadCmdPlus\Shims
set command=%~1

if not defined command (goto :usage)
if "%command%" == "create" shift & goto :create
if "%command%" == "check" shift & goto :check
if "%command%" == "/?" goto :usage
echo Unknown command: %1 >&2
goto :eof

:create
if "%~1" == "" (echo Missing target >&2 & exit /b 1)
if not "%~2" == "" (echo Too many parameters >&2 & exit /b 1)

if not exist %1 (echo Cannot find target: %ANSI_RED%%1%ANSI_RESET% >&2 & exit /b 1)
if not exist %RAD_SHIM_DIR% md %RAD_SHIM_DIR%
echo.Shim: %ANSI_BLUE%%1%ANSI_RESET%
echo.@rem Prog=%1> "%RAD_SHIM_DIR%\%~n1.bat"
echo.@%1 %%*>> "%RAD_SHIM_DIR%\%~n1.bat"
if /I not "%~x1" == ".bat" (
    echo.@rem Prog=%1> "%RAD_SHIM_DIR%\%~nx1.bat"
    echo.@%1 %%*>> "%RAD_SHIM_DIR%\%~nx1.bat"
)
goto :eof

:check
set _=
for /f "tokens=1,* delims==" %%i in (%RAD_SHIM_DIR%\%~1.bat) do @(if "%%i"=="@rem Prog" set _=%%j)
if not defined _ (echo Cannot determine shim program: %ANSI_YELLOW%%1%ANSI_RESET% >&2 & exit /b 1)
if not exist %_% (echo Shim doesn't exist: %ANSI_RED%%_%%ANSI_RESET% & exit /b 1)
echo Shim exists: %ANSI_GREEN%%_%%ANSI_RESET%
goto :eof

:usage
echo.%0 - Shim management
echo.
echo.%0 create ^<target^>    Create a shim for the target executable
echo.
echo.Shims are created in directory: %RAD_SHIM_DIR%
goto :eof
