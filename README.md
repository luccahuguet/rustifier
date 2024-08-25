# Rustifier

Rustifier is a tool designed to quickly set up a complete Yazelix environment, integrating Zellij, Yazi, Helix, WezTerm, and Nushell. It offers an easy, opinionated setup with the option to include additional useful Rust-based terminal utilities.

## Todo List

- [x] Install just with cargo
- [x] Check and fix links
- [x] Fix Helix installation
- [x] Move Helix installation to a separate file
- [x] Update WezTerm installation process
- [x] Note Nushell dependencies in the instructions
- [x] Use cargo-install-update to install some binaries directly
- [ ] Create issue to evaluate using nix for some stuff
- [ ] Update Yazelix README
- [ ] Create Yazelix video
- [ ] Create a separate place for apt things like wl-clipboard
- [x] Incorporate the step of cloning the yazelix repo in a proper place of the justfile
- [x] Ask before cloning yazelix
- [ ] Add instructions on how to document zoxide

## Compatibility
- Should be compatible with various Linux distributions
- This project is experimental and users should exercise caution when installing and use at their own risk. 
- It's recommended to review the installation scripts and understand the changes that will be made to your system before proceeding.
  
Tested with:

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

## Installation

1. Install Rust (if not already installed). Visit https://www.rust-lang.org/tools/install or  
   ```
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
   After installation, run `source $HOME/.cargo/env` or restart your terminal

2. Install system dependencies:
   - For Ubuntu/Debian-based systems:
     ```
     sudo apt install libssl-dev
     ```
   - For Fedora:
     ```
     sudo dnf install openssl-devel
     ```
   Note: These are required for Nushell installation.

3. Install [Helix](https://docs.helix-editor.com/install.html)

4. Install [WezTerm](https://wezfurlong.org/wezterm/install/linux.html)

5. Configure WezTerm  
   a. Create or open your `~/.wezterm.lua` file  
   b. Add the following content  

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

   Note: For extra configuration, visit: https://wezfurlong.org/wezterm/config/files.html

6. Clone this repository
   ```
   git clone https://github.com/luccahuguet/rustifier.git
   cd rustifier
   ```

7. Run the installation script
   ```
   chmod +x ./setup.sh
   ./setup.sh
   ```
   This script will check for the required prerequisites (Rust, WezTerm, and Helix) before proceeding with the installation.

8. Follow the prompts to complete the installation. You'll be asked to choose between a basic or expanded installation.

## Project Structure

The project uses a modular structure with separate justfiles for different components:

- `setup.sh`: The main setup script that checks prerequisites and runs the installation
- `justfile`: The main justfile that orchestrates the installation process

## What's Included

### Core Components (Always Installed)
- [Zellij](https://github.com/zellij-org/zellij): Terminal workspace
- [Yazi](https://github.com/sxyazi/yazi): Terminal file manager
- [Yazelix](https://github.com/luccahuguet/yazelix) Integrating Helix, Yazi and zellij
- [Nushell](https://www.nushell.sh/): Modern amazing shell written in rust, best fit to yazelix
- [Zoxide](https://github.com/ajeetdsouza/zoxide): Smarter cd command

### Optional Utilities (Expanded Installation)
If you choose the expanded installation, the following will also be installed:

- [aichat](https://github.com/sigoden/aichat): AI-powered chat tool
- [bottom](https://github.com/ClementTsang/bottom): System monitor and process viewer
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

## cargo-update instead of raw cargo

Rustifier uses `cargo-update` for installing and updating packages. This approach provides some benefits:
- It updates existing installations if a newer version is available.
- It can sometimes install binaries directly, which can be faster than compiling from source.
- It provides a more consistent way to manage installations and updates across all specified programs.

## Contributing

Feel free to open issues or submit pull requests to improve Rustifier. While the aim is for a quick, ready-to-use setup, we're open to suggestions that enhance functionality without compromising ease of use.
