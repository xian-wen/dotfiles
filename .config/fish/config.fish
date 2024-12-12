if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_config theme choose Dracula # colorscheme

    set -g fish_greeting # disable greeeting message
    set -g fish_key_bindings fish_vi_key_bindings # Use vi-mode
end

# Starship
# Ref: https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
set -gx STARSHIP_LOG error
starship init fish | source
