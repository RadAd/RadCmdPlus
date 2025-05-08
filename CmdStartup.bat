for %%i in (
    "%~dp0bin"
    "%PROGRAMDATA%\RadCmdPlus\Shims"
    "%LOCALAPPDATA%\RadCmdPlus\Shims"
) do if exist %%i call "%~dp0bin\RadPath.bat" /q add %%i

if not defined RADCMDPLUS_CHDIR set RADCMDPLUS_CHDIR=RadChDir
doskey /MACROFILE="%~dp0macros.dat"
if exist "%LOCALAPPDATA%\RadCmdPlus\macros.dat" doskey /MACROFILE="%LOCALAPPDATA%\RadCmdPlus\macros.dat"
for %%f in ("%LOCALAPPDATA%\RadCmdPlus\Startup\*.bat") do (
    rem echo --- "%%f"
    call "%%f" || echo Error in "%%f"
)

Rem running in the built-in terminal has problems with this
call RadPostCd.bat
