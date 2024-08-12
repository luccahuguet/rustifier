import "../src/basic.just"

install-expanded-programs:
    #!/usr/bin/env bash
    just basic::install-basic-programs
    additional_programs=("aichat" "bottom" "cargo-update" "erdtree" "gitui" "helix-term" \
        "markdown-oxide" "mise" "onefetch" "ouch" "rusty-rain" \
        "taplo-cli" "tokei" "yazi-cli" "zeitfetch")
    for program in "${additional_programs[@]}"; do
        echo "Installing additional program: $program..."
        cargo install "$program"
    done

default:
    @just install-expanded-programs
