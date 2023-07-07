New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Value $(Resolve-Path ~\.dotfiles\common\neovim\neovim)
