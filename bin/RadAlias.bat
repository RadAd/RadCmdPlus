@echo off
setlocal
if "%~1" == "/?" goto :usage
if "%~1" == "" goto :list

goto :set
goto :eof

:usage
echo %~n0 - create an alias or print out list of aliases
echo.
echo %~n0 [name]=[text]       - create an alias
echo %~n0 [name]              - display an alias
echo %~n0                     - list all aliases
goto :eof

:list
doskey /macros
goto :eof

:set
if "%~2"=="" goto :show
doskey %*
goto :eof

:show
doskey /macros | findstr /I ^^%1=
goto :eof
