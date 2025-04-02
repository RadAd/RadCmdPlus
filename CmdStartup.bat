path %LOCALAPPDATA%\RadCmdPlus\Shims;%PROGRAMDATA%\RadCmdPlus\Shims;%~dp0bin;%PATH%

set RADCMDPLUS_CHDIR=RadChDir
doskey /MACROFILE="%~dp0macros.dat"
Rem running in the built-in terminal has problems with this
call %RADCMDPLUS_CHDIR% .
