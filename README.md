# Rustifier

Rustifier is a tool designed to quickly set up a complete Yazelix environment, integrating Yazi, Zellij, Helix (the yazelix trinity) running on WezTerm, running Nushell (although nushell is optional). It offers an easy, opinionated setup with the option to include additional useful Rust-based terminal utilities.

## Todo List

- [x] Install just with cargo
- [x] Check and fix links
- [x] Fix Helix installation
- [x] Move Helix installation to a separate file
- [x] Update WezTerm installation process
- [ ] Update Yazelix README
- [ ] Create Yazelix video

## Compatibility

- Tested with:

| Component | Version                  |
| --------- | ------------------------ |
| OS        | Pop!_OS 22.04            |
| DE        | COSMIC                   |
| Zellij    | 0.40.1                   |
| Helix     | helix 24.7 (09297046)    |
| Nushell   | 0.96.1                   |
| Zoxide    | 0.9.4                    |
| Yazi      | 0.2.5                    |
| WezTerm   | 20240203-110809-5046fc22 |

- Should be compatible with various Linux distributions
- This project is experimental and users should exercise caution when installing and use at their own risk. 
- It's recommended to review the installation scripts and understand the changes that will be made to your system before proceeding.

## Prerequisites

- A Linux distribution
- Bash shell
- Git
- WezTerm (to be installed manually)
- Helix (to be installed manually)

Note: Rust and Just will be automatically installed if not already present on your system.

## Installation

1. Install WezTerm:
   - Visit https://wezfurlong.org/wezterm/install/linux.html
   - Ensure WezTerm is properly installed before proceeding

2. Install Helix:
   - Visit https://docs.helix-editor.com/install.html
   - Follow the installation instructions for your system
   - Ensure Helix is properly installed before proceeding

3. Create or open your `~/.wezterm.lua` file:
4. Add the following content to your `~/.wezterm.lua` file:
   ```lua
   -- Pull in the wezterm API
   local wezterm = require 'wezterm'
   -- This will hold the configuration.
   local config = wezterm.config_builder()
   -- This is where you actually apply your config choices
   -- For example, changing the color scheme:
   config.color_scheme = 'Abernathy'
   -- Spawn a nushell shell in login mode
   config.default_prog = { 'nu', '-c', "zellij -l welcome --config-dir ~/.config/yazelix/zellij options --layout-dir ~/.config/yazelix/zellij/layouts" }
   -- Others
   config.hide_tab_bar_if_only_one_tab = true
   config.window_decorations = "NONE"
   -- and finally, return the configuration to wezterm
   return config
   ```

- Note: For extra configuration, visit: https://wezfurlong.org/wezterm/config/files.html
5. Clone this repository:
   ```
   git clone https://github.com/luccahuguet/rustifier.git
   cd rustifier
   ```
6. Run the installation script:
   ```
   ./setup.sh
   ```
7. Follow the prompts to complete the installation. You'll be asked to choose between a basic or expanded installation.

## Project Structure

The project uses a modular structure with separate justfiles for different components:

- `setup.sh`: The main setup script that ensures Rust and Just are installed
- `main.just`: The main justfile that orchestrates the installation process
- `src/install_rust.just`: Handles Rust installation
- `src/basic.just`: Installs core components
- `src/expanded.just`: Installs core components and additional utilities

## The programs

### Required 
- [WezTerm](https://wezfurlong.org/wezterm/): Terminal emulator
- [Helix](https://helix-editor.com): Text editor

### Core Components (Basic installation)
- [Zellij](https://github.com/zellij-org/zellij): Terminal workspace
- [Yazi](https://github.com/sxyazi/yazi): Terminal file manager
- [Yazelix](https://github.com/luccahuguet/yazelix) Integrating Helix, Yazi and zellij
- [Nushell](https://www.nushell.sh/): Modern amazing shell written in rust, best fit to yazelix
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
2. Yazelix should automatically start, providing an integrated environment with Zellij, Yazi, and Helix.
3. Use Zellij for terminal multiplexing, Yazi for file management, and Helix for text editing.
4. Zoxide enhances your directory navigation, while Starship provides a customized prompt.
5. If you chose the expanded installation, utilize the additional utilities as needed in your workflow.

For more information on using Yazelix, refer to the [Yazelix README](https://github.com/luccahuguet/yazelix).

## Contributing

Feel free to open issues or submit pull requests to improve Rustifier. While the aim is for a quick, ready-to-use setup, we're open to suggestions that enhance functionality without compromising ease of use.
