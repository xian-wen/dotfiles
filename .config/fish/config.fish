if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_config theme choose Dracula # colorscheme

    # Disable greeting message.
    set -g fish_greeting
    # Use vi-mode.
    set -g fish_key_bindings fish_vi_key_bindings
end

# cs162
if test -d "$HOME/.bin"
    set -gx PATH $HOME/.bin $PATH
end

# Homebrew
# Put this at top so that app installed by Homebrew can be found.
/home/linuxbrew/.linuxbrew/bin/brew shellenv | source

# rustup
if command -q rustup
    set -gx PATH $HOME/.cargo/bin $PATH
end

# pipx
if command -q register-python-argcomplete
    set -gx PATH $HOME/.local/bin $PATH
    register-python-argcomplete --shell fish pipx | source
end

# Fast Node Manager
if command -q fnm
    fnm env --use-on-cd --shell fish | source
    fnm completions --shell fish | source
end

# Set EDITOR to nvim if exists otherwise vim.
if command -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

# Codeium: No heartbeat executed
set -gx no_proxy 127.0.0.1

# MiMo Code
if test -d "$HOME/.mimocode/bin"
    set -gx PATH $HOME/.mimocode/bin $PATH
end

# Replace man with batman.
if command -q batman
    batman --export-env | source
end

# Set up fzf key bindings.
if command -q fzf
    fzf --fish | source
end

# Flutter & Android SDK
if test -d "$HOME/flutter/bin"
    set -gx PATH $HOME/flutter/bin $PATH
end
if test -d "/mnt/c/Users/$USER/AppData/Local/Android/Sdk"
    set -gx ANDROID_HOME "/mnt/c/Users/$USER/AppData/Local/Android/Sdk"
    set -gx ANDROID_SDK_ROOT $ANDROID_HOME
    set -gx PATH $ANDROID_HOME/platform-tools $PATH
    set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH
    set -gx PATH $ANDROID_HOME/emulator $PATH
end

# Starship
# Avoid Executing command "/usr/bin/git" timed out.
# Ref: https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
if command -q starship
    set -gx STARSHIP_LOG error
    starship init fish | source
end
