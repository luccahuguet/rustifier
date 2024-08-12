# Configure Wezterm
configure-wezterm:
    @echo "Configuring WezTerm..."
    @if [ -f ~/.wezterm.lua ]; then \
        echo "Warning: Existing WezTerm configuration detected at ~/.wezterm.lua"; \
        echo "The Rustifier configuration may override some of your existing settings."; \
        echo "The following line will be added to your ~/.wezterm.lua file:"; \
        echo "return { config_files = { '~/.config/wezterm-rustifier/wezterm.lua' } }"; \
        read -p "Do you want to continue? (y/n) " answer; \
        if [ "$$answer" != "y" ]; then \
            echo "WezTerm configuration skipped."; \
            exit 0; \
        fi; \
    fi
    @mkdir -p ~/.config
    @git clone https://github.com/yourusername/wez-files.git ~/.config/wezterm-rustifier
    @echo "local wezterm = require 'wezterm'" > ~/.wezterm.lua
    @echo "return { config_files = { '~/.config/wezterm-rustifier/wezterm.lua' } }" >> ~/.wezterm.lua
    @echo "WezTerm configuration has been set up. The Rustifier configuration is now loaded from ~/.config/wezterm-rustifier/wezterm.lua"

# Default recipe
default:
    @just configure-wezterm
