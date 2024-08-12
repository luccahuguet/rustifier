# Install WezTerm
install-wezterm:
    @echo "Installing WezTerm..."
    @if command -v apt &> /dev/null; then \
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg; \
        echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list; \
        sudo apt update && sudo apt install -y wezterm; \
    else \
        echo "This system is not Debian-based. Please install WezTerm manually:"; \
        echo "Visit https://wezfurlong.org/wezterm/installation.html for instructions."; \
    fi

# Default recipe
default:
    @just install-wezterm
