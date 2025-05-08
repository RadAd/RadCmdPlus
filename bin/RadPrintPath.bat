@echo off

if "%~1" == "/?" goto :_usage

where sed.exe > NUL 2>&1 || (echo Unable to find sed.exe>&2 & exit /b)

setlocal ENABLEDELAYEDEXPANSION
if not defined ESC set ESC=
set NOT_EXIST={error}
set DUPLICATE={warning}
for /F "delims=" %%i in ('echo."%PATH:)=^)%" ^| sed.exe "s/;/""\n""/g"') do @if not %%i == "" call :process %%i
endlocal
goto :eof

:process
set _=%~1
set _=%_: =_%
set _=%_::=_%
set _=%_:\=_%
set _=%_:(=_%
set _=%_:)=_%

set DIR=%~1

if defined %_% (
    call RadColorEcho %DUPLICATE%%DIR% [Duplicate]{reset}
) else if exist "%DIR:^=%" (
    echo.%DIR%
) else (
    call RadColorEcho %NOT_EXIST%%DIR% [Not Exist]{reset}
)
set %_%=1
goto :eof

:_usage
for %%i in (
    "{white}%~n0{reset} - print out path line by line"
    ""
    "Highlights duplicate entries and non-existant directories."
) do call RadColorEcho %%~i
goto :eof
