# Tilgjengeliggjør scriptet
Set-ExecutionPolicy Bypass -Scope Process -Force

if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Invoke-RestMethod -Uri "get.scoop.sh" | Invoke-Expression
}

# Insert App Installasjon via Package Manager
scoop bucket add extras
scoop install git 7zip bat curl dark fd fzf gcc jq lazygit lua make neofetch neovim nvm pwsh python sudo windows-terminal --global

git clone https://github.com/jsapjoni/dotfiles .

# Insert Symlinks
