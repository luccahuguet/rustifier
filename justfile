# Choose installation type
choose:
    #!/usr/bin/env bash
    echo "Welcome to Rustifier!"
    echo "This script uses cargo-update, a cargo subcommand for checking and applying updates to installed executables."
    echo ""
    echo "Choose installation type:"
    echo "1: Yazelix Minimal Install"
    echo "   This option installs the core components of Yazelix:"
    echo "   - Zellij: Terminal workspace (multiplexer)"
    echo "   - Yazi: Terminal file manager"
    echo "   - Nushell: Modern shell written in Rust"
    echo "   - Starship: Customizable prompt for any shell"
    echo ""
    echo "2: Yazelix Full Install"
    echo "   This option includes all Minimal Install components, plus:"
    echo "   - Zoxide: Smarter cd command"
    echo "   - Gitui: Terminal UI for git"
    echo "   - Mise: Development tool version manager"
    echo ""
    echo "3: Expanded Installation"
    echo "   This option includes all Full Install components, plus additional utilities."
    echo ""
    echo "Note: All installation types will clone the Yazelix configuration"
    echo "into ~/.config/yazelix. This provides the necessary configuration"
    echo "files for integrating Zellij, Yazi, and Helix."
    echo ""
    read -p "Enter your choice (1, 2, or 3): " choice
    if [ "$choice" = "1" ]; then
        just install-minimal
    elif [ "$choice" = "2" ]; then
        just install-full
    elif [ "$choice" = "3" ]; then
        just install-expanded
    else
        echo "Invalid choice. Please run 'just choose' again and select 1, 2, or 3."
    fi

# Run minimal installation
install-minimal: check-cargo-update install-minimal-programs clone-yazelix

# Run full installation
install-full: install-minimal install-full-programs

# Run expanded installation
install-expanded: install-full install-expanded-programs

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

# Install minimal programs
install-minimal-programs:
    #!/usr/bin/env bash
    echo "Installing minimal Yazelix components..."
    programs=("zellij" "nu" "yazi-fm" "starship")
    for program in "${programs[@]}"; do
        echo "Installing/updating $program..."
        CARGO_INSTALL_OPTS=--locked cargo install-update -i "$program"
    done

# Install full programs
install-full-programs:
    #!/usr/bin/env bash
    echo "Installing additional programs for full setup..."
    programs=("zoxide" "gitui" "mise")
    for program in "${programs[@]}"; do
        echo "Installing/updating $program..."
        CARGO_INSTALL_OPTS=--locked cargo install-update -i "$program"
    done

# Install expanded programs
install-expanded-programs:
    #!/usr/bin/env bash
    echo "Installing additional programs for expanded setup..."
    programs=("aichat" "bottom" "erdtree" "markdown-oxide" "onefetch" "ouch" \
        "rusty-rain" "taplo-cli" "tokei" "yazi-cli" "zeitfetch")
    for program in "${programs[@]}"; do
        echo "Installing/updating $program..."
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
