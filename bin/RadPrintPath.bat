@echo off

if "%~1" == "/?" (goto :_usage || goto :eof)

where sed.exe > NUL 2>&1 || (echo Unable to find sed.exe& exit /b)

if "%~1"=="/check" (goto :check || goto :eof)

echo.%PATH%| sed.exe "s/;/\n/g"|%0 /check
goto :eof

:check
setlocal ENABLEDELAYEDEXPANSION
if not defined ESC set ESC=
set NOT_EXIST=%ESC%[31m
set DUPLICATE=%ESC%[32m
set RESET=%ESC%[0m
for /f "delims=" %%i in ('more') do @call :process "%%i"
goto :eof

:process
set _=%~1
set _=%_: =_%
set _=%_::=_%
set _=%_:\=_%
set _=%_:(=_%
set _=%_:)=_%

set DIR=%~1
set DIR=%DIR:)=^^)%

if defined %_% (
    echo.%DUPLICATE%%DIR% [Duplicate]%RESET%
) else if exist %1 (
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
