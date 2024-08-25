# Check prerequisites
check-prerequisites:
    let rust_installed = (which rustc | is-empty | not)
    let wezterm_installed = (which wezterm | is-empty | not)
    let helix_installed = (which hx | is-empty | not)
    let nushell_installed = (which nu | is-empty | not)
    let binstall_installed = (which cargo-binstall | is-empty | not)

    if not $rust_installed {
        print $"Rust is not installed. Please run the setup script before proceeding."
        exit 1
    }

    if not $nushell_installed {
        print $"Nushell is not installed. Please run the setup script before proceeding."
        exit 1
    }

    if not $binstall_installed {
        print $"cargo-binstall is not installed. Please run the setup script before proceeding."
        exit 1
    }

    if not $wezterm_installed {
        print "WezTerm is not installed. Please install WezTerm before proceeding.\nVisit https://wezfurlong.org/wezterm/install/linux.html for installation instructions."
        exit 1
    }

    if not $helix_installed {
        print "Helix is not installed. Please install Helix before proceeding.\nVisit https://docs.helix-editor.com/install.html for installation instructions."
        exit 1
    }

    print "All prerequisites are installed. Proceeding with setup..."

# Choose installation type
choose: check-prerequisites
    print $"""
    Welcome to Rustifier!
    This script uses cargo-binstall, a tool for installing pre-compiled Rust binaries when available.

    Choose installation type:
    1: Yazelix Minimal Install
       This option installs the core components of Yazelix:
       - Zellij: Terminal workspace (multiplexer)
       - Yazi: Terminal file manager
       - Starship: Customizable prompt for any shell

    2: Yazelix Full Install
       This option includes all Minimal Install components, plus:
       - Zoxide: Smarter cd command
       - Gitui: Terminal UI for git
       - Mise: Development tool version manager

    3: All Optional Utilities
       This option includes all Full Install components, plus all additional utilities.

    4: Custom Optional Install
       This option includes all Full Install components, plus your choice of additional utilities.

    Note: All installation types will clone the Yazelix configuration
    into ~/.config/yazelix. This provides the necessary configuration
    files for integrating Zellij, Yazi, and Helix.
    """

    let choice = (input "Enter your choice (1, 2, 3, or 4): ")
    if $choice == "1" {
        just install-minimal
    } else if $choice == "2" {
        just install-full
    } else if $choice == "3" {
        just install-all-optional
    } else if $choice == "4" {
        just install-custom
    } else {
        print "Invalid choice. Please run 'just choose' again and select 1, 2, 3, or 4."
    }

# Run minimal installation
install-minimal: install-minimal-programs clone-yazelix

# Run full installation
install-full: install-minimal install-full-programs

# Run all optional installation
install-all-optional: install-full install-all-optional-programs

# Run custom installation
install-custom: install-full
    let optional_programs = ["aichat" "bottom" "erdtree" "markdown-oxide" "onefetch" "ouch" "rusty-rain" "taplo-cli" "tokei" "yazi-cli" "zeitfetch"]
    let selected_programs = ($optional_programs | each { |program|
        let choice = (input $"Install ($program)? (y/n): ")
        if $choice == "y" or $choice == "Y" { $program } else { null }
    } | where { |item| $item != null })

    $selected_programs | each { |program|
        print $"Installing/updating ($program)..."
        cargo binstall $program -y --locked
    }

# Install minimal programs
install-minimal-programs:
    print "Installing minimal Yazelix components..."
    let programs = ["zellij" "yazi-fm" "starship"]
    $programs | each { |program|
        print $"Installing/updating ($program)..."
        cargo binstall $program -y --locked
    }

# Install full programs
install-full-programs:
    print "Installing additional programs for full setup..."
    let programs = ["zoxide" "gitui" "mise"]
    $programs | each { |program|
        print $"Installing/updating ($program)..."
        cargo binstall $program -y --locked
    }

# Install all optional programs
install-all-optional-programs:
    print "Installing all optional programs..."
    let programs = ["aichat" "bottom" "erdtree" "markdown-oxide" "onefetch" "ouch" "rusty-rain" "taplo-cli" "tokei" "yazi-cli" "zeitfetch"]
    $programs | each { |program|
        print $"Installing/updating ($program)..."
        cargo binstall $program -y --locked
    }

# Clone Yazelix configuration
clone-yazelix:
    print "Checking Yazelix configuration..."
    if ($"($env.HOME)/.config/yazelix" | path exists) {
        print $"""
        WARNING: The directory ~/.config/yazelix already exists.
        If you want to reinstall Yazelix configuration, please remove the directory
        by running 'rm -rf ~/.config/yazelix' and then run this script again.
        """
    } else {
        print $"""
        Cloning Yazelix configuration...
        This will create a new directory: ~/.config/yazelix
        It will contain the configuration files for Zellij, Yazi, and Helix integration.
        """
        git clone https://github.com/luccahuguet/yazelix.git ~/.config/yazelix
        if $env.LAST_EXIT_CODE == 0 {
            print "Yazelix configuration successfully cloned."
        } else {
            print "Failed to clone Yazelix configuration. Please check your internet connection and try again."
        }
    }

# Default recipe
default:
    just choose
