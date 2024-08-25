# Choose installation type
choose:
    #!/usr/bin/env bash
    echo "Welcome to Rustifier!"
    echo "This script uses cargo-update, a cargo subcommand for checking and applying updates to installed executables."
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
install-basic: check-cargo-update install-basic-programs clone-yazelix

# Run expanded installation
install-expanded: check-cargo-update install-basic-programs install-expanded-programs clone-yazelix

# Check and install cargo-update if necessary
check-cargo-update:
    #!/usr/bin/env bash
    if ! command -v cargo-install-update &> /dev/null; then
        echo "cargo-update is not installed."
        read -p "Do you want to install cargo-update? (y/n): " confirm
        if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
            echo "Installing cargo-update..."
            cargo install --locked cargo-update
        else
            echo "cargo-update is required for the installation process. Exiting."
            exit 1
        fi
    else
        echo "cargo-update is already installed. Proceeding with installation..."
    fi

# Install basic programs
install-basic-programs:
    #!/usr/bin/env bash
    echo "Installing basic programs (Yazelix components)..."
    programs=("zellij" "nu" "yazi-fm" "zoxide")
    for program in "${programs[@]}"; do
        echo "Installing/updating $program..."
        CARGO_INSTALL_OPTS=--locked cargo install-update -i "$program"
    done

# Install expanded programs
install-expanded-programs:
    #!/usr/bin/env bash
    echo "Installing additional programs for expanded setup..."
    additional_programs=("aichat" "bottom" "erdtree" "gitui" \
        "markdown-oxide" "mise" "onefetch" "ouch" "rusty-rain" \
        "taplo-cli" "tokei" "yazi-cli" "zeitfetch")
    for program in "${additional_programs[@]}"; do
        echo "Installing/updating additional program: $program..."
        CARGO_INSTALL_OPTS=--locked cargo install-update -i "$program"
    done

# Clone Yazelix configuration
clone-yazelix:
    #!/usr/bin/env bash
    echo "Checking Yazelix configuration..."
    if [ -d "$HOME/.config/yazelix" ]; then
        echo "WARNING: The directory ~/.config/yazelix already exists."
        echo "If you want to reinstall Yazelix configuration, please remove the directory"
        echo "by running 'rm -rf ~/.config/yazelix' and then run this script again."
    else
        echo "Cloning Yazelix configuration..."
        echo "This will create a new directory: ~/.config/yazelix"
        echo "It will contain the configuration files for Zellij, Yazi, and Helix integration."
        git clone https://github.com/luccahuguet/yazelix.git ~/.config/yazelix
        if [ $? -eq 0 ]; then
            echo "Yazelix configuration successfully cloned."
        else
            echo "Failed to clone Yazelix configuration. Please check your internet connection and try again."
        fi
    fi

# Default recipe
default:
    @just choose
