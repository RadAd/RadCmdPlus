@echo off
setlocal
set name=.dirhistory
set file=%LOCALAPPDATA%\RadCmdPlus\%name%
set command=%~1

if not defined RADCMDPLUS_CHDIR set RADCMDPLUS_CHDIR=cd /d

if not defined command (where fzf > NUL 2>&1 && goto :search || goto :list)
if "%command%" == "add" shift & goto :add
if "%command%" == "search" shift & goto :search
if "%command%" == "list" shift & goto :list
if "%command%" == "/?" goto :usage
if "%command%" == "file" echo %file% & goto :eof
(where fzf > NUL 2>&1 && goto :searchpre || goto :listpre)
goto :eof

:add
if not "%~1" == "" (echo Too many parameters && exit /b 1)
set CD_FIND=%CD%
set CD_FIND=%CD_FIND:\=\\%
findstr /X /I /V /C:"%CD_FIND%" "%file%" > "%file%.new"
del "%file%"
ren "%file%.new" %name%
echo.%CD%>> "%file%"
goto :eof

:search
if not "%~1" == "" (echo Too many parameters && exit /b 1)
where fzf > NUL 2>&1 || (echo Cannot find fzf && exit /b 1)
endlocal & for /f %%f in ('type "%file%" ^| fzf --tac --height=~10 --exact --scheme=history') do @%RADCMDPLUS_CHDIR% %%f
goto :eof

:searchpre
where fzf > NUL 2>&1 || (echo Cannot find fzf && exit /b 1)
endlocal & for /f %%f in ('type "%file%" ^| fzf --tac --height=~10 --exact --scheme=history --query="%*" --select-1') do @%RADCMDPLUS_CHDIR% %%f
goto :eof

:list
if not "%~1" == "" (echo Too many parameters && exit /b 1)
rem tail "%file%"
for /F "usebackq tokens=3,3 delims= " %%l IN (`find /c /v "" %file%`) DO (call SET find_lc=%%l)
set /a skiplines=%find_lc% - 10
more +%skiplines% %file%
goto :eof

:listpre
findstr /I /C:"%1" "%file%"
goto :eof

:usage
echo.%0 - Directory history
echo.
echo.%0 add           To add current directory
echo.%0 list          To list last 10 directories
echo.%0 search        To search bookmarks using fzf and change directory
echo.%0 ^<search^>      To search history (if no fzf)
echo.%0 ^<search^>      To search history using fzf with initial search term and change directory
goto :eof
