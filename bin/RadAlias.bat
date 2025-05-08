@echo off
setlocal
if "%~1" == "/?" goto :usage
if "%~1" == "" goto :list

goto :set
goto :eof

:usage
for %%i in (
    "{white}%~n0{reset} - Create an alias or print out list of aliases"
    ""
    "{white}%~n0{reset} [{yellow}name{reset}]=[{yellow}text{reset}]       - create an alias"
    "{white}%~n0{reset} [{yellow}name{reset}]              - display an alias"
    "{white}%~n0{reset}                     - list all aliases"
) do call RadColorEcho %%~i
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
