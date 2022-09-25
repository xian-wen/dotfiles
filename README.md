# Dotfiles for WSL2

## Restore .dotfiles
```bash
# Ref: https://stackoverflow.com/questions/3796927/how-do-i-git-clone-a-repo-including-its-submodules
git clone --recurse-submodules -j8 git@github.com:xian-wen/dotfiles.git .dotfiles
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
```

## Install oh-my-zsh
```bash
# Install ZSH
# Ref: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt install zsh
chsh -s $(which zsh)

# If change shell needs input password, manually modify /etc/passwd
# Ref: https://serverfault.com/questions/500865/chsh-pam-authentication-failed
vim /etc/passwd
root:x:0:0:root:/root:zsh
xian_wen:x:1000:1000:,,,:/home/xian_wen:/usr/bin/zsh

# Install powerline fonts
# Ref: https://github.com/powerline/fonts
sudo apt-get install fonts-powerline

# Install oh-my-zsh
# Ref: https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

## Version manager for Node.js
```bash
# Ref: https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

## NPM registry manager
```bash
npm install -g nrm
```

## YARN registry manager
```bash
npm install -g yrm
```

## PIP registry manager
```bash
sudo pip install pqi

```

## Install bat
```bash
# Ref: https://github.com/sharkdp/bat
sudo apt install bat

# Replace batcat with bat.
# Ref: https://github.com/sharkdp/bat/issues/982
sudo ln -s /usr/bin/batcat /usr/local/bin/bat
```

# Install cmake
```bash
sudo snap install cmake --classic
```

## Docker desktop failed to stop
```PowerShell
# Ref: https://github.com/docker/for-win/issues/7295#issuecomment-650590135
wsl --unregister docker-desktop
```

## Vim
```bash
# Change the default editor to vim
# Ref: https://askubuntu.com/questions/483308/what-are-the-differences-between-vim-basic-and-vim-tiny
sudo update-alternatives --config editor

# YouCompleteMe error: ycmd server SHUT DOWN
# Ref: https://stackoverflow.com/questions/47667119/ycm-error-the-ycmd-server-shut-down-restart-wit-the-instructions-in-the-docu
# Ref: https://github.com/ycm-core/YouCompleteMe/wiki/Troubleshooting-steps-for-ycmd-server-SHUT-DOWN
cd ~/.vim/pack/vendor/start/YouCompleteMe
python3 install.py

# YouCompleteMe error: Python headers are missing
# Ref: https://blog.csdn.net/weixin_45525272/article/details/109322049
sudo apt-get install python3-dev
```

