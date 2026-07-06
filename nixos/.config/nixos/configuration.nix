# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "GlaDOS"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver = {
  #   enable = true;
  #   windowManager.qtile.enable = true;
  # };

  nix.nixPath = [
    "nixos-config=/home/nono/dotfiles/nixos/.config/nixos/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs"
  ];
 
  services.gvfs.enable = true;
  programs.hyprland.enable = true;
  programs.niri.enable = true;
  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  programs.noctalia.systemd.enable = true;
 
	
  services.greetd = {
    enable = true;
    settings = rec {
      # default_session = {
      #   command = "${pkgs.hyprland}/bin/start-hyprland";
      # 	user = "nono";
      # };
      default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "myuser";
      };
    };
  };
  systemd.user.services.niri.enableDefaultPath = false;
  
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        # FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };  

  nix.settings.substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
  
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nono = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  users.defaultUserShell = pkgs.fish;

  programs.firefox.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb_118;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    waybar
    vesktop
    kitty
    kittysay
    fortune
    btop
    obsidian
    brave
    yazi
    awww
    hyprlauncher
    hyprshot
    brightnessctl
    hyfetch
    git
    dunst
    hyprlock
    neovim
    gcc
    tree-sitter
    gimp
    greetd
    zip
    unzip
    lua51Packages.luarocks
    ripgrep 
    trilium-desktop
    python315
    nodejs
    gnumake
    openssl
    dbeaver-bin
    jetbrains.idea
    stow
    appimage-run
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    wayclip
    lazygit
    gdu
    bottom
    hyprtoolkit
    element
    element-desktop
    javaPackages.compiler.openjdk17-bootstrap
    quickshell
    kdePackages.qtsvg
    kdePackages.qtmultimedia
    kdePackages.qtimageformats
    kdePackages.qt5compat
    vimPlugins.nvim-lspconfig
    qt6.qtdeclarative
    cbonsai
    spotify
    gh
    ninja
    meson
    pkg-config
    glib
    maven
    ghostty
    fish
    fishPlugins.fzf
    fd
    bat
    zoxide
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    lexend
    dina-font
  ];

  environment.sessionVariables = {
    QML_IMPORT_PATH = lib.makeSearchPath "lib/qt-6/qml" [
      pkgs.quickshell
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtimageformats
      pkgs.kdePackages.qt5compat
      pkgs.qt6.qtdeclarative
    ];
    ssbackend_secret = "TwilightPrincessIsAGreatZeldaGame123";
  };
  
  security.pam.services.hyprlock = {};
  
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

