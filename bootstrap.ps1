# Tilgjengeliggjør scriptet
Set-ExecutionPolicy Bypass -Scope Process -Force



# Checks if script is run as administrator
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (!($IsAdmin)) {
  Write-Host "Please rerun this script as administrator"
  Write-Host "Aborting the script..."
  throw
}


# Checks if Scoop is installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Could not find scoop package manager"
  Write-Host "Installing scoop package manager"
  
  try {
    Invoke-RestMethod -Uri "get.scoop.sh" | Invoke-Expression -ErrorAction Stop
    Write-Host "Scoop installed" -ForegroundColor Green
  }
  
  catch {
    Write-Host "Could not install scoop, please verify installation script"
    Write-Host "Aborting bootstrapping ..." -ForegroundColor Red
    throw
  }
  
  Write-Host "Checking if git is installed in scoop..."
  if ((scoop list git).Name -like "git") {
    Write-Host "The app git" -NoNewline
    Write-Host $_ -ForegroundColor Green -NoNewline
    Write-Host " is installed!" -NoNewline
  }
  
  else {
    Write-Host "The app git" -NoNewline
    Write-Host $_ -ForegroundColor Red -NoNewline
    Write-Host " is not installed." -NoNewline
    Write-Host "Initiating installation..."
    scoop install $_
    if ((scoop list git).Name -like "git") {
      scoop bucket add extras
    }
  }
  
  if (!(Test-Path -Path ~\.dotfiles)) {
    git clone https://github.com/jsapjoni/dotfiles .\.dotfiles
  }
}

# ------------------------- VARIABLE DECLEARATION ------------------------------#
$ProfileType = $PROFILE.CurrentUserCurrentHost
$ConfigFiles = "$($MyInvocation.MyCommand.Path | Split-Path)\windows\powershell\config"
# ------------------------------------------------------------------------------#

$AppsList = @(
  "git",
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
