# Check requirements for Helix installation
check-helix-requirements:
    #!/usr/bin/env bash
    if ! command -v g++ &> /dev/null && ! command -v clang++ &> /dev/null; then
        echo "Error: A C++14 compatible compiler (GCC or Clang) is required to build Helix."
        echo "Please install GCC or Clang before proceeding."
        exit 1
    fi

# Install Helix
install-helix:
    @just check-helix-requirements
    @echo "Cloning Helix repository..."
    git clone https://github.com/helix-editor/helix
    cd helix
    @echo "Building and installing Helix..."
    cargo install --path helix-term --locked
    @echo "Setting up Helix runtime..."
    sudo mkdir -p /usr/local/lib/helix
    sudo cp -r runtime /usr/local/lib/helix/
    @echo "Helix installation complete."
    cd ..
    rm -rf helix

# Default recipe
default:
    @just install-helix
