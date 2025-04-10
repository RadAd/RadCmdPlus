@echo off
setlocal ENABLEDELAYEDEXPANSION
set name=.dirbookmarks
set file=%LOCALAPPDATA%\RadCmdPlus\%name%
set command=%~1

if not defined RADCMDPLUS_CHDIR set RADCMDPLUS_CHDIR=cd /d

if not defined command (where fzf > NUL 2>&1 && goto :search || goto :list)
if "%command%" == "add" shift & goto :add
if "%command%" == "delete" shift & goto :delete
if "%command%" == "go" shift & goto :cd
if "%command%" == "search" shift & goto :search
if "%command%" == "list" shift & goto :list
if "%command%" == "/?" goto :usage
if "%command%" == "file" echo %file% & goto :eof
(where fzf > NUL 2>&1 && goto :searchpre || goto :cd)
goto :eof

:add
if "%~1" == "" (echo Missing directory >&2 & exit /b 1)
if not "%~2" == "" (echo Too many parameters >&2 & exit /b 1)
setlocal
cd /d %1 && echo.!CD!>> "%file%"
endlocal
goto :eof

:delete
if "%~1" == "" (echo Missing directory >&2 & exit /b 1)
if not "%~2" == "" (echo Too many parameters >&2 & exit /b 1)
if not exist "%file%" (echo No bookmarks >&2 & exit /b 1)
findstr /X /I /V /C:"%~1" "%file%" > "%file%.new"
del "%file%"
ren "%file%.new" %name%
goto :eof

:cd
if "%~1" == "" (echo Missing bookmark number >&2 & exit /b 1)
if not "%~2" == "" (echo Too many parameters >&2 & exit /b 1)
if not exist "%file%" (echo No bookmarks >&2 & exit /b 1)
set LINE=%1
set dir=
for /f "usebackq tokens=1,* delims=:" %%i in (`type "%file%" ^| findstr /N /V ? ^| findstr /B /C:"%LINE%:"`) do @set dir=%%j
if not defined dir (echo Bookmark not found >&2 & exit /b 1)
endlocal & %RADCMDPLUS_CHDIR% "%dir%"
goto :eof

:list
if not "%~1" == "" (echo Too many parameters >&2 & exit /b 1)
if not exist "%file%" (echo No bookmarks >&2 & exit /b 1)
rem type "%file%"
if exist "%file%" findstr /V /N ? "%file%"
goto :eof

:search
if not "%~1" == "" (echo Too many parameters >&2 & exit /b 1)
where fzf > NUL 2>&1 || (echo Cannot find fzf >&2 & exit /b 1)
if not exist "%file%" (echo No bookmarks >&2 & exit /b 1)
endlocal & for /f %%f in ('type "%file%" ^| fzf --height=~10 --exact') do @%RADCMDPLUS_CHDIR% %%f
goto :eof

:searchpre
where fzf > NUL 2>&1 || (echo Cannot find fzf >&2 & exit /b 1)
if not exist "%file%" (echo No bookmarks >&2 & exit /b 1)
endlocal & for /f %%f in ('type "%file%" ^| fzf --height=~10 --exact --query="%*" --select-1') do @%RADCMDPLUS_CHDIR% %%f
goto :eof

:usage
echo.%0 - Directory bookmarks
echo.
echo.%0 add ^<dir^>     To add directory
echo.%0 delete ^<dir^>  To delete directory
echo.%0 go ^<num^>      To change directory
echo.%0 list          To list bookmarks
echo.%0 search        To search bookmarks using fzf and change directory
echo.%0 ^<num^>         To change directory (if no fzf)
echo.%0 ^<search^>      To search bookmarks using fzf with initial search term and change directory
goto :eof
