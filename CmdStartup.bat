rem path %LOCALAPPDATA%\RadCmdPlus\Shims;%PROGRAMDATA%\RadCmdPlus\Shims;%~dp0bin;%PATH%
rem %RADPATH% add "%PROGRAMDATA%\RadCmdPlus\Shims"

for %%i in (
    "%~dp0bin"
    "%LOCALAPPDATA%\RadCmdPlus\Shims"
) do call "%~dp0bin\RadPath.bat" add %%i 2> NUL

set RADCMDPLUS_CHDIR=RadChDir
doskey /MACROFILE="%~dp0macros.dat"
if exist "%LOCALAPPDATA%\RadCmdPlus\macros.dat" doskey /MACROFILE="%LOCALAPPDATA%\RadCmdPlus\macros.dat"
for %%f in ("%LOCALAPPDATA%\RadCmdPlus\Startup\*.bat") do (
    rem echo --- "%%f"
    call "%%f" || echo Error in "%%f"
)

Rem running in the built-in terminal has problems with this
call RadPostCd.bat
