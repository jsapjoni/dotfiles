# Powershell USERPROFILE
try {
  . "$($MyInvocation.MyCommand.Definition | Split-Path)\init.ps1" 
}
catch {
  $null
}
