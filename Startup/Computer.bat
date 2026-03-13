for %%f in ("%RADCMDPLUSUSERDIR%\Startup\%COMPUTERNAME%\*.bat") do @(
  rem echo "%%f"
  call "%%f" || echo Error in "%%f" & ver > nul
)
