@echo off
setlocal ENABLEDELAYEDEXPANSION

if "%~1" == "" (goto :_usage || goto :eof)
if "%~1" == "/?" (goto :_usage || goto :eof)

set ESC=$E
set SPC=$S

rem Style settings

set LINE_START=
set LINE_END=
set LINE_MIX=%SPC%

set CALENDAR_ICON=$S
set TIME_ICON=$S
set FOLDER_ICON=$S
rem set REMOTE_ICON=歷$S
rem set REMOTE_ICON=力$S
set REMOTE_ICON=$S
set BRANCH_ICON=$S

rem ==============

if not defined HOME set HOME=%USERPROFILE%
if not defined RAD_PROMPT_COLORS set RAD_PROMPT_COLORS=31 32 33 34 35 36 37

set _=
set NEWLINE=1
set C=1
for %%i in (%RAD_PROMPT_COLORS%) do @call :_setcolor %%i
set C=1

set COLOR_BG_RESET=%ESC%[49m
set COLOR_RESET=%ESC%[39m
set COLOR_REVERSE=%ESC%[7m
set COLOR_NOT_REVERSE=%ESC%[27m

:_loop
if "%~1" == "" goto :_end
call :%1
shift
goto :_loop

:_end
set _=%_%%COLOR_BG_RESET%%COLOR_NOT_REVERSE%%LINE_END%%COLOR_RESET%
endlocal && prompt %_%
goto :eof

:_setcolor
set COLOR[%C%]=%1
set /a C=C+1
goto :eof

:_set_color
set COLOR_BEGIN=%1
if not defined COLOR_BEGIN set COLOR_BEGIN=31
set /A COLOR_END=COLOR_BEGIN + 10
set COLOR_BEGIN=%ESC%[%COLOR_BEGIN%m
set COLOR_END=%ESC%[%COLOR_END%m
goto :eof

:_add
call :_set_color !COLOR[%C%]!
if defined NEWLINE (
  set _=%_%%COLOR_BEGIN%%LINE_START%%COLOR_REVERSE%%*%COLOR_END%
) else (
  set _=%_%%COLOR_BEGIN%%LINE_MIX%%COLOR_BG_RESET%%*%COLOR_END%
)
set NEWLINE=
set /a C=C+1
goto :eof

:add_link
call :_add $E]8;;%1$E\%~2$E]8;;$E\
goto :eof

:nl
set _=%_%%COLOR_BG_RESET%%COLOR_NOT_REVERSE%%LINE_END%%COLOR_RESET%$_
set NEWLINE=1
goto :eof

:datetime
call :_add %CALENDAR_ICON%$D$S%TIME_ICON%$T$H$H$H$H$H$H$S
goto :eof

:path
call :add_link file://$P "%FOLDER_ICON%$P"
goto :eof

:homepath
call :add_link file://$P "%FOLDER_ICON%!CD:%HOME%=~!"
goto :eof

:remote
if defined REMOTE_UNC (call :_add %REMOTE_ICON%$M) else (set /a C=C+1)
goto :eof

:ssh
if defined SSHWINUSERDOMAIN (call :_add %REMOTE_ICON%%SSHWINUSERDOMAIN%$S) else (set /a C=C+1)
goto :eof

:branch
if defined GIT_BRANCH (call :_add %BRANCH_ICON%%GIT_BRANCH%) else (set /a C=C+1)
goto :eof

:_usage
for %%i in (
    "{white}%~n0{reset} - set your prompt"
    ""
    "  {yellow}datetime{reset}     - date and time"
    "  {yellow}path{reset}         - current path"
    "  {yellow}homepath{reset}     - shortened current path"
    "  {yellow}remote{reset}       - remote unc"
    "  {yellow}branch{reset}       - current git branch"
    ""
    "{yellow}homepath{reset} is not calculated dynamically. If the current directory changes then you need to run {white}%~n0{reset} again."
    ""
    "Git {yellow}branch{reset} is defined in the GIT_BRANCH environment variable. If this changes then you need to run {white}%~n0{reset} again."
    ""
    "eg. {white}%~n0{reset} {yellow}datetime remote homepath branch{reset}"
) do call RadColorEcho %%~i
goto :eof
