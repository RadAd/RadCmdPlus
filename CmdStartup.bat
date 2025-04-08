path %LOCALAPPDATA%\RadCmdPlus\Shims;%PROGRAMDATA%\RadCmdPlus\Shims;%~dp0bin;%PATH%

set RADCMDPLUS_CHDIR=RadChDir
doskey /MACROFILE="%~dp0macros.dat"
if exist "%LOCALAPPDATA%\RadCmdPlus\macros.dat" doskey /MACROFILE="%LOCALAPPDATA%\RadCmdPlus\macros.dat"
Rem running in the built-in terminal has problems with this
call RadPostCd.bat
