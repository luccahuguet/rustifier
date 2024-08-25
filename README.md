# Rustifier

Rustifier is a tool designed to quickly set up a complete Yazelix environment, integrating Zellij, Yazi, Helix, WezTerm, and Nushell. It offers an easy, opinionated setup with the option to include additional useful Rust-based terminal utilities.

## Todo List

- [ ] Update Yazelix README
- [ ] Create Yazelix video
- [ ] Add instructions on how to set zoxide
- [ ] Add instructions on how to set starship
- [ ] evaluate moving system dependencies of nushell into the script
- [ ] Update the testing table

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

1. Clone this repository:
   ```
   git clone https://github.com/luccahuguet/rustifier.git
   cd rustifier
   ```

2. Run the setup script:
   ```
   chmod +x setup.sh
   ./setup.sh
   ```
   This script will check if Rust, Nushell, and Just are installed. If they're not, it will ask for your permission to install them. These tools are required for Rustifier to function properly.

3. Install system dependencies:
   - For Ubuntu/Debian-based systems:
     ```
     sudo apt install libssl-dev
     ```
   - For Fedora:
     ```
     sudo dnf install openssl-devel
     ```
   Note: These may be required for Nushell installation if not already present.

4. Install [Helix](https://docs.helix-editor.com/install.html)

5. Install [WezTerm](https://wezfurlong.org/wezterm/install/linux.html)

6. Configure WezTerm:  
   a. Create or open your `~/.wezterm.lua` file  
   b. Add the following content:  

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

7. Run the installation script:
   ```
   just
   ```
   This will check for the required prerequisites (Rust, WezTerm, and Helix) before proceeding with the installation.

8. Follow the prompts to complete the installation. You'll be asked to choose between four installation types.
