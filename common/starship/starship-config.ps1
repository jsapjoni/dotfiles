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
  if (!(Get-Content -Path "$HOME\Documents\Powershell\Microsoft.PowerShell_profile.ps1"|
    Select-String -Pattern "Invoke-Expression \(&starship init powershell\)") -is [System.Object]) {
    "\(&starship init powershell\) | iex" | Out-File -FilePath "$HOME\Documents\Powershell\Microsoft.PowerShell_profile.ps1" -Append
  }
  else {
    
  }
}
catch {
  Write-Host "Could not write configuration to powershell profile"
}
