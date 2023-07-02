New-Item -ItemType SymbolicLink -Target "$env:LOCALAPPDATA\nvim" -Path $(Resolve-Path -Path ~\.dotfiles\common\nvim)
