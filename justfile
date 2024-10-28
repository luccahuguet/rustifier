# Configure shell
set shell := ["nu", "-c"]

# Package lists
minimal-packages := "zellij yazi-fm starship"
full-packages := "zoxide gitui mise"
optional-packages := "erdtree onefetch rusty-rain taplo-cli tokei yazi-cli zeitfetch"

# Default recipe shows help
default:
    #!/usr/bin/env nu
    
    def apply_color [color: string, str: string] { 
        $"(ansi $color)($str)(ansi reset)" 
    }
    
    # Print header and separator
    print ""
    apply_color "cyan_bold" "🚀 Rustifier Installation Options" | print
    print ""
    apply_color "cyan" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | print
    print ""

    # Print yazelix information first
    apply_color "yellow_bold" "Yazelix: The Core Integration" | print
    apply_color "light_gray" "  All installations include Yazelix, which provides:" | print
    apply_color "light_yellow" "  • Configuration files that integrate Zellij, Yazi, and Helix" | print
    apply_color "light_yellow" "  • Custom keybindings and layouts for seamless workflow" | print
    apply_color "light_yellow" "  • Pre-configured environment setup" | print
    print ""

    # Print installation options using a helper function
    def print_option [cmd: string, desc: string, packages: string] {
        apply_color "magenta_bold" $cmd | print
        apply_color "light_gray" $desc | print
        if not ($packages | is-empty) {
            apply_color "light_green" $"  ($packages)" | print
        }
        print ""
    }

    # Display all installation options
    print_option "Option 1: just install-minimal" "  The essential package suite:" "{{minimal-packages}}"
    print_option "Option 2: just install-full" "  Everything from minimal, plus:" "{{full-packages}}"
    print_option "Option 3: just install-extra" "  Everything from full, plus all optional utilities:" "{{optional-packages}}"
    print_option "Option 4: just install-custom" "  Everything from full, plus your choice of optional utilities" ""

# Core installation function
_install-packages packages:
    #!/usr/bin/env nu
    def install-package [pkg] {
        print $"\n=== Installing/updating ($pkg) ===\n"
        cargo binstall $pkg -y --locked
        if $env.LAST_EXIT_CODE != 0 {
            print $"\nFailed to install ($pkg)\n"
            exit 1
        }
    }
    
    print "\n🚀 Starting package installation...\n"
    for pkg in ("{{packages}}" | split row ' ') { install-package $pkg }
    print "\n✅ Package installation complete!\n"

# Clone Yazelix configuration
clone-yazelix:
    #!/usr/bin/env nu
    print "\n🔍 Checking Yazelix configuration..."
    if ($"($env.HOME)/.config/yazelix" | path exists) {
        print "⚠️  Directory ~/.config/yazelix already exists..."
        print "⚠️  So, skipping this step..."
    } else {
        print "⚠️  Directory ~/.config/yazelix does not exist yet..."
        print "📥 Cloning Yazelix configuration..."
        git clone https://github.com/luccahuguet/yazelix.git $"($env.HOME)/.config/yazelix"
        if $env.LAST_EXIT_CODE != 0 {
            print "\n❌ Failed to clone Yazelix configuration.\n"
            exit 1
        }
        print "\n✅ Yazelix configuration cloned successfully!\n"
    }

# Installation recipes
install-minimal: 
    @echo "\n📦 Starting minimal installation...\n"
    @just _install-packages "{{minimal-packages}}"
    @just clone-yazelix
    @echo "\n🎉 Minimal installation complete!\n"

install-full: install-minimal
    @echo "\n📦 Installing additional packages for full setup...\n"
    @just _install-packages "{{full-packages}}"
    @echo "\n🎉 Full installation complete!\n"

install-extra: install-full
    @echo "\n📦 Installing optional packages...\n"
    @just _install-packages "{{optional-packages}}"
    @echo "\n🎉 Full Extra installation finished!\n"

# Custom installation that lets users pick which optional packages to install
install-custom: install-full
    #!/usr/bin/env nu
    print "\n📦 Custom installation - Choose which optional packages to install\n"
    
    # Create list of optional packages
    let packages = ["{{optional-packages}}"] | split row ' '
    
    # Present interactive selection menu
    let selected = $packages | input list --multi "Select optional packages to install (Space to select, a to toggle all, Enter to confirm)"
    
    if ($selected | length) > 0 {
        print "\n📥 Installing selected packages..."
        for pkg in $selected { just _install-packages $pkg }
        print "\n🎉 Custom installation complete!\n"
    } else {
        print "\n⚠️ No optional packages were selected.\n🎉 Installation complete!\n"
    }
