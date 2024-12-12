# Dotfiles for WSL2

## Restore .dotfiles
```bash
git clone git@github.com:xian-wen/dotfiles.git .dotfiles

# Create a symbolic link, use zsh as an example.
ln -sf /home/xianwen/.dotfiles/.zshrc ~/.zshrc
```

## Install WSL2
```PowerShell
# List all the available distributions online.
# Ref: https://docs.microsoft.com/en-us/windows/wsl/install
wsl -l -o

# Install WSL2 and Ubuntu.
wsl --install -d Ubuntu

# If failed, try run the command below and reinstall.
# Ref: https://github.com/microsoft/WSL/issues/5906#issuecomment-1047496562
wslconfig /u Ubuntu

# List the installed distributions.
wsl -l -v

# If Docker desktop failed to stop.
# Ref: https://github.com/docker/for-win/issues/7295#issuecomment-650590135
wsl --unregister docker-desktop

# Uninstall Ubuntu
wsl --unregister Ubuntu
# Remove Canonical* folder in %LocalAppData%\Packages

# Update WSL2
wsl --update

# Uninstall WSL2
wsl --uninstall
```

## Update Ubuntu
```bash
sudo do-release-upgrade

# If Failed to retrieve available kernel versions.
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
sudo vim /etc/passwd
root:x:0:0:root:/root:bash
xianwen:x:1000:1000:,,,:/home/xianwen:/usr/bin/zsh

# If compinit:503: no such file or directory: /usr/share/zsh/vendor-completions/_docker,
# then add docker in zsh plugins, ignore this right now, see the updated .zshrc.
# Ref: https://github.com/docker/for-win/issues/8336#issuecomment-719477466
plugins=(... docker)

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

# Uninstall oh-my-zsh
# Ref: https://github.com/ohmyzsh/ohmyzsh/discussions/11602
uninstall_oh_my_zsh

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

## Install vim from source
```bash
# Ref: https://www.vim.org/git.php
# Ref: https://github.com/vim/vim/blob/master/src/INSTALL
sudo apt install git make clang libtool-bin
git clone git@github.com:vim/vim.git

# Update vim.
cd vim
git pull

# Update vim with Makefile locally changed.
cd vim
git stash
git pull
git stash pop

# Build vim.
cd src
make distclean  # If you build vim before.
make
make test       # Optional, may take a long time.
sudo make install

# Add Python 3 support.
# Uncomment `CONF_OPT_PYTHON3 = --enable-python3interp` in Makefile.
make reconfig
# Build again.

# Uninstall vim.
# Ref: https://github.com/vim/vim/blob/master/src/Makefile
make uninstall_runtime
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

# If YouCompleteMe error: ycmd server SHUT DOWN.
# Ref: https://stackoverflow.com/questions/47667119/ycm-error-the-ycmd-server-shut-down-restart-wit-the-instructions-in-the-docu
# Ref: https://github.com/ycm-core/YouCompleteMe/wiki/Troubleshooting-steps-for-ycmd-server-SHUT-DOWN
sudo apt install build-essential cmake vim-nox python3-dev
cd ~/.vim/plugged/YouCompleteMe
./install.py --clangd-completer --java-completer --go-completer --rust-completer

# If YouCompleteMe unavailable: requires Vim 9.1.0016+.
# See Install vim from source.

# If YouCompleteMe unavailable: requires Vim compiled with Python (3.8.0+) support.
# See Install vim from source.

# If gutentags: gtags-cscope job failed, returned: 127.
sudo apt install global
```

## Install neovim from source
```bash
# Ref: https://github.com/neovim/neovim/blob/master/BUILD.md
# Ref: https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-source
sudo apt install ninja-build gettext cmake unzip curl build-essential xclip
git clone git@github.com:neovim/neovim.git
git checkout stable
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

# Uninstall nvim.
# Ref: https://github.com/neovim/neovim/blob/master/INSTALL.md#uninstall
sudo cmake --build build/ --target uninstall
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/

# Use vimrc.
mkdir ~/.config/nvim
ln -sf /home/xianwen/.vimrc ~/.config/nvim/init.vim
ln -sf /home/xianwen/.vim/autoload ~/.config/nvim
```

## Install bat
```bash
# Ref: https://github.com/sharkdp/bat
sudo apt install bat

# Replace batcat with bat.
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Or download the lastest release and no need to create a symbolic link.
# Ref: https://stackoverflow.com/questions/46060010/download-github-release-with-curl
curl -OL https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb
sudo dpkg -i bat_0.22.1_amd64.deb
```

## Install fd
```bash
# Ref: https://github.com/sharkdp/fd
sudo apt install fd-find

# Replace fdfind with fd.
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd
```

## Install fzf
```bash
# Ref: https://github.com/junegunn/fzf
sudo apt install fzf

# Install fzf-vim dependencies.
# Ref: https://github.com/junegunn/fzf.vim
sudo apt install fzf bat ripgrep silversearcher-ag perl universal-ctags
```

## Install ctags
```bash
sudo apt install universal-ctags

# Ignore all ctags files.
# Ref: https://ricostacruz.com/til/navigate-code-with-ctags
git config --global core.excludesfile $HOME/.global_ignore
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

## Install node version manager
```bash
# Ref: https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Install node.js (latest LTS version)
nvm install --lts
```

## Install npm registry manager
```bash
npm install -g nrm
```

## Install yarn registry manager
```bash
npm install -g yrm
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

# Manually upgrade.
# Ref: https://ohmyposh.dev/docs/installation/upgrade
oh-my-posh upgrade

# Enable autoupgrade.
oh-my-posh enable autoupgrade
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

## Install fzf
```PowerShell
# Ref: https://github.com/junegunn/fzf
winget install fzf
```
