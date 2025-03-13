# RadCmdPlus
Enhancements for cmd setup and use.

## RadChDir
Enhancement over standard `chdir`:
- Will always drive when necessary
- `-` will change to last directory
- Network drives will use pushd instead
- `~` will expand to the home directory

**alias:** cd, chdir

### Post Change Directory
All batch files in `%LOCALAPPDATA%\RadCmdPlus\PostCd` will be executed after current directory is changed.

## RadPrompt
Enhancement for the prompt.

A simple way to create a nice looking prompt.

## RadPrintPath
Print out path line by line.

Highlights duplicate entries and non-existant directories.

**alias:** path

## RadDirBookmark
Directory bookmarks.

Save directory bookmarks to quickly change to later.

**alias:** bm
