# Rustifier (WARNING: BARELY TESTED, MIGHT SHOW UNEXPECTED BEHAVIOR)

Rustifier is a tool designed to quickly set up a complete Yazelix environment, integrating Zellij, Yazi, Helix, WezTerm, and Nushell. It offers an easy, opinionated setup with the option to include additional useful Rust-based terminal utilities.

## Todo List

- [x] Update Yazelix README
- [x] Create Yazelix video
- [ ] Add instructions on how to set zoxide
- [ ] Add instructions on how to set starship
- [ ] maybe create a rustifier_programs folder in users $HOME?
- [ ] evaluate moving system dependencies of nushell into the script
- [ ] Update the testing table

## Compatibility
- WARNING: The current version has not been tested yet
- Should be compatible with various Linux distributions
- This project is experimental and users should exercise caution when installing and use at their own risk. 
- It's recommended to review the installation scripts and understand the changes that will be made to your system before proceeding.
  
(stale) A previous version of rustifier was tested with:

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
   ```bash
   mkdir ~/rustifier_programs
   git clone https://github.com/luccahuguet/rustifier.git ~/rustifier_programs 
   cd rustifier
   ```

2. Setting up base programs

   1. Run the setup script:
      ```bash
      chmod +x setup.sh
      ./setup.sh
      ```
         This script will check if Rust, Nushell, and Just are installed. If they're not, it will ask for your permission to install them. These tools are required for Rustifier to function properly.

   2. Restart your shell or run `exec $SHELL` (bash)

3. Install system dependencies:
   - For Ubuntu/Debian-based systems:
     ```bash
     sudo apt install libssl-dev
     ```
   - For Fedora:
     ```bash
     sudo dnf install openssl-devel
     ```
   Note: These may be required for Nushell installation if not already present.

4. Install [Helix](https://docs.helix-editor.com/install.html)
    - For instance if you want to build it from source:
      ```bash
      git clone https://github.com/helix-editor/helix ~/rustifier_programs/helix
      cd helix
      ```
    - And then:
      ```bash
      cargo install --path helix-term --locked
      ```
5. Install Wezterm. Click [here](https://wezfurlong.org/wezterm/install/linux.html) to see many installation options... or for debian/ubuntu systems:

      - Configure the apt repo:
         ```bash
         curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
         echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
         ```

      - And then:
         ```bash
         sudo apt update
         sudo apt install wezterm
         ```

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
   This will some show installation options on your screen, pick your poison :poison: and follow the steps! 


8. Now it seems everything is installed, right? Please reboot your machine for good measure

## What's Included

### 1. Yazelix Minimal Install
- [Zellij](https://github.com/zellij-org/zellij): Terminal workspace
- [Yazi](https://github.com/sxyazi/yazi): Terminal file manager
- [Yazelix](https://github.com/luccahuguet/yazelix): Integrating Helix, Yazi and zellij
- [Nushell](https://www.nushell.sh/): Modern amazing shell written in rust, best fit to yazelix
- [Starship](https://starship.rs/): Customizable prompt for any shell

### 2. Yazelix Full Install
* Includes all components from the Minimal Install, plus:
* [Zoxide](https://github.com/ajeetdsouza/zoxide): Smarter cd command
* [Gitui](https://github.com/extrawurst/gitui): Terminal UI for git
* [Mise](https://github.com/jdx/mise): Development tool version manager

### 3. All Optional Utilities
Includes everything from the Full Install, plus all of the following:

- [erdtree](https://github.com/solidiquis/erdtree): File-tree visualizer and disk usage analyzer
- [onefetch](https://github.com/o2sh/onefetch): Git repository summary in your terminal
- [rusty-rain](https://github.com/cowboy8625/rusty-rain): Terminal-based digital rain effect
- [taplo-cli](https://github.com/tamasfe/taplo): TOML toolkit
- [tokei](https://github.com/XAMPPRocky/tokei): Code statistics tool
- [yazi-cli](https://github.com/sxyazi/yazi): Command-line interface for Yazi
- [zeitfetch](https://github.com/nidnogg/zeitfetch): System information tool

### 4. Custom Optional Install
Includes everything from the Full Install, but lets you pick which additional utilities to install from the list above.

## Usage

1. Open WezTerm.
2. Yazelix should automatically start, providing an integrated environment with Zellij, Yazi, and Helix.
3. Use Zellij for terminal multiplexing, Yazi for file management, and Helix for text editing.
4. Nushell provides a modern shell experience, while Starship offers a customized prompt.
5. If you chose the Full, All Optional, or Custom installation, utilize the additional utilities as needed in your workflow.

For more information on using Yazelix, refer to the [Yazelix README](https://github.com/luccahuguet/yazelix).

## cargo-binstall for Installation

Rustifier uses `cargo-binstall` for installing and updating packages. This approach provides some benefits:
- It can install pre-compiled binaries when available, which is often faster than compiling from source.
- It falls back to building from source when pre-compiled binaries are not available.
- It provides a consistent way to manage installations across all specified programs.

## Contributing

Feel free to open issues or submit pull requests to improve Rustifier. While the aim is for a quick, ready-to-use setup, we're open to suggestions that enhance functionality without compromising ease of use.
