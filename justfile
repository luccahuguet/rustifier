# Configure shell
set shell := ["nu", "-c"]

# Package lists
minimal-packages := "zellij yazi-fm starship"
full-packages := "zoxide gitui mise"
optional-packages := "erdtree onefetch rusty-rain taplo-cli tokei yazi-cli zeitfetch"

# Default recipe shows help
default:
    @echo "\nAvailable installation options:"
    @echo "  just install-min  - Minimal install ({{minimal-packages}})"
    @echo "  just install-full - Full install (adds {{full-packages}})"
    @echo "  just install-all  - Complete install (adds {{optional-packages}})\n"

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
        print $"\n⚠️  WARNING: Directory ~/.config/yazelix already exists.\n"
    } else {
        print "\n📥 Cloning Yazelix configuration..."
        git clone https://github.com/luccahuguet/yazelix.git $"($env.HOME)/.config/yazelix"
        if $env.LAST_EXIT_CODE != 0 {
            print "\n❌ Failed to clone Yazelix configuration.\n"
            exit 1
        }
        print "\n✅ Yazelix configuration cloned successfully!\n"
    }

# Installation recipes
install-min: 
    @echo "\n📦 Starting minimal installation...\n"
    @just _install-packages "{{minimal-packages}}"
    @just clone-yazelix
    @echo "\n🎉 Minimal installation complete!\n"

install-full: install-min
    @echo "\n📦 Installing additional packages for full setup...\n"
    @just _install-packages "{{full-packages}}"
    @echo "\n🎉 Full installation complete!\n"

install-all: install-full
    @echo "\n📦 Installing optional packages...\n"
    @just _install-packages "{{optional-packages}}"
    @echo "\n🎉 Complete installation finished!\n"
