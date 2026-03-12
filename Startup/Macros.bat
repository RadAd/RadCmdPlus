for %%i in (
    "%RADCMDPLUSDIR%macros.dat"
    "%RADCMDPLUSUSERDIR%\macros\macros.dat"
    "%RADCMDPLUSUSERDIR%\macros\macros.%COMPUTERNAME%.dat"
) do if exist %%i doskey /MACROFILE=%%i
