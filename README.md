# Rustifier

Rustifier is a tool designed to quickly set up a complete Yazelix environment, integrating Zellij, Yazi, Helix, WezTerm, and Nushell. It offers an easy, opinionated setup with the option to include additional useful Rust-based terminal utilities.

## Todo List

- [x] Install just with cargo
- [x] Check and fix links
- [x] Fix Helix installation
- [x] Move Helix installation to a separate file
- [ ] Update Yazelix README
- [ ] Create Yazelix video

## Compatibility

- **Full compatibility**: Debian-based Linux distributions (Ubuntu, Pop!_OS, Debian, etc.)
- **Partial compatibility**: Other Linux distributions (may require manual WezTerm installation)

## Prerequisites

- A Linux distribution (Debian-based recommended for full compatibility)
- Bash shell
- Git
- A C++14 compatible compiler (GCC or Clang) for building Helix

Note: Rust and Just will be automatically installed if not already present on your system.

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/luccahuguet/rustifier.git
   cd rustifier
   ```

2. Run the installation script:
   ```
   ./setup.sh
   ```

3. Follow the prompts to complete the installation. You'll be asked to choose between a basic or expanded installation.

## Project Structure

The project uses a modular structure with separate justfiles for different components:

- `setup.sh`: The main setup script that ensures Rust and Just are installed
- `main.just`: The main justfile that orchestrates the installation process
- `src/install_rust.just`: Handles Rust installation
- `src/install_wez.just`: Installs WezTerm
- `src/config_wez.just`: Configures WezTerm
- `src/install_helix.just`: Handles Helix installation
- `src/basic.just`: Installs core components
- `src/expanded.just`: Installs core components and additional utilities

## WezTerm Installation and Configuration

WezTerm will be automatically installed on Debian-based systems. For other systems, you may need to install it manually following the instructions provided during the setup process.

WezTerm configuration lies in a separate repository: [wez-files](https://github.com/yourusername/wez-files), but the installation process will clone this repository and set up WezTerm to use these configuration files for you.

## What's Included

### Core Components (Always Installed)
- [WezTerm](https://wezfurlong.org/wezterm/): Terminal emulator
- [Nushell](https://www.nushell.sh/): Modern shell
- [Zellij](https://github.com/zellij-org/zellij): Terminal workspace
- [Yazi](https://github.com/sxyazi/yazi): Terminal file manager
- [Helix](https://helix-editor.com): Text editor
- [Starship](https://starship.rs): Cross-shell prompt
- [Zoxide](https://github.com/ajeetdsouza/zoxide): Smarter cd command

### Optional Utilities (Expanded Installation)
If you choose the expanded installation, the following will also be installed:

- [aichat](https://github.com/sigoden/aichat): AI-powered chat tool
- [bottom](https://github.com/ClementTsang/bottom): System monitor and process viewer
- [cargo-update](https://github.com/nabijaczleweli/cargo-update): Cargo subcommand for checking and applying updates
- [erdtree](https://github.com/solidiquis/erdtree): File-tree visualizer and disk usage analyzer
- [gitui](https://github.com/extrawurst/gitui): Terminal UI for git
- [markdown-oxide](https://github.com/Feel-ix-343/markdown-oxide): Markdown parser and renderer
- [mise](https://github.com/jdx/mise): Development tool version manager
- [onefetch](https://github.com/o2sh/onefetch): Git repository summary in your terminal
- [ouch](https://github.com/ouch-org/ouch): Compression and decompression tool
- [rusty-rain](https://github.com/cowboy8625/rusty-rain): Terminal-based digital rain effect
- [taplo-cli](https://github.com/tamasfe/taplo): TOML toolkit
- [tokei](https://github.com/XAMPPRocky/tokei): Code statistics tool
- [yazi-cli](https://github.com/sxyazi/yazi): Command-line interface for Yazi
- [zeitfetch](https://github.com/nidnogg/zeitfetch): System information tool

## Usage

1. Open WezTerm.
2. Yazelix will automatically start, providing an integrated environment with Zellij, Yazi, and Helix.
3. Use Zellij for terminal multiplexing, Yazi for file management, and Helix for text editing.
4. Zoxide enhances your directory navigation, while Starship provides a customized prompt.
5. If you chose the expanded installation, utilize the additional utilities as needed in your workflow.

For more information on using Yazelix, refer to the [Yazelix README](https://github.com/luccahuguet/yazelix).

## Contributing

Feel free to open issues or submit pull requests to improve Rustifier. While the aim is for a quick, ready-to-use setup, we're open to suggestions that enhance functionality without compromising ease of use.

## License

This project is licensed under the MIT License.

## Disclaimer

This project is experimental and has been tested primarily on a specific machine, a Lenovo Ideapad 320 running COSMIC 24.04 PopOS. Users should exercise caution when installing and use at their own risk. It's recommended to review the installation scripts and understand the changes that will be made to your system before proceeding.
