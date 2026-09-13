@echo off

:: Initialise special characters globally if they don't exist yet (saves CPU cycles)
if not defined _ESC_LF  for /F "delims=" %%a in ('echo^.') do set "_ESC_LF=%%a"
if not defined _ESC_ESC for /F %%a in ('echo off ^| choice /c e /n') do set "_ESC_ESC=%%a"
if not defined _ESC_CR  for /F %%a in ('copy /Z "%~f0" nul') do set "_ESC_CR=%%a"
if not defined _ESC_SUB for /F %%a in ('cmd /c exit 1') do set "_ESC_SUB=%%a"

:: Isolate environmental changes for the text processing step
setlocal EnableDelayedExpansion

if "%~1"=="" goto :eof

:: Bring global variables into local scope safely
set "LF=%_ESC_LF%"
set "ESC=%_ESC_ESC%"
set "CR=%_ESC_CR%"
set "SUB=%_ESC_SUB%"

:: Load the input text
set "text=%~1"

:: Safeguard escaped backslashes (\\)
set "text=!text:\\=%SUB%!"

:: Manually search and replace escape tokens
set "text=!text:\e=%ESC%!"
set "text=!text:\n=%LF%!"
set "text=!text:\r=%CR%!"
set "text=!text:\t=	!"

:: Restore the literal backslashes
set "text=!text:%SUB%=\!"

:: Print the final processed string without a trailing newline
<nul set /p "=!text!"

endlocal
