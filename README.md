# RadCmdPlus
Enhancements for cmd setup and use

## RadChDir
Enhancement over standard `chdir`:
- Will always drive when necessary
- "-" will change to last directory
- Network drives will use pushd instead
- "~" will expand to the home directory

### Post Change Directory
All batch files in "%LOCALAPPDATA%\RadCmdPlus\PostCd" will be executed after current directory is changed.

## RadPrompt
Enhancement for the prompt.
A simple way to create a nice looking prompt.
