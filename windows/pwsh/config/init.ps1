$Dependencies = @{
  "PSReadLine" = @("PS7", "PS5")
  "posh-git" = @("PS7", "PS5")
  "Terminal-Icons" = @("PS7", "PS5")
  "PSFzf" = @("PS7", "PS5")
  "Microsoft.Online.SharePoint.PowerShell" = @("PS5")
  "PnP.PowerShell" = @("PS7", "PS5")
  "Arkivverket.SharePoint.Utility" = @("PS7", "PS5")
  "ModuleBuilder" = @("PS7", "PS5")
  "Joshua.Utility.PnPTelescope" = @("PS7", "PS5")
  "Joshua.Utility" = @("PS7", "PS5")
  "PowershellAI" = @("PS7", "PS5")
}

[System.IO.FileInfo]$Mode = $PROFILE | Split-Path 

if ($Mode.BaseName -eq "PowerShell") {
  Write-Host "Starting importing profile routine"
  Write-Host "|  Importing modules for " -NoNewline
  Write-Host $Mode.BaseName -ForegroundColor Green
  foreach ($Module in $Dependencies.Keys) {
    if ($Dependencies[$Module] -eq "PS7") {
      try 
      {
        Import-Module -Name $Module -ErrorAction Stop -WarningAction SilentlyContinue
        Write-Host "|  Successfully imported module:" -NoNewline 
        Write-Host " $Module" -ForegroundColor Green -NoNewline
        Write-Host " version: $((Get-Module -Name $Module).Version)" -ForegroundColor Magenta
        
        $ListConfigFile = (Get-ChildItem -Path "$($MyInvocation.MyCommand.Path | Split-Path)\config").BaseName
        if ($Module -in $ListConfigFile) {
          . "$($MyInvocation.MyCommand.Path | Split-Path)\config\$($Module).ps1"
          Write-Host "|  |" -NoNewline  
          Write-Host " Custom Config LOADED" -ForegroundColor Magenta 
        }
      }
      catch
      {
        Write-Host "|  Could not import module:" -NoNewline
        Write-Host " $Module" -ForegroundColor Red
      }
    }
  }
}

if ($Mode.BaseName -eq "WindowsPowerShell") {
  Write-Host "|  Importing modules for " -NoNewline
  Write-Host $Mode.BaseName -ForegroundColor Green
  foreach ($Module in $Dependencies.Keys) {
    if ($Dependencies[$Module] -eq "PS5") {
      try 
      {
        Import-Module -Name $Module -ErrorAction Stop -WarningAction SilentlyContinue
        Write-Host "|  Successfully imported module:" -NoNewline 
        Write-Host " $Module" -ForegroundColor Green -NoNewline
        Write-Host " version: $((Get-Module -Name $Module).Version)" -ForegroundColor Magenta
        
        $ListConfigFile = (Get-ChildItem -Path "$($MyInvocation.MyCommand.Path | Split-Path)\config").BaseName
        if ($Module -in $ListConfigFile) {
          . "$($MyInvocation.MyCommand.Path | Split-Path)\config\$($Module).ps1"
          Write-Host "|  |" -NoNewline  
          Write-Host " Custom Config LOADED" -ForegroundColor Magenta 
        }
      }
      catch
      {
        Write-Host "|  Could not import module:" -NoNewline
        Write-Host " $Module" -ForegroundColor Red
      }
    }
  }
}

try {
  . "$($MyInvocation.MyCommand.Path | Split-Path)\config\userprofile.ps1"
  Write-Host "|  Successfully imported profile: " -NoNewline
  Write-Host "Userprofile" -ForegroundColor Green
}
catch {
  Write-Host "|  Could not import profile: " -NoNewline
  Write-Host "Userprofile" -ForegroundColor Red
}
