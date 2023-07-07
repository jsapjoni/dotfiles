if ($PSVersionTable.PSEdition -ne "Core") {
  if ($null -ne (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    pwsh.exe -File $($MyInvocation.MyCommand.Definition)
    exit
  }
  else {
    Write-Host "Powershell Core (pwsh) is not available, please install the shell."
    exit
  }
}

$AppSource = "$($MyInvocation.MyCommand.Definition | Split-Path)\config"
if (!(Test-Path -Path $PROFILE.CurrentUserCurrentHost)) {
  New-Item -Path $PROFILE.CurrentUserCurrentHost -ItemType File -Force | Out-Null 
  Write-Host "Generated a new profile at path: " -NoNewline
  Write-Host "$($PROFILE.CurrentUserCurrentHost)" -ForegroundColor Green
  $CopyItemArgs = @{
    "Path" = "$AppSource\PSProfile.ps1"
    "Destination" = $PROFILE.CurrentUserCurrentHost
  } ; Copy-Item @CopyItemArgs
}
else {
  Write-Host "The path " -NoNewline
  Write-Host "$($PROFILE.CurrentUserCurrentHost) " -ForegroundColor Green -NoNewline
  Write-Host "has already profile, delete the old profile and import again."
}


