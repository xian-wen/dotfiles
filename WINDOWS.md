# Windows Installation

## Windows

### Install

Open a command prompt.

```text
Shift+F10
```

Reconfig.

```cmd
oobe\\bypassnro
```

[Bypass Windows 11 Internet and Microsoft Account Requirements](https://massgrave.dev/clean_install_windows#bypass-windows-11-internet-and-microsoft-account-requirements).

```cmd
start ms-cxh:localonly
```

## PowerShell

### Install

[Search for the latest version of PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#install-powershell-using-winget-recommended).

```powershell
winget search Microsoft.PowerShell
```

Install PowerShell.

```powershell
winget install --id Microsoft.Powershell --source winget
```

### Upgrade

[Check available PowerShell upgrade](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#upgrading-an-existing-installation).

```powershell
winget list --name PowerShell --upgrade-available
```

Upgrade PowerShell.

```powershell
winget upgrade --id Microsoft.Powershell --source winget
```

### Uninstall

Uninstall PowerShell.

```powershell
winget uninstall --id Microsoft.Powershell --source winget
```

## Starship

### Install

[Install Starship](https://starship.rs/#install-via-package-manager).

```bash
winget install starship
```

Copy `windows/powershell/Microsoft.PowerShell_profile.ps1` into the directory of `$PROFILE` to [use Starship](https://starship.rs/#powershell).

```powershell
cp ~/.dotfiles/windows/powershell/Microsoft.PowerShell_profile.ps1 /mnt/c/Users/Xianwen/Documents/PowerShell
```

### Upgrade

Upgrade Starship.

```bash
winget upgrade starship
```

### Uninstall

Remove the initialization of Starship in `$PROFILE` before [uninstall](https://starship.rs/faq/#how-do-i-uninstall-starship).

Uninstall Starship.

```bash
winget uninstall starship
```

## Oh My Posh

### Install

[Install Oh My Posh](https://ohmyposh.dev/docs/installation/windows#installation).

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

[Install Nerd Fonts](https://ohmyposh.dev/docs/installation/fonts#installation).

```powershell
oh-my-posh font install
```

Or manually install [Nerd Fonts](https://www.nerdfonts.com/font-downloads) in `Settings > Personalization > Fonts`.

Copy `windows/powershell/Microsoft.PowerShell_profile.ps1` into the directory of `$PROFILE` to [use Oh My Posh](https://ohmyposh.dev/docs/installation/prompt) and [set the theme](https://ohmyposh.dev/docs/installation/customize#themes).

```powershell
cp ~/.dotfiles/windows/powershell/Microsoft.PowerShell_profile.ps1 /mnt/c/Users/Xianwen/Documents/PowerShell
```

[Display available themes](https://ohmyposh.dev/docs/themes).

```powershell
Get-PoshThemes
```

### Upgrade

[Upgrade Oh My Posh](https://ohmyposh.dev/docs/installation/upgrade#manual).

```powershell
oh-my-posh upgrade
```

Or [upgrade with winget](https://ohmyposh.dev/docs/installation/windows#update).

```powershell
winget upgrade JanDeDobbeleer.OhMyPosh -s winget
```

To [enable automated upgrade](https://ohmyposh.dev/docs/installation/upgrade#automated), run

```powershell
oh-my-posh enable upgrade
```

### Uninstall

Remove the setup of Oh My Posh in `$PROFILE` before uninstall.

Uninstall Oh My Posh.

```powershell
winget uninstall JanDeDobbeleer.OhMyPosh -s winget
```

## posh-git

### Install

[Install posh-git](https://github.com/dahlbyk/posh-git?tab=readme-ov-file#installing-posh-git-via-powershellget-on-linux-macos-and-windows).

```powershell
Install-Module posh-git -Scope CurrentUser -Force
```

Copy `windows/powershell/Microsoft.PowerShell_profile.ps1` into the directory of `$PROFILE` to [import the module](https://github.com/dahlbyk/posh-git?tab=readme-ov-file#using-posh-git).

```powershell
cp ~/.dotfiles/windows/powershell/Microsoft.PowerShell_profile.ps1 /mnt/c/Users/Xianwen/Documents/PowerShell
```

### Update

Update posh-git.

```powershell
Update-Module posh-git
```

### Uninstall

Remove the setup of post-git in `$PROFILE` before [uninstall](https://learn.microsoft.com/en-us/powershell/module/powershellget/uninstall-module?view=powershellget-3.x).

Uninstall posh-git.

```powershell
Uninstall-Module post-git
```

## PSReadLine

### Install

[Install PSReadLine](https://github.com/PowerShell/PSReadLine?tab=readme-ov-file#install-from-powershellgallery-preferred).

```powershell
Install-Module PSReadLine -Scope CurrentUser -Force
```

Copy `windows/powershell/Microsoft.PowerShell_profile.ps1` into the directory of `$PROFILE` to [import the module](https://github.com/PowerShell/PSReadLine?tab=readme-ov-file#post-installation) and [update configuration](https://github.com/PowerShell/PSReadLine?tab=readme-ov-file#usage).

```powershell
cp ~/.dotfiles/windows/powershell/Microsoft.PowerShell_profile.ps1 /mnt/c/Users/Xianwen/Documents/PowerShell
```

### Update

[Update PSReadLine](https://github.com/PowerShell/PSReadLine?tab=readme-ov-file#upgrading).

```powershell
Update-Module PSReadLine
```

### Uninstall

Remove the setup of PSReadLine in `$PROFILE` before uninstall.

Uninstall PSReadLine.

```powershell
Uninstall-Module PSReadLine
```

## Nushell

### Install

[Install Nushell](https://www.nushell.sh/#windows)

```bash
winget install nushell
```

### Upgrade

Upgrade Nushell.

```bash
winget upgrade nushell
```

### Uninstall

Uninstall Nushell.

```bash
winget uninstall nushell
```

## fzf

### Install

[Install fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#windows-packages).

```powershell
winget install fzf
```

### Upgrade

Upgrade fzf.

```powershell
winget upgrade fzf
```

### Uninstall

Uninstall fzf.

```powershell
winget uninstall fzf
```

## Lazygit

### Install

[Install Lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#winget-windows-10-1709-or-later).

```bash
winget install lazygit
```

### Upgrade

Upgrade Lazygit.

```bash
winget upgrade lazygit
```

### Uninstall

Uninstall Lazygit.

```bash
winget uninstall lazygit
```
