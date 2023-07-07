#if (!(Test-Path -Path "$env:LOCALAPPDATA\nvim")) {
#  New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Value $(Resolve-Path ~\.dotfiles\common\neovim\neovim) -ErrorAction SilentlyContinue | Out-Null 
#} else { Write-Host "SymbolicLink already established"}

try {
  New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Value $(Resolve-Path ~\.dotfiles\common\neovim\neovim) | Out-Null 
}
catch [System.IO.IOException] {
  Write-Host "SymbolicLink already exists"
}
catch {
  Write-Host "Could not create new SymbolicLink"
}
