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

if not exist %1 (call RadColorEcho Cannot find target: {error}%1{reset} >&2 & exit /b 1)
if not exist %RAD_SHIM_DIR% md %RAD_SHIM_DIR%
call RadColorEcho Shim: {info}%1{reset}
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
if not defined _ (call RadColorEcho Cannot determine shim program: {warning}%1{reset} >&2 & exit /b 1)
if not exist %_% (call RadColorEcho Shim doesn't exist: {error}%_%{reset} & exit /b 1)
call RadColorEcho Shim exists: {green}%_%{reset}
goto :eof

:usage
for %%i in (
    "{white}%~n0{reset} - Shim management"
    ""
    "{white}%~n0{reset} {yellow}create{reset} {lt}{yellow}target{reset}{gt}    Create a shim for the target executable"
    ""
    "Shims are created in directory: {white}%RAD_SHIM_DIR%{reset}"
) do call RadColorEcho %%~i
goto :eof
