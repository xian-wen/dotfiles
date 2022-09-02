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

# List the installed distributions.
wsl -l -v
```

## Install oh-my-zsh
```bash
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
pip install pqi
```