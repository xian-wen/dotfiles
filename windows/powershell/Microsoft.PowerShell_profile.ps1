# posh-git
Import-Module posh-git

# PSReadLine
Import-Module PSReadLine
# Use Emacs key bindings.
Set-PSReadLineOption -EditMode Emacs
# Searching for commands with up/down arrow is really handy. The
# option "moves to end" is useful if you want the cursor at the end
# of the line while cycling through history like it does w/o searching,
# without that option, the cursor will remain at the position it was
# when you used up arrow, which can be useful if you forget the exact
# string you started the search on.
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Show navigable menu of all options when hitting Tab.
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Oh My Posh
# Set theme.
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\montys.omp.json" | Invoke-Expression
# Put this at the last line.
# oh-my-posh init pwsh | Invoke-Expression

# Starship
# Put this to the end.
Invoke-Expression (&starship init powershell)
