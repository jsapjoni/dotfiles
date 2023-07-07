# Tilgjengeliggjør scriptet.
Set-ExecutionPolicy Bypass -Scope Process -Force

#------------------------------------------------------------------------------#
# Checks if script is run as administrator.------------------------------------#
#------------------------------------------------------------------------------#
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!($IsAdmin)) {
  Write-Host "Please rerun this script as administrator"
  Write-Host "Aborting the script..."
  throw
}

#------------------------------------------------------------------------------#
# Checks if Scoop is installed.------------------------------------------------#
#------------------------------------------------------------------------------#
Write-Host "Checking if " -NoNewline
Write-Host "scoop " -NoNewline -ForegroundColor Green
Write-Host "is installed."
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Could not find " -NoNewline
  Write-Host "scoop " -ForegroundColor Red -NoNewline
  Write-Host "package manager"
  Write-Host "Installing scoop package manager..."
  
  try {
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin" -ErrorAction Stop
    Write-Host "Scoop installed" -ForegroundColor Green
  }
  
  catch {
    Write-Host "Could not install scoop, please verify installation script"
    Write-Host "Aborting bootstrapping ..." -ForegroundColor Red
    throw
  }
} 
else { 
  Write-Host "Scoop " -ForegroundColor Green -NoNewline
  Write-Host "is installed!"
}
#------------------------------------------------------------------------------#
# Checks if git is installed.--------------------------------------------------#
#------------------------------------------------------------------------------#
Write-Host "Checking if git is installed in scoop..."
if ((scoop list git).Name -like "git") {
  Write-Host "The app " -NoNewline
  Write-Host "git" -ForegroundColor Green -NoNewline
  Write-Host " is installed!"
}
else {
  Write-Host "The app " -NoNewline
  Write-Host "git" -ForegroundColor Red -NoNewline
  Write-Host " is not installed."
  Write-Host "Initiating installation..."
  scoop install git
  if (!($LASTEXITCODE -eq 0)) {
    Write-Host "Could not install git" -ForegroundColor Red
    throw "Aborting bootstrapping script..."
  }
  if ((scoop list git).Name -like "git") {
    scoop bucket add extras
  }
}

#------------------------------------------------------------------------------#
# Checks for .dotfiles repository----------------------------------------------#
#------------------------------------------------------------------------------#
Write-Host "Checking if .dotfiles repository is built"
if (!(Test-Path -Path "$env:USERPROFILE\.dotfiles")) {
  Write-Host ".dotfiles repository is not built!"
  Write-Host "Creating new .dotfiles folder."
  New-Item -Path "$env:USERPROFILE" -Name ".dotfiles" -ItemType Directory | Out-Null
  Write-Host "Cloning remote repository from URL: " -NoNewline
  Write-Host "https://github.com/jsapjoni/dotfiles" -ForegroundColor Green
  git clone https://github.com/jsapjoni/dotfiles $("$HOME\.dotfiles")
  if ($LASTEXITCODE -ne 0) {
    Write-Host "Could not clone remote repository, aborting script."
    throw 
  }
  Write-Host ".dotfiles repository successfully build on path " -NoNewline
  Write-Host $("$HOME\.dotfiles") -ForegroundColor Green
} 
else {
  Write-Host "Dotfiles is already built!"
}

# ------------------------- VARIABLE DECLEARATION ------------------------------#
$ProfileType = $PROFILE.CurrentUserCurrentHost
$DotfilesRepo = "$HOME\.dotfiles"
$WindowsApps= "$DotfilesRepo\Windows"
$CommonApps= "$DotfilesRepo\Common"
$ConfigFiles = "$DotfilesRepo\Windows\powershell\config"
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
  "starship"
  "lazygit"
)

$AppsList | ForEach-Object {
  if ((scoop list $_).Name -like $_) {
    Write-Host "The app: " -NoNewline
    Write-Host $_ -ForegroundColor Green -NoNewline
    Write-Host " is installed!" 
  }
  
  else {
    Write-Host "The app: " -NoNewline
    Write-Host $_ -ForegroundColor Red -NoNewline
    Write-Host " is not installed." -NoNewline
    Write-Host "Initiating installation..."
    scoop install $_
  }
}

$AppSource = Get-ChildItem -Path $CommonApps, $WindowsApps -Depth 1
foreach ($App in $AppsList){
  Write-Host "Attempting to find app configuration file: " -NoNewline
  Write-Host "$App-config.ps1 " -NoNewline 
  Write-Host "for " -NoNewline
  Write-Host "$App " -ForegroundColor Green 
  $AppDir = ($AppSource | Where-Object {$_.Name -like "$App-config.ps1"})
  if ($AppDir -is [system.object]) {
    try {
      Write-Host "Found app configuration file: " -NoNewline
      Write-Host "$App-config.ps1 " -ForegroundColor Green -NoNewline
      Write-Host "for " -NoNewline
      Write-Host "$App" -ForegroundColor Green
      Write-Host "Attempting to import app configuration file for " -NoNewline
      Write-Host "$App" -ForegroundColor Green
      . "$($AppDir.FullName)"
    }
    catch {
      Write-Host "Could not import $app-config.ps1 file"
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
