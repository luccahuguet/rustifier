# Install Rust if not already installed
install-rust:
    @echo "Checking if Rust is installed..."
    @if ! command -v rustc &> /dev/null; then \
        echo "Rust is not installed. Installing..."; \
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; \
        source "$HOME/.cargo/env"; \
    else \
        echo "Rust is already installed."; \
    fi
