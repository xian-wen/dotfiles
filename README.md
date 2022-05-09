# Dotfiles for WSL2

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