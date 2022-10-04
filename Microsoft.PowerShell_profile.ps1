Import-Module oh-my-posh
Set-PoshPrompt ys

Import-Module posh-git

# Ref: https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/SamplePSReadLineProfile.ps1
Import-Module PSReadLine
# Shows navigable menu of all options when hitting Tab.
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Searching for commands with up/down arrow is really handy. The
# option "moves to end" is useful if you want the cursor at the end
# of the line while cycling through history like it does w/o searching,
# without that option, the cursor will remain at the position it was
# when you used up arrow, which can be useful if you forget the exact
# string you started the search on.
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
