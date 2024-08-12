install-basic-programs:
    #!/usr/bin/env nu
    let programs = ["zellij", "nushell", "helix", "yazi-fm"]
    for program in $programs {
        echo $"Installing ($program)..."
        cargo install $program
    }

default:
    @just install-basic-programs
