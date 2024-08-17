# Import other justfiles
import "src/install_rust.just"
import "src/config_wez.just"
import "src/install_helix.just"
import "src/basic.just"
import "src/expanded.just"

# Choose installation type
choose:
    #!/usr/bin/env bash
    echo "Choose installation type:"
    echo "1: Basic"
    echo "2: Expanded"
    read -p "Enter your choice (1 or 2): " choice
    if [ "$choice" = "1" ]; then
        just install-basic
    elif [ "$choice" = "2" ]; then
        just install-expanded
    else
        echo "Invalid choice. Please run 'just choose' again and select 1 or 2."
    fi

# Run basic installation
install-basic: install-rust configure-wezterm
    @just basic::default

# Run expanded installation
install-expanded: install-rust configure-wezterm
    @just expanded::default

# Clone Yazelix configuration
clone-yazelix:
    @echo "Cloning Yazelix configuration..."
    @git clone https://github.com/luccahuguet/yazelix.git ~/.config/yazelix

# Default recipe
default:
    @just choose
