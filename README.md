# Dotfiles for WSL2

## Restore .dotfiles
```bash
git clone git@github.com:xian-wen/dotfiles.git .dotfiles

# Create a symbolic link, use zsh as an example.
ln -sf /home/xianwen/.dotfiles/.zshrc ~/.zshrc
```

## Install WSL2
```PowerShell
# Ref: https://docs.microsoft.com/en-us/windows/wsl/install
# List all the available distributions online.
wsl -l -o

# Install WSL2 and Ubuntu.
wsl --install -d Ubuntu

# If failed, try run the command below and reinstall.
# Ref: https://github.com/microsoft/WSL/issues/5906#issuecomment-1047496562
wslconfig /u Ubuntu

# List the installed distributions.
wsl -l -v
```

## Update Ubuntu
```bash
sudo do-release-upgrade

# If seeing this message: Failed to retrieve available kernel versions.
# Ref: https://github.com/microsoft/WSL/issues/7054#issuecomment-1121779380
sudo apt purge needrestart
sudo apt autoremove (optional)
```

## Install oh-my-zsh
```bash
# Install ZSH.
# Ref: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt install zsh
chsh -s $(which zsh)

# If change shell needs input password, manually modify /etc/passwd.
# Ref: https://serverfault.com/questions/500865/chsh-pam-authentication-failed
vim /etc/passwd
root:x:0:0:root:/root:bash
xianwen:x:1000:1000:,,,:/home/xianwen:/usr/bin/zsh

# If compinit:503: no such file or directory: /usr/share/zsh/vendor-completions/_docker,
# then add docker in zsh plugins, ignore this right now, see the updated .zshrc.
# Ref: https://github.com/docker/for-win/issues/8336#issuecomment-719477466
plugins=(
docker
zsh-syntax-highlighting
zsh-autosuggestions
)

# Install powerline fonts.
# Ref: https://github.com/powerline/fonts
sudo apt install fonts-powerline

# Install oh-my-zsh.
# Ref: https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# If curl: Failed to connect to raw.githubusercontent.com port 443: Connection refused
# Add this into the /etc/hosts file.
185.199.108.133 raw.githubusercontent.com

# Manual update oh-my-zsh
# Ref: https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#manual-updates
omz update

# Install Powerlevel10k.
# Ref: https://github.com/romkatv/powerlevel10k#oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Configure Powerlevel10k.
p10k configure

# Install zsh-autosuggestions.
# Ref: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting.
# Ref: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Install tmux and tpm
```bash
# The built-in byobu in Ubuntu may be a better replacement for tmux.
# Install tmux.
sudo apt install tmux

# Install tmux plugin manager, <prefix>+I to install plugins in tmux session.
# Ref: https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install vim plugins
```bash
# Change the default editor to vim.
# Ref: https://askubuntu.com/questions/483308/what-are-the-differences-between-vim-basic-and-vim-tiny
sudo update-alternatives --config editor

# Install vim-plug as the plugins manager.
# Ref: https://github.com/junegunn/vim-plug?tab=readme-ov-file#unix
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins (in vim).
# Ref: https://github.com/junegunn/vim-plug?tab=readme-ov-file#commands
:PlugInstall

# Update plugins (in vim).
:PlugUpdate

# Upgrade vim-plug itself (in vim).
:PlugUpgrade

# YouCompleteMe error: ycmd server SHUT DOWN.
# Ref: https://stackoverflow.com/questions/47667119/ycm-error-the-ycmd-server-shut-down-restart-wit-the-instructions-in-the-docu
# Ref: https://github.com/ycm-core/YouCompleteMe/wiki/Troubleshooting-steps-for-ycmd-server-SHUT-DOWN
cd ~/.vim/plugged/youcompleteme
./install.py --clangd-completer --java-completer --go-completer

# YouCompleteMe error: Python headers are missing.
# Ref: https://blog.csdn.net/weixin_45525272/article/details/109322049
sudo apt install python3-dev

# YouCompleteMe error: No CMAKE_CXX_COMPILER could be found.
sudo apt install build-essential
```

## Install Ctags
```bash
sudo apt install exuberant-ctags

# Ignore all ctags files.
# Ref: https://ricostacruz.com/til/navigate-code-with-ctags
git config --global core.excludesfile $HOME/.global_ignore
```

## Install bat
```bash
# Ref: https://github.com/sharkdp/bat
sudo apt install bat

# Replace batcat with bat.
# Ref: https://github.com/sharkdp/bat/issues/982
sudo ln -s /usr/bin/batcat /usr/local/bin/bat

# Or download the lastest release and no need to create a symbolic link.
# Ref: https://stackoverflow.com/questions/46060010/download-github-release-with-curl
curl -OL https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb
sudo dpkg -i bat_0.22.1_amd64.deb
```

## Install cmake
```bash
sudo apt install cmake
```

## Install pwndbg
```bash
# Ref: https://github.com/pwndbg/pwndbg
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
```

## Install pip registry manager
```bash
sudo pip install pqi
```

## Install node.js version manager
```bash
# Ref: https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

## Install npm registry manager
```bash
npm install -g nrm
```

## Install yarn registry manager
```bash
npm install -g yrm

```
## Docker desktop failed to stop
```PowerShell
# Ref: https://github.com/docker/for-win/issues/7295#issuecomment-650590135
wsl --unregister docker-desktop
```

# Dotfiles for PowerShell

## Install PowerShell
```PowerShell
# Search for the latest version of PowerShell.
# Ref: https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4
winget search Microsoft.PowerShell

# Install PowerShell.
winget install --id Microsoft.Powershell --source winget

# Check update.
winget list --name PowerShell --upgrade-available
```

## Install Oh-My-Posh
```PowerShell
# Install oh-my-posh.
# Ref: https://ohmyposh.dev/docs/installation/windows#installation
winget install JanDeDobbeleer.OhMyPosh -s winget

# Install Nerd Fonts.
# Ref: https://ohmyposh.dev/docs/installation/fonts
oh-my-posh font install
# Or manually install fonts in Settings > Personalization > Fonts
# Ref: https://www.nerdfonts.com/

# Copy Microsoft.PowerShell_profile.ps1 into $PROFILE.
cp ~/.dotfiles/powershell/Microsoft.PowerShell_profile.ps1 /mnt/c/Users/Xianwen/Documents/PowerShell

# Get themes.
# Ref: https://ohmyposh.dev/docs/themes
Get-PoshThemes

# Update oh-my-posh
# Ref: https://ohmyposh.dev/docs/installation/windows#update
winget upgrade JanDeDobbeleer.OhMyPosh -s winget
```

## Install Posh-git
```PowerShell
# Ref: https://github.com/dahlbyk/posh-git
Install-Module posh-git -Scope CurrentUser -Force
```

## Install PSReadLine
```PowerShell
# Ref: https://github.com/PowerShell/PSReadLine
Install-Module PSReadLine -Scope CurrentUser -Force
```

