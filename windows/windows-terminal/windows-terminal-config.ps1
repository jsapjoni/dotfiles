try {
  $NewItemSymbolicLinkSplash = @{
    "ItemType" = "SymbolicLink"
    "Path" = "$HOME\scoop\apps\windows-terminal\current\settings\settings.json"
    "Value" = $(Resolve-Path ~\.dotfiles\windows\windows-terminal\settings.json)
    "ErrorAction" = "Stop"
  } ; New-Item @NewItemSymbolicLinkSplash | Out-Null 
}
catch [System.IO.IOException] {
  Write-Host "SymbolicLink already exists"
}
catch {
  Write-Host "Could not create new SymbolicLink"
}
