install-basic-programs:
    #!/usr/bin/env bash
    programs=("zellij" "nushell" "helix" "yazi-fm" "zoxide" "starship")
    for program in "${programs[@]}"; do
        echo "Installing $program..."
        cargo install "$program"
    done

default:
    @just install-basic-programs
