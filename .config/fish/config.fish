if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_config theme choose Dracula # colorscheme

    # Disable greeting message.
    set -g fish_greeting
    # Use vi-mode.
    set -g fish_key_bindings fish_vi_key_bindings
end

# Homebrew
# Put this at top so that app installed by Homebrew can be found.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Set EDITOR to nvim if exists otherwise vim.
# Must put after Homebrew, otherwise nvim cannot be found.
set -gx EDITOR $(command -q nvim; and echo nvim; or echo vim)

# Avoid Executing command "/usr/bin/git" timed out.
# Ref: https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
set -gx STARSHIP_LOG error

# Replace man with batman.
batman --export-env | source

# Set up fzf key bindings.
fzf --fish | source

# Fast Node Manager
fnm env --use-on-cd --shell fish | source

# Starship
# Put this at bottom.
starship init fish | source
