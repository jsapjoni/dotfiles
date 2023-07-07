if (!(Test-Path -Path "$HOME\.config\starship.toml")) {
  New-Item -ItemType SymbolicLink -Path "$HOME\.config\starship.toml" -Value $(Resolve-Path ~\.dotfiles\common\starship\starship.toml) -ErrorAction SilentlyContinue | Out-Null 
} else { Write-Host "SymbolicLink already established"}
