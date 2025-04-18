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

## RadAlias
Manage aliases for the command line.

**alias:** alias

## RadChDir
Enhancement over standard `chdir`:
- Will always change drive when necessary
- `-` will change to last directory
- Network drives will use pushd instead
- `~` will expand to the home directory

**alias:** cd, chdir

## RadDirBookmark
Directory bookmarks.

Save directory bookmarks to quickly change to later.

**alias:** bm

## RadDirHistory
Directory history.

Save directory changes in history to quickly change to later.

**alias:** scd

## RadPostCd
All batch files in `%LOCALAPPDATA%\RadCmdPlus\PostCd` will be executed after current directory is changed.

## RadPath
Manage the path.

Add, remove or list the directories in the path.

**alias:** path

## RadPrintPath
Print out path line by line.

Highlights duplicate entries and non-existant directories.

## RadPrompt
Enhancement for the prompt.

A simple way to create a nice looking prompt.

## RadShim
Shim management.

Use shims instead of extending the path.
