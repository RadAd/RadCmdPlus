# RadCmdPlus
Enhancements for cmd setup and use.

## Install

To install, clone the repository:
```
set RADCMDPLUSDIR=%LOCALAPPDATA%\Programs\RadSoft\RadCmdPlus
git clone https://github.com/RadAd/RadCmdPlus.git "%RADCMDPLUSDIR%"
```

Add the following lines to your cmd startup script:
```
set RADCMDPLUSDIR=%LOCALAPPDATA%\Programs\RadSoft\RadCmdPlus
call "%RADCMDPLUSDIR%\CmdStartup.bat"
```

## [CmdStartup](CmdStartup.bat)
Initializes the cmd environment.

For user customisation it executes all batch files in `%LOCALAPPDATA%\RadCmdPlus\Startup`,
and loads the aliases from `%LOCALAPPDATA%\RadCmdPlus\macros.dat`.

## [RadAlias](bin/RadAlias.bat)
Manage aliases for the command line.

**alias:** alias

## [RadChDir](bin/RadChDir.bat)
Enhancement over standard `chdir`:
- Will always change drive when necessary
- `-` will change to last directory
- Network drives will use pushd instead
- `~` will expand to the home directory

**alias:** cd, chdir

## [RadColorEcho](bin/RadColorEcho.bat)
Like echo with color.

## [RadDirBookmark](bin/RadDirBookmark.bat)
Directory bookmarks.

Save directory bookmarks to quickly change to later.

**alias:** bm

## [RadDirHistory](bin/RadDirHistory.bat)
Directory history.

Save directory changes in history to quickly change to later.

**alias:** scd

## [RadPostCd](bin/RadPostCd.bat)
All batch files in `%LOCALAPPDATA%\RadCmdPlus\PostCd` will be executed after current directory is changed.

## [RadPath](bin/RadPath.bat)
Manage the path.

Add, remove or list the directories in the path.

**alias:** path

## [RadPrintPath](bin/RadPrintPath.bat)
Print out path line by line.

Highlights duplicate entries and non-existant directories.

## [RadPrompt](bin/RadPrompt.bat)
Enhancement for the prompt.

A simple way to create a nice looking prompt.

## [RadShim](bin/RadShim.bat)
Shim management.

Use shims instead of extending the path.
