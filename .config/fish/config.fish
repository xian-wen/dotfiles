if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_config theme choose Dracula # colorscheme

    set -g fish_greeting # disable greeeting message
    set -g fish_key_bindings fish_vi_key_bindings # use vi-mode
end

set -gx EDITOR nvim # use nvim as the default editor

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Starship
# Ref: https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
set -gx STARSHIP_LOG error
starship init fish | source
