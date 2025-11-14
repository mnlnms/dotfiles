#!/bin/zsh
echo "Checking Command Line Tools for Xcode"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  echo "Command Line Tools for Xcode not found. Installing from softwareupdate…"
# This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
  softwareupdate -i "$PROD" --verbose;
else
  echo "✅ Command Line Tools for Xcode have been installed."
fi

if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
    echo "Rosetta ist nicht installiert. Installation wird gestartet..."
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
else
    echo "✅ Rosetta ist bereits installiert."
fi

if ! command -v nix >/dev/null 2>&1; then
	echo "Installing Determinate Nix ..."
	curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm | tee /tmp/nix-install.log

	echo "⏳ Waiting for Nix installer to complete..."
	until grep -q "Nix was installed successfully" /tmp/nix-install.log; do
		sleep 1
	done

	echo "✅ Nix reported successful installation."
	echo "🔄 Loading Nix environment..."
	# Wait a bit to ensure files are in place, then source it
	sleep 2
	if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
		. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	else
		echo "⚠️ Could not find nix-daemon.sh — maybe Nix install path changed?"
	fi
else
  echo "✅ Nix is already installed."
fi

if ! command -v darwin-rebuild >/dev/null 2>&1; then
	echo "Installing nix-darwin ..."
	sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake 'github:mnlnms/dotfiles?dir=dot_config/nix-darwin#macbook-air-m1'
	echo "✅ Nix-Darwin reported successful installation."
	echo "🔄 Loading Nix environment..."
	sleep 2
	export PATH="/run/current-system/sw/bin:$PATH"
	echo "✅ Environment reloaded."
else
	echo "✅ Nix-Darwin is already installed."
fi

echo "⏳ Delpoying Dotfiles via Chezmoi"
chezmoi init mnlnms





# # Install Homebrew if necessary
# if which -s brew; then
#   echo 'Homebrew is already installed'
# else
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#     (
#         echo
#         echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
#     ) >>$HOME/.zprofile
#     eval "$(/opt/homebrew/bin/brew shellenv)"
# fi
# 
# brew install chezmoi
