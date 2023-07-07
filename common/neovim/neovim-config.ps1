if (!(Test-Path -Path "$env:LOCALAPPDATA\nvim")) {
  New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Value $(Resolve-Path ~\.dotfiles\common\neovim\neovim) -ErrorAction SilentlyContinue | Out-Null 
} else { Write-Host "SymbolicLink already established"}



