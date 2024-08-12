import "../src/install_helix.just"

install-basic-programs:
    #!/usr/bin/env bash
    programs=("zellij" "nushell" "yazi-fm" "zoxide" "starship")
    for program in "${programs[@]}"; do
        echo "Installing $program..."
        cargo install "$program"
    done

default:
    @just install-basic-programs
    @just install_helix::install-helix
