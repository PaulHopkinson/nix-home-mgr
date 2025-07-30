# nix-home-mgr

**A fully-declarative, portable Home Manager setup for Linux (Fedora/Bluefin), tuned for developer productivity and ThinkPad laptops.**

> Fast track your dotfiles: version your shell, editor, scripts, fonts, GNOME desktop, and more—all reproducibly, all in one place.

---

## Features

- **One-command setup**: Reproducible shell, editor, fonts, GNOME, and dev environment with Nix flakes + Home Manager.
- **Hardware-tuned**: Sensible defaults for ThinkPad touchpad/trackpoint, battery scripts, and session UX.
- **Editor-ready**: Out-of-the-box config for Micro (terminal), VSCodium (GUI), and Starship (prompt).
- **No more dotfile drift**: All scripts, config, and user tweaks versioned and portable.
- **Fonts done right**: Declarative, robust, and zero manual copying.
- **Extras included**: Useful scripts, SSH config, screenshot tools, and a workflow for private/secrets.

---

## Repo Structure

```

\~/nix-home-mgr/
├── home.nix                # Main Home Manager config (Nix)
├── flake.nix               # Flake definition for reproducible builds
├── dotfiles/               # Versioned dotfiles
│   ├── editorconfig
│   ├── ssh_config
│   ├── starship.toml
│   ├── micro/              # Micro editor settings
│   ├── vscodium-keybindings.json
│   └── vscodium-settings.json
├── scripts/                # Useful scripts (chmod +x!)
│   ├── check-battery.sh
│   ├── micro-plugins.sh
│   ├── screenshot.sh
│   └── wifi-reset.sh
├── media/                  # Images, wallpapers, branding
│   └── wallpaper.jpg
├── private/                # Not tracked in git: secrets, keys, etc.
└── README.md

```

---

## Quickstart

### 1. Prerequisites

- Nix (with flakes enabled)
- Home Manager (use [Nix flakes installation](https://nix-community.github.io/home-manager/index.html#sec-flakes-standalone))
- Fedora, Bluefin, or similar Linux (should work on any modern Distro)

### 2. Clone and Activate

```sh
git clone https://github.com/PaulHopkinson/nix-home-mgr.git
cd nix-home-mgr
home-manager switch --flake .    # Or use the flake activation command
```

That’s it! Your shell, dotfiles, fonts, GNOME config, and scripts are now in place.

---

## What’s Inside

### home.nix

* **Shells**: Zsh and Bash with shared aliases, plugins, and history settings
* **CLI/Dev tools**: eza, bat, btop, fd, ripgrep, direnv, lazygit, etc.
* **Editor integration**: Micro (terminal) and VSCodium (GUI) with versioned settings
* **Git**: Aliases and sensible settings
* **Starship**: Opinionated, readable prompt, tuned for 1600x900
* **SSH/GPG/Secrets**: Managed securely
* **Fonts**: JetBrains Mono, FiraCode, NerdFonts, Source Code Pro—handled via Nix!
* **GNOME/desktop**: Touchpad/trackpoint, dark theme, favorite apps, keybindings, wallpaper
* **Session variables**: Tidy and reliable

### dotfiles/

* `.editorconfig`: Universal code style (Nix, Python, YAML, JSON, etc.)
* `ssh_config`: Common hosts, patterns, and keys for home lab and remote
* `starship.toml`: Prompt config (change host color per machine if needed)
* `micro/`: Terminal editor settings
* `vscodium-*`: VSCode/VSCodium keybindings and settings

### scripts/

* `check-battery.sh`: Show battery + TLP status (ThinkPad/Lenovo friendly)
* `micro-plugins.sh`: Install all your Micro plugins in one go
* `screenshot.sh`: Save screenshots to `~/Pictures/` with timestamp
* `wifi-reset.sh`: Reset your Wi-Fi device via NetworkManager (auto-detects interface)

### media/

* `wallpaper.jpg`: Set via GNOME dconf. Change to match your resolution if needed.

### private/

* For secrets and non-public config—add to `.gitignore` or encrypt as needed.

---

## Extending

* **Add scripts or dotfiles**: Just drop them in the right folder and map in `home.nix` under `home.file`.
* **Port to another device**: Tweak session variables, dconf, or prompt colors as needed.
* **Add more apps**: Use `home.packages` or `programs.*.enable = true;`.
* **Theming**: Change GNOME/cursor/themes by editing the `gtk` and `dconf` blocks.

---

## Troubleshooting / FAQ

* **Fonts not showing?** Reboot or re-login to reload fontconfig cache.
* **SSH key issues?** Copy private keys to `~/.ssh/`, and set correct permissions.
* **Wallpaper not changing?** Check the wallpaper path in dconf or image resolution.
* **Script won’t run?** Make sure it’s `chmod +x` and mapped in `home.nix`.

---

## Credits

* Inspired by the [NixOS](https://nixos.org/), [Home Manager](https://nix-community.github.io/home-manager/), and the broader dotfiles community.
* Maintained by Paul Hopkinson

---

## License
[MIT](./LICENSE) © 2025 Paul Hopkinson

