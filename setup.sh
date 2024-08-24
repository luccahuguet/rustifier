#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check Rust installation
check_rust() {
  if ! command_exists rustc; then
    echo "Rust is not installed. Please install Rust before proceeding."
    echo "Visit https://www.rust-lang.org/tools/install for installation instructions."
    echo "After installing Rust, run 'source $HOME/.cargo/env' or restart your terminal."
    exit 1
  else
    echo "Rust is installed."
  fi
}

# Check WezTerm installation
check_wezterm() {
  if ! command_exists wezterm; then
    echo "WezTerm is not installed. Please install WezTerm before proceeding."
    echo "Visit https://wezfurlong.org/wezterm/install/linux.html for installation instructions."
    exit 1
  else
    echo "WezTerm is installed."
  fi
}

# Check Helix installation
check_helix() {
  if ! command_exists hx; then
    echo "Helix is not installed. Please install Helix before proceeding."
    echo "Visit https://docs.helix-editor.com/install.html for installation instructions."
    exit 1
  else
    echo "Helix is installed."
  fi
}

# Main script
echo "Checking prerequisites..."
check_rust
check_wezterm
check_helix

echo "All prerequisites are installed. Proceeding with setup..."

# Check if just is installed
if ! command_exists just; then
  echo "just is not installed."
  read -p "Do you want to install just? (y/n): " confirm
  if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    echo "Installing just..."
    cargo install just
  else
    echo "just is required for the installation process. Exiting."
    exit 1
  fi
fi

echo "First part of the installation is complete."
echo "The following components have been checked or installed:"
echo "- Rust"
echo "- WezTerm"
echo "- Helix"
echo "- just"

echo "To continue with the installation, please run:"
echo "just choose"
