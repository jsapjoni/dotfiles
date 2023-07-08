# PSReadLine Module
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -BellStyle None

# FuzzyFinder
Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias
Set-Alias vim nvim	
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias vim nvim

# Oh My Posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/atomicBit.omp.json" | Invoke-Expression
