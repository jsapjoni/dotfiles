try {
  $NewItemSymbolicLinkSplash = @{
    "ItemType" = "SymbolicLink"
    "Path" = "$HOME\.config\starship.toml" 
    "Value" = $(Resolve-Path ~\.dotfiles\common\starship\starship.toml)
    "ErrorAction" = "Stop"
  } ; New-Item @NewItemSymbolicLinkSplash | Out-Null 

}
catch [System.IO.IOException] {
  Write-Host "SymbolicLink already exists"
}
catch {
  Write-Host "Could not create new SymbolicLink"
}

try {
  if (!(Get-Content -Path $PROFILE.CurrentUserCurrentHost |
    Select-String -Pattern "Invoke-Expression \(&starship init powershell\)") -is [System.Object]) {
    "Invoke-Expression \(&starship init powershell\)" >> $PROFILE.CurrentUserCurrentHost
  }
}
catch {
  Write-Host "Could not write configuration to powershell profile"
}
