# Configure shell
set shell := ["nu", "-c"]

# Package lists
minimal-packages := "zellij yazi-fm starship"
full-packages := "zoxide gitui mise"
optional-packages := "erdtree onefetch rusty-rain taplo-cli tokei yazi-cli zeitfetch"

# Default recipe shows help
default:
    @echo "\nAvailable installation options:"
    @echo "  just install-minimal  - Installs ({{minimal-packages}})"
    @echo "  just install-full    - All packages from install-minimal plus {{full-packages}}"
    @echo "  just install-extra   - All packages from install-full plus {{optional-packages}}"
    @echo "  just install-custom  - All packages from install-full plus your choice of optional packages\n"

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
    "{{packages}}" | split row ' ' | each { |pkg| install-package $pkg }
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
        $selected | each { |pkg| just _install-packages $pkg }
        print "\n🎉 Custom installation complete!\n"
    } else {
        print "\n⚠️ No optional packages were selected.\n🎉 Installation complete!\n"
    }
