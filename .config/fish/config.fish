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
if test -f "$HOME/.cargo/env.fish"
  source "$HOME/.cargo/env.fish"
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

# Replace man with batman.
if command -q batman
  batman --export-env | source
end

# Set up fzf key bindings.
if command -q fzf
  fzf --fish | source
end

# Starship
# Avoid Executing command "/usr/bin/git" timed out.
# Ref: https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
if command -q starship
  set -gx STARSHIP_LOG error
  starship init fish | source
end
