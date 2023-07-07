try {
  New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Value $(Resolve-Path ~\.dotfiles\common\neovim\neovim) 
}
catch [System.IO.IOException] {
  Write-Host "SymbolicLink already exists"
}
catch {
  Write-Host "Could not create new SymbolicLink"
}

