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
    echo "3: All Optional Utilities"
    echo "   This option includes all Full Install components, plus all additional utilities."
    echo ""
    echo "4: Custom Optional Install"
    echo "   This option includes all Full Install components, plus your choice of additional utilities."
    echo ""
    echo "Note: All installation types will clone the Yazelix configuration"
    echo "into ~/.config/yazelix. This provides the necessary configuration"
    echo "files for integrating Zellij, Yazi, and Helix."
    echo ""
    read -p "Enter your choice (1, 2, 3, or 4): " choice
    if [ "$choice" = "1" ]; then
        just install-minimal
    elif [ "$choice" = "2" ]; then
        just install-full
    elif [ "$choice" = "3" ]; then
        just install-all-optional
    elif [ "$choice" = "4" ]; then
        just install-custom
    else
        echo "Invalid choice. Please run 'just choose' again and select 1, 2, 3, or 4."
    fi

# Run minimal installation
install-minimal: check-cargo-update install-minimal-programs clone-yazelix

# Run full installation
install-full: install-minimal install-full-programs

# Run all optional installation
install-all-optional: install-full install-all-optional-programs

# Run custom installation
install-custom: install-full
    #!/usr/bin/env bash
    echo "Choose which optional programs to install:"
    optional_programs=("aichat" "bottom" "erdtree" "markdown-oxide" "onefetch" "ouch" "rusty-rain" "taplo-cli" "tokei" "yazi-cli" "zeitfetch")
    selected_programs=()
    for program in "${optional_programs[@]}"; do
        read -p "Install $program? (y/n): " choice
        if [[ $choice == [yY] || $choice == [yY][eE][sS] ]]; then
            selected_programs+=("$program")
        fi
    done
    for program in "${selected_programs[@]}"; do
        echo "Installing/updating $program..."
        CARGO_INSTALL_OPTS=--locked cargo install-update -i "$program"
    done

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

# Install all optional programs
install-all-optional-programs:
    #!/usr/bin/env bash
    echo "Installing all optional programs..."
    programs=("aichat" "bottom" "erdtree" "markdown-oxide" "onefetch" "ouch" "rusty-rain" "taplo-cli" "tokei" "yazi-cli" "zeitfetch")
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
