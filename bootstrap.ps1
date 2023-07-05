# Tilgjengeliggjør scriptet.
Set-ExecutionPolicy Bypass -Scope Process -Force

# Checks if script is run as administrator.
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!($IsAdmin)) {
  Write-Host "Please rerun this script as administrator"
  Write-Host "Aborting the script..."
  throw
}


# Checks if Scoop is installed.
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Could not find scoop package manager"
  Write-Host "Installing scoop package manager"
  
  try {
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin" -ErrorAction Stop
    # Invoke-RestMethod -Uri "get.scoop.sh" | Invoke-Expression -ErrorAction Stop
    Write-Host "Scoop installed" -ForegroundColor Green
  }
  
  catch {
    Write-Host "Could not install scoop, please verify installation script"
    Write-Host "Aborting bootstrapping ..." -ForegroundColor Red
    throw
  }
  
  # Checks if git is installed.
  Write-Host "Checking if git is installed in scoop..."
  if ((scoop list git).Name -like "git") {
    Write-Host "The app " -NoNewline
    Write-Host "git" -ForegroundColor Green -NoNewline
    Write-Host " is installed!" -NoNewline
  }
  
  else {
    Write-Host "The app git" -NoNewline
    Write-Host "git" -ForegroundColor Red -NoNewline
    Write-Host " is not installed." -NoNewline
    Write-Host "Initiating installation..."
    scoop install git
    if ((scoop list git).Name -like "git") {
      scoop bucket add extras
    }
  }
}

# ------------------------- VARIABLE DECLEARATION ------------------------------#
$ProfileType = $PROFILE.CurrentUserCurrentHost
$ConfigFiles = "$($MyInvocation.MyCommand.Path | Split-Path)\windows\powershell\config"
$WindowsConfigs = "$($MyInvocation.MyCommand.Path | Split-Path)\Windows"
$CommonConfigs = "$($MyInvocation.MyCommand.Path | Split-Path)\Common"
# ------------------------------------------------------------------------------#

$AppsList = @(
  "pwsh",
  "7zip",
  "bat",
  "curl",
  "dark",
  "fd",
  "fzf",
  "gcc",
  "jq",
  "lua",
  "make",
  "neofetch",
  "neovim",
  "nvm",
  "python",
  "sudo",
  "ripgrep",
  "windows-terminal",
  "lazygit"
)

$AppsList | ForEach-Object {
  if ((scoop list $_).Name -like $_) {
    Write-Host "The app: " -NoNewline
    Write-Host $_ -ForegroundColor Green -NoNewline
    Write-Host " is installed!" -NoNewline
  }
  
  else {
    Write-Host "The app: " -NoNewline
    Write-Host $_ -ForegroundColor Red -NoNewline
    Write-Host " is not installed." -NoNewline
    Write-Host "Initiating installation..."
    scoop install $_
  }
  
  Write-Host "Setting up configuration for " -NoNewline
  Write-Host $_ -ForegroundColor Green
  
  foreach ($app in $Apps) {
    Get-ChildItem -Path $WindowsConfigs, $CommonConfigs |
    ForEach-Object {
      if ($app -like $_.Name) {
        try { 
          Write-Host "Attempting to import config file for " -NoNewline
          Write-Host "$app ..."
          . "$($_.FullName)\$app-config.ps1"
          Write-Host "Imported config file for app " -NoNewline
          Write-Host "$app" -ForegroundColor Green -NoNewline
        }
        catch { 
          Write-Host "Could not find the specified config file for app " -NoNewline
          Write-Host "$app" -ForegroundColor Red
        }
      }
    }
  }
}

Write-Host "Bootstrapping powershell profile from dotfiles"
if (!(Test-Path -Path $ProfileType)){
  Write-Host "Importing profile..."
  try {
    $CopyItemArgs = @{
      "Path" = "$ConfigFiles\PSProfile.ps1"
      "Destination" = $ProfileType
    }
    Copy-Item @CopyItemArgs -ErrorAction Stop
    Write-Host "Profile import complete!" -ForegroundColor Green
  }
  catch {
    Write-Host "Could not import profile" -ForegroundColor Red
    throw
  }
} 
else { 
  Write-Host "Profile already exists" -ForegroundColor Green
}
