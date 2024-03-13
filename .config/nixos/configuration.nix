# Get help:
# -- NixOS manual: run 'nixos-help'
# -- configuration.nix(5) man page

{ config, pkgs, flake-inputs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    kernel.sysctl = {
      "kernel.sysrq" = 1; # enable REISUB
      "vm.swappiness" = 2; # increment if RAM is often overused
    };

    # setup keyfile
    # initrd.secrets = {
    #   "/crypto_keyfile.bin" = null;
    # };

    # support ntfs (for external drives)
    supportedFilesystems = [ "ntfs" ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  services = {
    xserver = {
      # enable the X11 windowing system
      enable = true;

      # configure keymap in X11
      xkb = {
        layout = "de";
        variant = "neo"; # neo keyboard layout
      };

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      windowManager.bspwm.enable = true;
    };

    picom.enable = true;

    blueman.enable = true;

    # Enable CUPS to print documents
    printing.enable = true;
  };

  console.keyMap = "neo";

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    # set default shell to zsh
    defaultUserShell = pkgs.zsh;

    # define user account
    extraUsers = {
      johannes = {
        isNormalUser = true;
        description = "johannes";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
      };
    };
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # --- terminal
    alacritty
    bat
    fzf
    neovim
    ripgrep
    tig
    tmate
    tmux
    tree
    xclip
    zsh

    # -- git
    git
    gh
    diff-so-fancy

    # --- remote
    curl
    flyctl
    wget
    magic-wormhole
    networkmanagerapplet
    openssl

    # --- system
    htop
    ntfs3g
    parted

    # --- build
    gnumake
    gcc
    glibc

    # --- utilities
    brave
    cloc
    direnv
    fd
    file
    firefox
    keepassxc
    libsForQt5.dolphin
    libsForQt5.gwenview
    nix-output-monitor
    p7zip
    psmisc
    shutter
    signal-desktop
    taskwarrior
    thunderbird
    unzip
    vscode
    zip

    # --- mobile
    # android-studio
    # android-tools
    # android-udev-rules
    # flutter-unwrapped
    # jdk17
    usbutils
    util-linux

    # --- programming/scripting
    # go
    python3
    ruby_3_2
    rubyPackages_3_2.openssl
    libffi
    rustup
    nodejs_20
    prettierd

    # --- window manager
    bspwm
    dmenu
    feh
    i3lock-color
    imagemagick
    picom
    polybarFull
    sxhkd

    # --- data
    litecli
    # sqlite-interactive

    # --- crypto
    gnupg
    pinentry-curses
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryFlavor = "curses";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "RobotoMono" ]; })
  ];

  hardware.bluetooth.enable = true;

  environment = {
    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
  };

  programs = {
    ssh.startAgent = true;
    zsh.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];

    # registry entries
    registry.unstable.flake = flake-inputs.nixpkgs;

    # nix path to correspond to my flakes
    nixPath = [
      "unstable=${flake-inputs.nixpkgs}"
    ];

    # nixdirenv requires this to stop nix from garbage collecting its stuff
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
