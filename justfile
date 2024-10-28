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
    
    # Print header
    print ""
    apply_color "cyan_bold" "🚀 Welcome to Rustifier!" | print
    apply_color "yellow" "This part of the setup install things from cargo" | print
    print ""
    apply_color "yellow" "Yazelix is at the core of every installation, providing:" | print
    apply_color "light_gray" "  • Integrated configuration for Zellij, Yazi, and Helix" | print
    apply_color "light_gray" "  • Custom keybindings and layouts for seamless workflow" | print
    apply_color "light_gray" "  • Pre-configured environment setup" | print
    print ""
    
    # Create installation options with package details
    let options = [
        $"1. Minimal Installation \(honestly, boring\)\n   Packages: {{minimal-packages}}\n"
        $"2. Full Installation \(now you're graduating from childhood\)\n Minimal plus: {{full-packages}}\n"
        $"3. Full Extra Installation \(includes some extra utilities\)\n  Full plus: {{optional-packages}}\n"
        "4. Custom Installation \(picky aren't we?\)\n All from Full and pick your extras\n"
    ]

    # Present interactive selection menu
    let selected = $options | input list "Choose your installation type:"
    print ""
    
    let command = match ($selected | str substring 0..1 | into int) {
        1 => "just install-minimal"
        2 => "just install-full"
        3 => "just install-extra"
        4 => "just install-custom"
        _ => ""
    }
    
    apply_color "cyan" $"Run this command to start installation: ($command)" | print
    print ""

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
