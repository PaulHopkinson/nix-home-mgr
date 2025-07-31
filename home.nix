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
      battery = "acpi -b";
      cat = "bat";
      cd = "z"; # zoxide
      code = "codium";
      edit = "micro";
      find = "fd";
      la = "eza -la";
      ll = "eza -l";
      ps = "btop";
      temp = "sensors";
      tree = "eza --tree";
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
      battery = "acpi -b";
      cat = "bat";
      cd = "z"; # zoxide
      code = "codium";
      edit = "micro";
      find = "fd";
      la = "eza -la";
      ll = "eza -l";
      ps = "btop";
      temp = "sensors";
      tree = "eza --tree";
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
      a = "add";
      amend = "commit --amend --no-edit";
      br = "branch";
      cam = "commit -am";
      ci = "commit";
      co = "checkout";
      d = "diff";
      last = "log -1 HEAD";
      lol = "log --oneline --decorate --graph --all";
      rh = "reset --hard";
      st = "status";
    };
    extraConfig = {
      core.editor = "micro";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
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
    micro
    networkmanagerapplet
    nil
    nix-index
    nixfmt
    podman-compose
    procs
    ripgrep
    rsync
    sops
    starship
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
    gnome-disk-utility
    pavucontrol
    playerctl
    evince
    file-roller

    # --- Editors/IDE ---
    vscodium

    # --- Fonts ---
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.sauce-code-pro
  ];

  # ================================
  #   Dotfiles, Scripts, Fonts
  # ================================
  home.file = {
    # VSCodium settings: Use as a template only, not enforced by Home Manager.
    # ".config/VSCodium/User/keybindings.json".source = ./dotfiles/vscodium-keybindings.json;
    # ".config/VSCodium/User/settings.json".source = ./dotfiles/vscodium-settings.json;

    ".config/micro/settings.json".source = ./dotfiles/micro/settings.json;
    ".config/starship.toml".source = ./dotfiles/starship.toml;
    ".editorconfig".source = ./dotfiles/editorconfig;
    ".ssh/config".source = ./dotfiles/ssh_config;
    "Pictures/wallpaper.jpg".source = ./media/wallpaper.jpg;

    "bin/check-battery".source = ./scripts/check-battery.sh;
    "bin/screenshot".source = ./scripts/screenshot.sh;
    "bin/wifi-reset".source = ./scripts/wifi-reset.sh;
  };

  programs.nix-index.enable = true;

  # ================================
  #       Session/Env Variables
  # ================================
  home.sessionVariables = {
    BROWSER = "firefox";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
    EDITOR = "micro";
    MANPAGER = "bat";
    NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/npmrc";
    PAGER = "bat";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    SUDO_EDITOR = "micro";
    TERMINAL = "gnome-terminal";
    VISUAL = "micro";
  };

  # ================================
  #    GNOME + Desktop Integration
  # ================================
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-date = true;
      color-scheme = "prefer-dark";
      enable-animations = true;
      font-name = "Cantarell 11";
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/desktop/session".idle-delay = 900;
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 20.0;
      night-light-schedule-to = 7.0;
      night-light-temperature = 3700;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false;
      sleep-inactive-ac-timeout = 0;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-timeout = 1800;
      sleep-inactive-battery-type = "suspend";
    };
    "org/gnome/desktop/peripherals/mouse".natural-scroll = true;
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = true;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/peripherals/trackpoint" = {
      accel-profile = "flat";
      scroll-method = "two-finger";
      speed = 0.5;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      screenshot = [ "<Super><Shift>s" ];
      volume-down = [ "<Super>F2" ];
      volume-mute = [ "<Super>F1" ];
      volume-up = [ "<Super>F3" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "gnome-terminal";
      name = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "nautilus";
      name = "Files";
    };
    "org/gnome/desktop/sound".event-sounds = false;
    "org/gnome/shell".favorite-apps = [
      "org.gnome.Terminal.desktop"
      "firefox.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.Settings.desktop"
      "org.gnome.TextEditor.desktop"
    ];
    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file://${config.home.homeDirectory}/Pictures/wallpaper.jpg";
      picture-uri-dark = "file://${config.home.homeDirectory}/Pictures/wallpaper.jpg";
    };
  };

  # ================================
  #               GTK
  # ================================
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    font = {
      name = "Cantarell";
      size = 11;
    };
  };

  fonts.fontconfig.enable = true;
}

