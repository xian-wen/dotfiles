if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_config theme choose Dracula # colorscheme

    # Disable greeting message.
    set -g fish_greeting
    # Use vi-mode.
    set -g fish_key_bindings fish_vi_key_bindings
end

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Set EDITOR to nvim if exists otherwise vim.
# Must put after Homebrew, otherwise nvim cannot be found.
set -gx EDITOR $(command -q nvim; and echo nvim; or echo vim)

# Replace man with batman.
batman --export-env | source

# Set up fzf key bindings.
fzf --fish | source

# Starship
# Ref: https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
set -gx STARSHIP_LOG error
starship init fish | source
