# Dotfiles for WSL2

## Restore .dotfiles
```bash
# Ref: https://stackoverflow.com/questions/3796927/how-do-i-git-clone-a-repo-including-its-submodules
git clone --recurse-submodules -j8 git@github.com:xian-wen/dotfiles.git .dotfiles

# Create a symbolic link, use zsh as an example.
ln -sf /home/xian_wen/.dotfiles/.zshrc ~/.zshrc
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
xian_wen:x:1000:1000:,,,:/home/xian_wen:/usr/bin/zsh

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
sudo apt-get install fonts-powerline

# Install oh-my-zsh.
# Ref: https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install tmux and tpm
```bash
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

# YouCompleteMe error: ycmd server SHUT DOWN.
# Ref: https://stackoverflow.com/questions/47667119/ycm-error-the-ycmd-server-shut-down-restart-wit-the-instructions-in-the-docu
# Ref: https://github.com/ycm-core/YouCompleteMe/wiki/Troubleshooting-steps-for-ycmd-server-SHUT-DOWN
cd ~/.vim/pack/vendor/start/YouCompleteMe
python3 install.py

# YouCompleteMe error: Python headers are missing.
# Ref: https://blog.csdn.net/weixin_45525272/article/details/109322049
sudo apt-get install python3-dev
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
sudo snap install cmake --classic
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

## Add multiple submodules
```bash
# Ref: https://stackoverflow.com/questions/10606101/automatically-add-all-submodules-to-a-repo
for x in $(find . -type d) ; do
    if [ -d "${x}/.git" ] ; then
        cd "${x}"
        origin="$(git config --get remote.origin.url)"
        cd - 1>/dev/null
        git submodule add "${origin}" "${x}"
    fi
done
```

## Docker desktop failed to stop
```PowerShell
# Ref: https://github.com/docker/for-win/issues/7295#issuecomment-650590135
wsl --unregister docker-desktop
```

# Dotfiles for PowerShell

## Install Oh-My-Posh
```PowerShell
# Install oh-my-posh.
# Ref: https://ohmyposh.dev/docs/installation/windows
winget install JanDeDobbeleer.OhMyPosh -s winget

# Install Nerd Fonts.
# Ref: https://ohmyposh.dev/docs/installation/fonts
oh-my-posh font install
# Or manually install fonts in Settings > Personalization > Fonts
# Ref: https://www.nerdfonts.com/

# Copy Microsoft.PowerShell_profile.ps1 into $PROFILE.
cp ~/.dotfiles/Microsoft.PowerShell_profile.ps1 /mnt/c/Users/xian_wen/Documents/PowerShell

# Get themes.
# Ref: https://ohmyposh.dev/docs/themes
Get-PoshThemes
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

