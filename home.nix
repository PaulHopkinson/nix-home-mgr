{ pkgs, config, ... }:

{
  home.username = "paul";
  home.homeDirectory = "/var/home/paul";
  home.stateVersion = "24.05";
  xdg.enable = true;

  # ================================
  #         Shell & CLI
  # ================================
  programs.zsh = {
    enable = true;
    shellAliases = {
      battery = "acpi -b",
      cat = "bat",
      cd = "z", # zoxide
      code = "codium",
      edit = "micro",
      find = "fd",
      la = "eza -la",
      ll = "eza -l",
      ps = "btop",
      temp = "sensors",
      tree = "eza --tree",
    };
    plugins = [
      { name = "zsh-autosuggestions"; src = pkgs.zsh-autosuggestions; }
      { name = "zsh-syntax-highlighting"; src = pkgs.zsh-syntax-highlighting; }
    ];
    initExtra = ''
      setopt COMPLETE_IN_WORD
      setopt HIST_VERIFY
      setopt SHARE_HISTORY
      setopt APPEND_HISTORY
      HISTSIZE=50000
      SAVEHIST=50000
      eval "$(zoxide init zsh)"
    '';
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      battery = "acpi -b",
      cat = "bat",
      cd = "z", # zoxide
      code = "codium",
      edit = "micro",
      find = "fd",
      la = "eza -la",
      ll = "eza -l",
      ps = "btop",
      temp = "sensors",
      tree = "eza --tree",
    };
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.bat.enable = true;
  programs.dircolors.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.less.enable = true;
  programs.man.enable = true;
  programs.micro.enable = true;
  programs.starship.enable = true;
  programs.tealdeer.enable = true;
  programs.tmux.enable = true;
  programs.zoxide.enable = true;

  # ================================
  #      Git & Dev Tooling
  # ================================
  programs.git = {
    enable = true;
    userName = "Paul Hopkinson";
    userEmail = "paul.hopkinson@gmail.com";
    aliases = {
      a = "add",
      amend = "commit --amend --no-edit",
      br = "branch",
      cam = "commit -am",
      ci = "commit",
      co = "checkout",
      d = "diff",
      last = "log -1 HEAD",
      lol = "log --oneline --decorate --graph --all",
      rh = "reset --hard",
      st = "status",
    };
    extraConfig = {
      core.editor = "micro",
      init.defaultBranch = "main",
      pull.rebase = true,
      push.autoSetupRemote = true,
    };
  };
  programs.gh.enable = true;
  programs.lazygit.enable = true;

  # ================================
  #         SSH & Secrets
  # ================================
  programs.gpg.enable = true;
  programs.ssh.enable = true;
  services.gnome-keyring.enable = true;
  services.gpg-agent.enable = true;

  # ================================
  #    Monitoring & System Info
  # ================================
  programs.htop.enable = true;

  # ================================
  #  PDF, Archive, File Management
  # ================================
  programs.evince.enable = true;
  programs.file-roller.enable = true;

  # ================================
  #      Terminal Emulator
  # ================================
  # programs.wezterm.enable = true;

  # ================================
  #  Remote Work & Networking
  # ================================
  programs.mosh.enable = true;

  # ================================
  #      GUI & Packages (sorted)
  # ================================
  home.packages = with pkgs; [
    # --- CLI/dev tools ---
    age
    btop
    chezmoi
    docker-compose
    duf
    dust
    fd
    jq
    just
    networkmanagerapplet
    nil
    nix-index
    nixfmt
    podman-compose
    procs
    ripgrep
    rsync
    sops
    tealdeer
    topgrade
    trash-cli
    tree
    yq

    # --- Hardware/ThinkPad ---
    acpi
    lm_sensors
    nvme-cli
    powertop
    s-tui
    tlp

    # --- GUI, media, network ---
    blueman
    gnome.gnome-disk-utility
    pavucontrol
    playerctl

    # --- Editors/IDE ---
    vscodium
  ];

  # ================================
  #   VSCodium (VSCode) Declarative
  # ================================
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      esbenp.prettier-vscode
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.cpptools
      rust-lang.rust-analyzer
    ];
    settings = {
      "editor.fontFamily" = "'JetBrains Mono', 'Fira Code', 'Source Code Pro', 'monospace'",
      "editor.fontLigatures" = true,
      "editor.fontSize" = 13,
      "editor.lineHeight" = 1.5,
      "editor.tabSize" = 4,
      "editor.insertSpaces" = true,
      "editor.rulers" = [ 80 100 ],
      "editor.minimap.enabled" = false,
      "editor.formatOnSave" = true,
      "workbench.colorTheme" = "Default Dark+",
      "workbench.iconTheme" = "vscode-icons",
      "files.autoSave" = "onWindowChange",
      "files.trimTrailingWhitespace" = true,
      "files.insertFinalNewline" = true,
      "files.exclude" = {
        "**/.DS_Store" = true,
        "**/.git" = true,
        "**/__pycache__" = true,
        "**/node_modules" = true,
        "**/target" = true,
      },
      "files.associations" = {
        "*.md" = "markdown",
        "*.nix" = "nix",
        "flake.lock" = "json",
      },
      "python.linting.enabled" = true,
      "python.linting.flake8Enabled" = true,
      "python.formatting.provider" = "black",
      "rust-analyzer.cargo.useRustcWrapperForBuildScripts" = true,
      "terminal.integrated.fontFamily" = "'JetBrains Mono', 'Fira Code', 'monospace'",
      "terminal.integrated.fontSize" = 12,
      "explorer.confirmDelete" = false,
      "window.zoomLevel" = 0,
    };
  };

  # ================================
  #        Fonts (by Nix)
  # ================================
  fonts.fontconfig.enable = true;

  # ================================
  #   Dotfiles, Scripts, Fonts
  # ================================
  home.file = {
    ".config/VSCodium/User/keybindings.json".source = ./dotfiles/vscodium-keybindings.json;
    ".config/VSCodium/User/settings.json".source = ./dotfiles/vscodium-settings.json;
    ".config/micro/settings.json".source = ./dotfiles/micro/settings.json;
    ".config/starship.toml".source = ./dotfiles/starship.toml;
    ".editorconfig".source = ./dotfiles/editorconfig;
    ".ssh/config".source = ./dotfiles/ssh_config;
    "Pictures/wallpaper.jpg".source = ./media/wallpaper.jpg;

    "bin/check-battery".source = ./scripts/check-battery.sh;
    "bin/screenshot".source = ./scripts/screenshot.sh;
    "bin/wifi-reset".source = ./scripts/wifi-reset.sh;

    ".local/share/fonts/FiraCode" = {
      source = "${pkgs.fira-code}/share/fonts/truetype";
      recursive = true;
    };
    ".local/share/fonts/JetBrainsMono" = {
      source = "${pkgs.jetbrains-mono}/share/fonts/truetype";
      recursive = true;
    };
    ".local/share/fonts/NerdFonts" = {
      source = "${pkgs.nerdfonts}/share/fonts/truetype";
      recursive = true;
    };
    ".local/share/fonts/SourceCodePro" = {
      source = "${pkgs.source-code-pro}/share/fonts/truetype";
      recursive = true;
    };
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  # ================================
  #       Session/Env Variables
  # ================================
  home.sessionVariables = {
    BROWSER = "firefox",
    CARGO_HOME = "$XDG_DATA_HOME/cargo",
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock",
    EDITOR = "micro",
    MANPAGER = "bat",
    NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/npmrc",
    PAGER = "bat",
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup",
    SUDO_EDITOR = "micro",
    TERMINAL = "gnome-terminal",
    VISUAL = "micro",
  };

  # ================================
  #    GNOME + Desktop Integration
  # ================================
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-date = true,
      color-scheme = "prefer-dark",
      enable-animations = true,
      font-name = "Cantarell 11",
      gtk-theme = "Adwaita-dark",
    };
    "org/gnome/desktop/session".idle-delay = 900;
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true,
      night-light-schedule-automatic = false,
      night-light-schedule-from = 20.0,
      night-light-schedule-to = 7.0,
      night-light-temperature = 3700,
    };
    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false,
      sleep-inactive-ac-timeout = 0,
      sleep-inactive-ac-type = "nothing",
      sleep-inactive-battery-timeout = 1800,
      sleep-inactive-battery-type = "suspend",
    };
    "org/gnome/desktop/peripherals/mouse".natural-scroll = true;
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = true,
      tap-to-click = true,
      two-finger-scrolling-enabled = true,
    };
    "org/gnome/desktop/peripherals/trackpoint" = {
      accel-profile = "flat",
      scroll-method = "two-finger",
      speed = 0.5,
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/",
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/",
      ],
      screenshot = [ "<Super><Shift>s" ],
      volume-down = [ "<Super>F2" ],
      volume-mute = [ "<Super>F1" ],
      volume-up = [ "<Super>F3" ],
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return",
      command = "gnome-terminal",
      name = "Terminal",
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e",
      command = "nautilus",
      name = "Files",
    };
    "org/gnome/desktop/sound".event-sounds = false;
    "org/gnome/shell".favorite-apps = [
      # GNOME shell expects ordering for the dock.
      "org.gnome.Terminal.desktop"
      "firefox.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.Settings.desktop"
      "org.gnome.TextEditor.desktop"
    ];
    "org/gnome/desktop/background" = {
      picture-options = "zoom",
      picture-uri = "file://${config.home.homeDirectory}/Pictures/wallpaper.jpg",
      picture-uri-dark = "file://${config.home.homeDirectory}/Pictures/wallpaper.jpg",
    };
  };

  # ================================
  #               GTK
  # ================================
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark",
      package = pkgs.gnome-themes-extra,
    };
    iconTheme = {
      name = "Adwaita",
      package = pkgs.gnome-themes-extra,
    };
    cursorTheme = {
      name = "Adwaita",
      package = pkgs.gnome-themes-extra,
    };
    font = {
      name = "Cantarell",
      size = 11,
    };
  };
}

