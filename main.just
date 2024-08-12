# Import other justfiles
import "src/install_rust.just"
import "src/config_wez.just"
import "src/basic.just"
import "src/expanded.just"

# Choose installation type
choose:
    #!/usr/bin/env nu
    let choice = (input "Choose installation type (1: Basic, 2: Expanded): ")
    if $choice == "1" {
        just install-basic
    } else if $choice == "2" {
        just install-expanded
    } else {
        echo "Invalid choice. Please run 'just choose' again and select 1 or 2."
    }

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
