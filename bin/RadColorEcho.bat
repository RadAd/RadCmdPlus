@echo off
setlocal ENABLEDELAYEDEXPANSION
rem TODO If output is not console then remove colors ie _isatty(fileno(stdout))

if not defined ESC set ESC=
if not defined BEL set BEL=

set "_=%*"
if not defined _ echo. & exit /b 0

set "_=%_:<=^<%"
set "_=%_:>=^>%"
set "_=%_:|=^|%"

set "_=!_:{gt}=^>!"
set "_=!_:{lt}=^<!"
set "_=!_:{pipe}=^|!"
rem set "_=!_:{quote}=""!"

set "_=!_:{reset}=%ESC%[0m!"
set "_=!_:{bold}=%ESC%[1m!"
set "_=!_:{underline}=%ESC%[4m!"
set "_=!_:{inverse}=%ESC%[7m!"

set "_=!_:{black}=%ESC%[30m!"
set "_=!_:{red}=%ESC%[31m!"
set "_=!_:{green}=%ESC%[32m!"
set "_=!_:{yellow}=%ESC%[33m!"
set "_=!_:{blue}=%ESC%[34m!"
set "_=!_:{purple}=%ESC%[35m!"
set "_=!_:{cyan}=%ESC%[36m!"
set "_=!_:{white}=%ESC%[37m!"

set "_=!_:{bgblack}=%ESC%[40m!"
set "_=!_:{bgred}=%ESC%[41m!"
set "_=!_:{bggreen}=%ESC%[42m!"
set "_=!_:{bgyellow}=%ESC%[43m!"
set "_=!_:{bgblue}=%ESC%[44m!"
set "_=!_:{bgpurple}=%ESC%[45m!"
set "_=!_:{bgcyan}=%ESC%[46m!"
set "_=!_:{bgwhite}=%ESC%[47m!"

set "_=!_:{bel}=%BEL%!
set "_=!_:{error}=%ESC%[31m!"
set "_=!_:{warning}=%ESC%[33m!"
set "_=!_:{info}=%ESC%[34m!"

set "_=%_%%ESC%[0m"
rem set "_=!_:%ESC%=\e!"

echo.%_:{quote}="%
