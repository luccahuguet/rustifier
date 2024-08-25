#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to ask for user permission
ask_permission() {
    read -p "$1 (y/n): " choice
    case "$choice" in 
        y|Y ) return 0;;
        n|N ) return 1;;
        * ) echo "Invalid input. Please enter 'y' or 'n'."; ask_permission "$1";;
    esac
}

# Check if Rust is installed
if ! command_exists cargo; then
    echo "Rust is not installed."
    if ask_permission "Do you want to install Rust?"; then
        echo "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source $HOME/.cargo/env
        echo "Rust has been installed."
    else
        echo "Rust installation skipped. Note that Rust is required for Rustifier."
        exit 1
    fi
else
    echo "Rust is already installed."
fi

# Check if Nushell is installed
if ! command_exists nu; then
    echo "Nushell is not installed."
    if ask_permission "Do you want to install Nushell?"; then
        echo "Installing Nushell..."
        cargo install nu
        echo "Nushell has been installed."
    else
        echo "Nushell installation skipped. Note that Nushell is required for Rustifier."
        exit 1
    fi
else
    echo "Nushell is already installed."
fi

# Check if Just is installed
if ! command_exists just; then
    echo "Just is not installed."
    if ask_permission "Do you want to install Just?"; then
        echo "Installing Just..."
        cargo install just
        echo "Just has been installed."
    else
        echo "Just installation skipped. Note that Just is required for Rustifier."
        exit 1
    fi
else
    echo "Just is already installed."
fi

echo "Setup complete. You can now proceed with the Rustifier installation."
