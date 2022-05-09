# Dotfiles for WSL2

## Install WSL2
```PowerShell
wsl --install
```

## Install oh-my-zsh
```bash
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
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```
```bash
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