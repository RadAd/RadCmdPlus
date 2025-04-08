@echo off

if "%~1" == "/?" goto :_usage

where sed.exe > NUL 2>&1 || (echo Unable to find sed.exe >&2 & exit /b)

setlocal ENABLEDELAYEDEXPANSION
if not defined ESC set ESC=
set NOT_EXIST=%ESC%[31m
set DUPLICATE=%ESC%[32m
set RESET=%ESC%[0m
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
    echo.%DUPLICATE%%DIR% [Duplicate]%RESET%
) else if exist "%DIR:^=%" (
    echo.%DIR%
) else (
    echo.%NOT_EXIST%%DIR% [Not Exist]%RESET%
)
set %_%=1
goto :eof

:_usage
echo.%0 - print out path line by line
echo.
echo.Highlights duplicate entries and non-existant directories.
goto :eof
