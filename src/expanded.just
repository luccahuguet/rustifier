install-expanded-programs:
    #!/usr/bin/env nu
    let programs = [
        "zellij", "nushell", "helix", "yazi-fm",
        "aichat", "bottom", "cargo-update", "erdtree", "gitui", "helix-term",
        "markdown-oxide", "mise", "onefetch", "ouch", "rusty-rain",
        "starship", "taplo-cli", "tokei", "yazi-cli", "zeitfetch", "zoxide"
    ]
    for program in $programs {
        echo $"Installing ($program)..."
        cargo install $program
    }

default:
    @just install-expanded-programs
