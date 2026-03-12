for %%i in (
    "%RADCMDPLUSALLDIR%\Shims"
    "%RADCMDPLUSUSERDIR%\Shims"
) do if exist %%i call RadPath.bat /q add %%i

rem set RAD_SHIM_DIR=%RADCMDPLUSUSERDIR%\Shims
