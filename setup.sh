#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if Rust is installed
if ! command_exists rustc; then
  echo "Rust is not installed. Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Check if just is installed
if ! command_exists just; then
  echo "just is not installed. Installing just..."
  cargo install just
fi

# Now that we're sure just is installed, we can use it
just choose
