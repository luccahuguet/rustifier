# Choose installation type
choose:
    #!/usr/bin/env bash
    echo "Welcome to Rustifier!"
    echo "All programs will be installed via Cargo, Rust's package manager."
    echo ""
    echo "Choose installation type:"
    echo "1: Basic Installation (Yazelix)"
    echo "   This option installs the core components of Yazelix, a project that integrates"
    echo "   Zellij, Yazi, and Helix, using Yazi as Helix's sidebar. It includes:"
    echo "   - Zellij: Terminal workspace (multiplexer)"
    echo "   - Yazi: Terminal file manager"
    echo "   - Nushell: Modern shell written in Rust, best fit for Yazelix, but not essential"
    echo "   - Zoxide: Smarter cd command, greatly improves the experience"
    echo "   - All written in rust of course!"
    echo "   - note: helix won't be installed since it should be already installed"
    echo ""
    echo "2: Expanded Installation"
    echo "   This option includes all Basic Installation programs, plus:"
    echo "   - aichat: AI-powered chat tool"
    echo "   - bottom: System monitor and process viewer"
    echo "   - cargo-update: Cargo subcommand for checking and applying updates"
    echo "   - erdtree: File-tree visualizer and disk usage analyzer"
    echo "   - gitui: Terminal UI for git"
    echo "   - markdown-oxide: Markdown parser and renderer"
    echo "   - mise: Development tool version manager"
    echo "   - onefetch: Git repository summary in your terminal"
    echo "   - ouch: Compression and decompression tool"
    echo "   - rusty-rain: Terminal-based digital rain effect"
    echo "   - taplo-cli: TOML toolkit"
    echo "   - tokei: Code statistics tool"
    echo "   - yazi-cli: Command-line interface for Yazi"
    echo "   - zeitfetch: System information tool"
    echo ""
    echo "Note: Both installation types will clone the Yazelix configuration"
    echo "into ~/.config/yazelix. This provides the necessary configuration"
    echo "files for integrating Zellij, Yazi, and Helix."
    echo ""
    read -p "Enter your choice (1 or 2): " choice
    if [ "$choice" = "1" ]; then
        just install-basic
    elif [ "$choice" = "2" ]; then
        just install-expanded
    else
        echo "Invalid choice. Please run 'just choose' again and select 1 or 2."
    fi

# Run basic installation
install-basic: install-basic-programs clone-yazelix

# Run expanded installation
install-expanded: install-basic-programs install-expanded-programs clone-yazelix

# Install basic programs
install-basic-programs:
    #!/usr/bin/env bash
    echo "Installing basic programs (Yazelix components)..."
    programs=("zellij" "nu" "yazi-fm" "zoxide")
    for program in "${programs[@]}"; do
        echo "Installing $program..."
        cargo install "$program"
    done

# Install expanded programs
install-expanded-programs:
    #!/usr/bin/env bash
    echo "Installing additional programs for expanded setup..."
    additional_programs=("aichat" "bottom" "cargo-update" "erdtree" "gitui" \
        "markdown-oxide" "mise" "onefetch" "ouch" "rusty-rain" \
        "taplo-cli" "tokei" "yazi-cli" "zeitfetch")
    for program in "${additional_programs[@]}"; do
        echo "Installing additional program: $program..."
        cargo install "$program"
    done

# Clone Yazelix configuration
clone-yazelix:
    @echo "Cloning Yazelix configuration..."
    @echo "This will create a new directory: ~/.config/yazelix"
    @echo "It will contain the configuration files for Zellij, Yazi, and Helix integration."
    @git clone https://github.com/luccahuguet/yazelix.git ~/.config/yazelix

# Default recipe
default:
    @just choose
