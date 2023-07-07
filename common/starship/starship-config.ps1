New-Item -Path "~\.config\starship.toml" -ItemType SymbolicLink -Value $(Resolve-Path ~\.dotfiles\common\starship\starship.toml) | Out-Null
