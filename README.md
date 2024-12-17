# Dotfiles for WSL2

## WSL2 and Ubuntu

### Install

List all the available distributions online.
```powershell
wsl -l -o
```

[Install WSL2](https://docs.microsoft.com/en-us/windows/wsl/install) and Ubuntu.
```powershell
wsl --install -d Ubuntu
```
Then restart the machine.

If failed, [uninstall Ubuntu](https://github.com/microsoft/WSL/issues/5906#issuecomment-1047496562) and reinstall.
```powershell
wslconfig /u Ubuntu
```

List the installed distributions.
```powershell
wsl -l -v
```

### Upgrade

Update WSL2.
```powershell
wsl --update
```

Upgrade Ubuntu.
```bash
sudo do-release-upgrade
```

### Uninstall

Uninstall Ubuntu.
```powershell
wsl --unregister Ubuntu
```
Then Remove the `Canonical*` folder in `%LocalAppData%\Packages`.

Uninstall WSL2.
```powershell
wsl --uninstall
```

### Errors

*Failed to retrieve available kernel versions*

[Remove kernel checks](https://github.com/microsoft/WSL/issues/7054#issuecomment-1121779380).
```bash
sudo apt purge needrestart
sudo apt autoremove (optional)
```

*Docker Desktop failed to stop*

[Uninstall Docker Desktop](https://github.com/docker/for-win/issues/7295#issuecomment-650590135).
```powershell
wsl --unregister docker-desktop
```

## .dotfiles

### SSH to Github

[Generate a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Add SSH key to the ssh-agent.
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add SSH key to GitHub.
```bash
cat ~/.ssh/id_ed25519.pub
```

Test SSH connection.
```bash
ssh -T git@github.com
```

### Restore

Clone the repo.
```bash
git clone git@github.com:xian-wen/dotfiles.git ~/.dotfiles/
```

Create a symbolic link to [enable SSH to Github over HTTPS](https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port#enabling-ssh-connections-over-https).
```bash
ln -sf /home/xianwen/.dotfiles/.ssh/config ~/.ssh/
```

Create a symbolic link to [add metadata to Windows files](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#automount-options) to support Linux system permissions.
```bash
sudo ln -sf /home/xianwen/.dotfiles/wsl.conf /etc/
```

### Errors

*ssh: connect to host github.com port 22: No route to host*

[Use SSH over the HTTPS port](https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port).
```bash
ssh -T -p 443 git@ssh.github.com
git clone ssh://git@ssh.github.com:443/xian-wen/dotfiles.git ~/.dotfiles/
```

## Homebrew

### Install

[Install build tools](https://docs.brew.sh/Homebrew-on-Linux#requirements).
```bash
sudo apt install build-essential procps curl file git
```

[Install Homebrew](https://github.com/homebrew/install?tab=readme-ov-file#install-homebrew-on-macos-or-linux).
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Create a symbolic link to [add Homebrew to PATH](https://docs.brew.sh/Homebrew-on-Linux#install).
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

### Update

Update Homebrew.
```bash
brew update
```

### Uninstall

[Uninstall Homebrew](https://github.com/homebrew/install?tab=readme-ov-file#uninstall-homebrew).
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
sudo rm -rf /home/linuxbrew/
```

## fish

### Install

[Install fish](https://fishshell.com/).
```bash
sudo apt install fish
```

Or [install with Homebrew](https://github.com/fish-shell/fish-shell?tab=readme-ov-file#getting-fish).
```bash
brew install fish
```

[Add fish to /etc/shells](https://fishshell.com/docs/current/index.html#default-shell).
```bash
which fish | sudo tee -a /etc/shells
```

Change the default shell to fish.
```bash
chsh -s $(which fish)
```

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
```

### Upgrade

Upgrade fish.
```bash
sudo apt upgrade fish
```

If installed with Homebrew, run
```bash
brew upgrade fish
```

### Uninstall

[Change the default shell to Bash](https://fishshell.com/docs/current/faq.html#uninstalling-fish).
```bash
chsh -s $(which bash)
```

Uninstall fish.
```bash
sudo apt remove --purge fish
sudo apt autoremove
```

If installed with Homebrew, run
```bash
brew uninstall fish
sudo rm -rf /home/linuxbrew/.linuxbrew/etc/fish/
```

## ZSH and Oh My Zsh

### Install

[Install ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH).
```bash
sudo apt install zsh
```

Change the default shell to ZSH.
```bash
chsh -s $(which zsh)
```
If needs to input password, manually [modify /etc/passwd](https://serverfault.com/questions/500865/chsh-pam-authentication-failed) .
```text
root:x:0:0:root:/root:bash
xianwen:x:1000:1000:,,,:/home/xianwen:/usr/bin/zsh
```

[Install Powerline fonts](https://github.com/powerline/fonts?tab=readme-ov-file#quick-installation).
```bash
sudo apt install fonts-powerline
```

[Install Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#basic-installation).
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
If failed, install from the mirror.
```bash
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
```

[Install Powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh).
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Configure Powerlevel10k.
```bash
p10k configure
```

[Install zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md).
```bash
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

[Install zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md).
```bash
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

### Update

[Update Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#manual-updates).
```bash
omz update
```

### Uninstall

[Uninstall Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#uninstalling-oh-my-zsh).
```bash
uninstall_oh_my_zsh
```

Change the default shell to Bash.
```bash
chsh -s $(which bash)
```

Uninstall ZSH, including configurations and dependencies.
```bash
sudo apt remove --purge zsh
sudo apt autoremove
```

### Errors

*sudo: nvim: command not found*

- To [modify a root file](https://www.reddit.com/r/neovim/comments/1aw71ge/how_to_run_nvim_as_sudo/), either edit with `sudo -e`.
```bash
sudo -e /etc/hosts
```
- Or edit with `sudoedit`.
```bash
sudoedit /etc/hosts
```
- Or edit with `sudo -E -s`, which preserves the environment variables.
```bash
sudo -E -s
nvim /etc/hosts
```

*curl: Failed to connect to raw.githubusercontent.com port 443: Connection refused*

Add below to the `/etc/hosts` file.
```text
185.199.108.133 raw.githubusercontent.com
```

## Starship

### Install

[Install Starship](https://starship.rs/#install-via-package-manager).
```bash
brew install starship
```

Or [install with curl](https://starship.rs/guide/#step-1-install-starship).
```bash
curl -sS https://starship.rs/install.sh | sh
```

Create a symbolic link to [use Starship](https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship).
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.config/starship.toml ~/.config/
```

### Upgrade

Upgrade Starship.
```bash
brew upgrade starship
```

If installed with curl, [rerun](https://starship.rs/#install-latest-version)
```bash
curl -sS https://starship.rs/install.sh | sh
```

### Uninstall

Remove the initialization of Starship in shell config (e.g., `~/.bashrc`, `~/.config/fish/config.fish`, `~/.zshrc`, etc.) before [uninstall](https://starship.rs/faq/#how-do-i-uninstall-starship).

Uninstall Starship.
```bash
brew uninstall starship
```

If installed with curl, locate and delete the Starship binary.
```bash
sh -c 'rm "$(command -v 'starship')"'
```

## Neovim

### Install

#### Prerequisites

Install below, [bat](#bat), and [fd](#fd). (Ref: [heading ids and links in markdown](https://docs.gitlab.com/ee/user/markdown.html#heading-ids-and-links))
```bash
brew install ripgrep xclip
```

#### Install from package

[Install Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#homebrew-on-macos-or-linux).
```bash
brew install neovim
```

Or [install with apt](https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu), but the version is too old.
```bash
sudo apt install neovim
```

#### Install from source

[Install prerequisites](https://github.com/neovim/neovim/blob/master/BUILD.md#ubuntu--debian).
```bash
sudo apt install ninja-build gettext cmake unzip curl build-essential
```

Clone the repo.
```bash
git clone https://github.com/neovim/neovim.git
```

[Build from source](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-source).
```bash
cd neovim/
git checkout stable
make distclean  # If build neovim before.
make CMAKE_BUILD_TYPE=Release
sudo make install
```

#### Restore

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.config/nvim/ ~/.config/
```

Create a symbolic link to set `EDITOR` to `nvim`.
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

#### Plugins

Open Neovim and plugins will be automatically installed by [lazy.nvim](https://lazy.folke.io/).
```bash
nvim
```

#### Clipboard in SSH

Create a symbolic link to [enable X11 forwarding over SSH](https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim), so that clipboard can be used on remote machines.
```bash
ln -sf /home/xianwen/.dotfiles/.ssh/config ~/.ssh/
```

### Upgrade

#### Upgrade from package

Upgrade Neovim.
```bash
brew upgrade neovim
```

If installed with apt, run
```bash
sudo apt upgrade neovim
```

#### Upgrade from source

Pull the repo.
```bash
cd neovim/
git pull
```

Build again.

### Uninstall

#### Uninstall from package

Uninstall Neovim.
```bash
brew uninstall neovim
```

If installed with apt, run
```bash
sudo apt remove --purge neovim
sudo apt autoremove
```

#### Uninstall from source

[Uninstall Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#uninstall).
```bash
sudo cmake --build build/ --target uninstall
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
rm -rf ~/.config/nvim/
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/
rm -rf ~/.cache/nvim/
```

### Warnings

*No xauth data; using fake authentication data for X11 forwarding*

Create an empty `~/.Xauthority` file in the local machine, and add the magic cookie.
```bash
touch ~/.Xauthority
xauth add :0 . `mcookie`
```
Check the magic cookie has asscoiated with the correct hostname of the new PC.
```bash
xauth list
```

## LazyVim

### Install

[Install LazyVim](https://www.lazyvim.org/installation).
```bash
git clone https://github.com/LazyVim/starter ~/.config/lazyvim/
```

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.config/lazyvim/ ~/.config/
```

Create a symbolic link to [maintain multiple configurations](https://github.com/nvim-lua/kickstart.nvim?tab=readme-ov-file#faq), so that LazyVim can be opened with `lazyvim` instead of `NVIM_APPNAME="lazyvim" nvim`.
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

Open LazyVim and plugins will be automatically installed by [lazy.nvim](https://lazy.folke.io/).
```bash
lazyvim
```

### Update

Update LazyVim.
```nvim
:Lazy sync
```

### Uninstall

Uninstall LazyVim.
```bash
rm -rf ~/.config/lazyvim/
rm -rf ~/.local/share/lazyvim/
rm -rf ~/.local/state/lazyvim/
rm -rf ~/.cache/lazyvim/
```

## NvChad

### Install

[Install NvChad](https://nvchad.com/docs/quickstart/install/#install).
```bash
git clone https://github.com/NvChad/starter ~/.config/nvchad/
```

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.config/nvchad/ ~/.config/
```

Create a symbolic link to [maintain multiple configurations](https://github.com/nvim-lua/kickstart.nvim?tab=readme-ov-file#faq), so that NvChad can be opened with `nvchad` instead of `NVIM_APPNAME="nvchad" nvim`.
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

Open NvChad and plugins will be automatically installed by [lazy.nvim](https://lazy.folke.io/).
```bash
nvchad
```

Install LSP, linter and formatter.
```nvim
:MasonInstallAll
```

### Update

[Update NvChad](https://nvchad.com/docs/quickstart/install/#update).
```nvim
:Lazy sync
```

### Uninstall

[Uninstall NvChad](https://nvchad.com/docs/quickstart/install/#uninstall).
```bash
rm -rf ~/.config/nvchad/
rm -rf ~/.local/share/nvchad/
rm -rf ~/.local/state/nvchad/
rm -rf ~/.cache/nvchad/
```

## Vim

### Install

#### Prerequisites

Install below, [bat](#bat), and [fzf](#fzf). (Ref: [heading ids and links in markdown](https://docs.gitlab.com/ee/user/markdown.html#heading-ids-and-links))
```bash
brew install ripgrep xclip universal-ctags global
```

#### Install from package

[Change the default editor to Vim](https://askubuntu.com/questions/483308/what-are-the-differences-between-vim-basic-and-vim-tiny).
```bash
sudo update-alternatives --config editor
```

If the built-in version is too old, install with Homebrew.
```bash
brew install vim
```

#### Install from source

[Install prerequisites](https://github.com/vim/vim/blob/master/src/INSTALL).
```bash
sudo apt install git make clang libtool-bin libpython3-dev
```

Clone the repo.
```bash
git clone https://github.com/vim/vim.git
```

Add Python 3 support, uncomment `CONF_OPT_PYTHON3 = --enable-python3interp` in `Makefile`, and run
```bash
make reconfig
```

[Build from source](https://www.vim.org/git.php).
```bash
cd vim/src/
make distclean  # If you build vim before.
make
make test       # Optional, may take a long time.
sudo make install
```

#### Restore

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.vimrc ~/
```

#### Plugins

Open Vim and plugins will be automatically installed by [vim-plug](https://github.com/junegunn/vim-plug).
```bash
vim
```

### Upgrade

#### Upgrade from package

Upgrade Vim.
```bash
sudo apt upgrade vim
```

If installed with Homebrew, run
```bash
brew upgrade vim
```

#### Upgrade from source

Pull the repo.
```bash
cd vim
git pull
```

If `Makefile` locally changed.
```bash
cd vim
git stash
git pull
git stash pop
```

Build again.

### Uninstall

#### Uninstall from package

Uninstall Vim.
```bash
sudo apt remove --purge vim
sudo apt autoremove
```

If installed with Homebrew, run
```bash
brew uninstall vim
```

#### Uninstall from source

[Uninstall Vim](https://github.com/vim/vim/blob/master/src/Makefile).
```bash
make uninstall_runtime
```

### Errors

*YouCompleteMe error: ycmd server SHUT DOWN*

Install prerequisites and [reinstall YouCompleteMe](https://github.com/ycm-core/YouCompleteMe/wiki/Troubleshooting-steps-for-ycmd-server-SHUT-DOWN).
```bash
sudo apt install build-essential cmake vim-nox python3-dev
cd ~/.vim/plugged/YouCompleteMe/
./install.py --clangd-completer --java-completer --go-completer --rust-completer
```

*YouCompleteMe unavailable: requires Vim 9.1.0016+*

Install a newer version Vim.

*YouCompleteMe unavailable: requires Vim compiled with Python (3.8.0+) support*

Build Vim with python 3 support.

## Tmux

### Install

The built-in [Byobu](https://www.byobu.org/home) in Ubuntu may be a better replacement for Tmux.

[Install Tmux](https://github.com/tmux/tmux/wiki/Installing#installing-tmux).
```bash
sudo apt install tmux
```

[Install Tmux Plugin Manager](https://github.com/neovim/neovim.git).
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Create a symbolic link to update configuration.
```bash
ln -sf /home/xianwen/.dotfiles/.tmux.conf ~/
```

### Upgrade

Upgrade Tmux.
```bash
sudo apt upgrade tmux
```

### Uninstall

Uninstall Tmux Plugin Manager.
```bash
rm -rf ~/.tmux/
```

Uninstall Tmux.
```bash
sudo apt remove --purge tmux
sudo apt autoremove
```

## bat

### Install

[Install bat](https://github.com/sharkdp/bat?tab=readme-ov-file#on-macos-or-linux-via-homebrew).
```bash
brew install bat
```

Or [install with apt](https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt), but need to create a symbolic link to replace `batcat` with `bat`, and the version is too old.
```bash
sudo apt install bat
sudo ln -s $(which batcat) ~/usr/local/bin/bat
```

Or [download the lastest .deb package](https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-most-recent-deb-packages). (Ref: [download github release](https://stackoverflow.com/questions/46060010/download-github-release-with-curl))
```bash
curl -OL https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb
sudo dpkg -i bat_0.24.0_amd64.deb
```

[Install bat-extras](https://github.com/eth-p/bat-extras/blob/master/README.md#homebrew).
```bash
brew install bat-extras
```

Create a symbolic link to [replace batman with man](https://github.com/eth-p/bat-extras/blob/master/doc/batman.md#as-a-replacement-for-man).
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

### Upgrade

Upgrade bat.
```bash
brew upgrade bat
```

If installed with apt, run
```bash
sudo apt upgrade bat
```

Upgrade bat-extras.
```bash
brew upgrade bat-extras
```

### Uninstall

Uninstall bat-extras.
```bash
brew uninstall bat-extras
```

Uninstall bat.
```bash
brew uninstall bat
```

If installed with apt, run
```bash
sudo apt remove --purge bat
sudo apt autoremove
```

## fd

### Install

Install fd.
```bash
brew install fd
```

Or [install with apt](https://github.com/sharkdp/fd?tab=readme-ov-file#on-ubuntu), but need to create a symbolic link to replace `fdfind` with `fd`, and the version is too old.
```bash
sudo apt install fd-find
sudo ln -s $(which fdfind) /usr/local/bin/fd
```

### Upgrade

Upgrade fd.
```bash
brew upgrade fd
```

If installed with apt, run
```bash
sudo apt upgrade fd
```

### Uninstall

Uninstall fd.
```bash
brew uninstall fd
```

If installed with apt, run
```bash
sudo apt remove --purge fd
sudo apt autoremove
```

## fzf

### Install

[Install fzf.vim dependencies](https://github.com/junegunn/fzf.vim?tab=readme-ov-file#dependencies).
```bash
brew install bat ripgrep the_silver_searcher perl universal-ctags
```

[Install fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#using-homebrew).
```bash
brew install fzf
```

Or [install with apt](https://github.com/junegunn/fzf?tab=readme-ov-file#linux-packages), but the version is too old.
```bash
sudo apt install fzf
```

Create a symbolic link to [set up shell integration](https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration).
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

### Upgrade

Upgrade fzf.
```bash
brew upgrade fzf
```

If installed with apt, run
```bash
sudo apt upgrade fzf
```

### Uninstall

Uninstall fzf.
```bash
brew uninstall fzf
```

If installed with apt, run
```bash
sudo apt remove --purge fzf
sudo apt autoremove
```

## pwndbg

### Install

[Install pwndbg](https://github.com/pwndbg/pwndbg?tab=readme-ov-file#how).
```bash
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
```

### Uninstall

Remove the source line in the `.gdbinit` file, then remove the `pwndbg` folder to [uninstall](https://github.com/pwndbg/pwndbg/discussions/1155#discussioncomment-6362340).
```bash
rm -rf ~/downloads/pwndbg/
```

## pip registry manager

### Install

[Install pip registry manager](https://github.com/yhangf/PyQuickInstall).
```bash
pip install pqi
```

### Upgrade

[Upgrade pip registry manager](https://stackoverflow.com/questions/47071256/how-to-update-upgrade-a-package-using-pip).
```bash
pip install --upgrade pqi
```

### Uninstall

Uninstall pip registry manager.
```bash
pip uninstall pqi
```

## Fast Node Manager

### Install

[Install Fast Node Manager](https://github.com/Schniz/fnm?tab=readme-ov-file#using-homebrew-macoslinux).
```bash
brew install fnm
```

Or [install with curl](https://github.com/Schniz/fnm?tab=readme-ov-file#using-a-script-macoslinux).
```bash
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
```

[Install completions](https://github.com/Schniz/fnm?tab=readme-ov-file#completions).
```bash
fnm completions --shell bash > $FNM_DIR/completions/bash_completion
fnm completions --shell fish > $FNM_DIR/completions/fish_completion
fnm completions --shell zsh > $FNM_DIR/completions/zsh_completion
```

Create a symbolic link to [do shell setup](https://github.com/Schniz/fnm?tab=readme-ov-file#shell-setup).
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.config/fish/ ~/.config/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

[Install Node.js](https://github.com/Schniz/fnm/blob/master/docs/commands.md#fnm-install) (latest LTS version).
```bash
fnm install --lts
```

### Upgrade

[Upgrade Fast Node Manager](https://github.com/Schniz/fnm?tab=readme-ov-file#upgrade).
```bash
brew upgrade fnm
```

If installed with curl, [rerun](https://github.com/Schniz/fnm?tab=readme-ov-file#upgrade)
```bash
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
```

Upgrade Node.js, rerun
```bash
fnm install --lts
```

### Uninstall

[Uninstall Node.js](https://github.com/Schniz/fnm/blob/master/docs/commands.md#fnm-uninstall).
```bash
fnm uninstall $(fnm current)
```

Remove the setup of Fast Node Manager in shell config (e.g., `~/.bashrc`, `~/.config/fish/config.fish`, `~/.zshrc`, etc.) before [uninstall](https://github.com/Schniz/fnm?tab=readme-ov-file#removing).

Uninstall Fast Node Manager.
```bash
brew uninstall fnm
```

If installed with curl, remove the [Fast Node Manager folder](https://github.com/Schniz/fnm?tab=readme-ov-file#parameters).
```bash
rm -rf ~/.local/share/fnm/
```

## Node Version Manager

### Install

[Install Node Version Manager](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating), which [does not support fish and Homebrew](https://github.com/nvm-sh/nvm?tab=readme-ov-file#important-notes).
```bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
```

Create a symbolic link to [have it automatically sourced upon login](https://github.com/nvm-sh/nvm?tab=readme-ov-file#git-install).
```bash
ln -sf /home/xianwen/.dotfiles/.bashrc ~/
ln -sf /home/xianwen/.dotfiles/.zshrc ~/
```

[Install Node.js](https://github.com/nvm-sh/nvm?tab=readme-ov-file#long-term-support) (latest LTS version).
```bash
nvm install --lts
```

### Upgrade

[Update Node Version Manager](https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script).
```bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
```

[Upgrade Node.js](https://github.com/nvm-sh/nvm?tab=readme-ov-file#long-term-support).
```bash
nvm install --reinstall-packages-from=current 'lts/*'
```

### Uninstall

[Uninstall Node.js](https://github.com/nvm-sh/nvm?tab=readme-ov-file#long-term-support) (latest LTS version).
```bash
nvm uninstall --lts
```

Remove the setup of Node Version Manager in shell config (e.g., `~/.bashrc`, `~/.config/fish/config.fish`, `~/.zshrc`, etc.) before [uninstall](https://github.com/nvm-sh/nvm?tab=readme-ov-file#manual-uninstall).

Uninstall Node Version Manager.
```bash
nvm_dir="${NVM_DIR:-~/.nvm}"
nvm unload
rm -rf "$nvm_dir"
```

### Errors

*curl: (6) Could not resolve host: raw.githubusercontent.com*

If `ping 8.8.8.8` worked, while `ping google.com` failed, [run](https://github.com/nvm-sh/nvm?tab=readme-ov-file#wsl-troubleshooting)
```bash
sudo rm /etc/resolv.conf
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo bash -c 'echo "[network]" > /etc/wsl.conf'
sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
sudo chattr +i /etc/resolv.conf
```

## npm registry manager

### Install

Install npm registry manager.
```bash
npm install -g nrm
```

### Update

Update npm registry manager.
```bash
npm update -g nrm
```

### Uninstall

Uninstall npm registry manager.
```bash
npm uninstall -g nrm
```

## Yarn registry manager

### Install

Install Yarn registry manager.
```bash
npm install -g yrm
```

### Update

Update Yarn registry manager.
```bash
npm update -g yrm
```

### Uninstall

Uninstall Yarn registry manager.
```bash
npm uninstall -g yrm
```

# Dotfiles for PowerShell

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

[Uninstall posh-git](https://learn.microsoft.com/en-us/powershell/module/powershellget/uninstall-module?view=powershellget-3.x).
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

Uninstall PSReadLine.
```powershell
Uninstall-Module PSReadLine
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

