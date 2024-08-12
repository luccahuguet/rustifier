# Rustifier

Rustifier is a tool designed to quickly set up a complete Yazelix environment, integrating Zellij, Yazi, Helix, WezTerm, and Nushell. It offers an easy, opinionated setup with the option to include additional useful Rust-based utilities.

## Compatibility

- **Full compatibility**: Debian-based Linux distributions (Ubuntu, Pop!_OS, Debian, etc.)
- **Partial compatibility**: Other Linux distributions (may require manual WezTerm installation)

## Prerequisites

- A Linux distribution (Debian-based recommended for full compatibility)
- [Rust](https://www.rust-lang.org/tools/install) programming language
- [Just](https://github.com/casey/just) command runner

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/luccahuguet/rustifier.git
   cd rustifier
   ```

2. Run the installation script:
   ```
   just
   ```

3. Follow the prompts to complete the installation. You'll be asked to choose between a basic or expanded installation.

## Project Structure

The project uses a modular structure with separate justfiles for different components:

- `main.just`: The main justfile that orchestrates the installation process
- `src/install_rust.just`: Handles Rust installation
- `src/config_wez.just`: Configures WezTerm
- `src/basic.just`: Installs core components
- `src/expanded.just`: Installs core components and additional utilities

## WezTerm Configuration

WezTerm configuration is handled by a separate repository:

- [wez-files](https://github.com/yourusername/wez-files): Contains WezTerm configuration files

The installation process will clone this repository and set up WezTerm to use these configuration files.

## What's Included

### Core Components (Always Installed)
- [WezTerm](https://wezfurlong.org/wezterm/): Terminal emulator
- [Nushell](https://www.nushell.sh/): Modern shell
- [Zellij](https://github.com/zellij-org/zellij): Terminal workspace
- [Yazi](https://github.com/sxyazi/yazi): Terminal file manager
- [Helix](https://helix-editor.com): Text editor

### Optional Utilities (Expanded Installation)
If you choose the expanded installation, the following will also be installed:
- aichat
- bottom
- cargo-update
- erdtree
- gitui
- helix-term
- markdown-oxide
- mise
- onefetch
- ouch
- rusty-rain
- starship
- taplo-cli
- tokei
- yazi-cli
- zeitfetch
- zoxide

## Post-Installation

After installation, your Yazelix environment is ready to use. Simply open WezTerm, and it will automatically start Nushell and launch Yazelix with the correct configuration.

## Usage

1. Open WezTerm.
2. Yazelix will automatically start, providing an integrated environment with Zellij, Yazi, and Helix.
3. Use Zellij for terminal multiplexing, Yazi for file management, and Helix for text editing.
4. If you chose the expanded installation, utilize the additional utilities as needed in your workflow.

For more information on using Yazelix, refer to the [Yazelix README](https://github.com/luccahuguet/yazelix).

## Contributing

Feel free to open issues or submit pull requests to improve Rustifier. While we aim for a quick, ready-to-use setup, we're open to suggestions that enhance functionality without compromising ease of use.

## License

This project is licensed under the MIT License.
