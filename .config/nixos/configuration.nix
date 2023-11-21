# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, flake-inputs, ... }:

{
  boot = {
    # bootloader
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    # setup keyfile
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    # support ntfs (for external drives)
    supportedFilesystems = [ "ntfs" ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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
      # enable the X11 windowing system.
      enable = true;

      # configure keymap in X11
      layout = "de";
      xkbVariant = "neo";

      # enable SDDM display manager
      displayManager.sddm = {
        enable = true;
      };

      # enable desktop and window manager
      #desktopManager.plasma5.enable = true;
      desktopManager.gnome.enable = true;
      windowManager.bspwm.enable = true;
    };

    picom.enable = true;

    blueman.enable = true;

    # Enable CUPS to print documents
    printing.enable = true;
  };

  # Configure console keymap
  console.keyMap = "de";

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
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  # To search, run:
  #   $ nix search wget
  environment.systemPackages = with pkgs; [
    # --- terminal
    alacritty
    bat
    diff-so-fancy
    fzf
    neovim
    ripgrep
    tig
    tmate
    tmux
    tree
    xclip
    zsh

    # --- remote
    curl
    git
    wget
    magic-wormhole
    networkmanagerapplet

    # --- system
    htop
    ntfs3g

    # --- utilities
    brave
    direnv
    keepassxc
    signal-desktop

    # --- programming/scripting
    python3
    rustup
    nodejs

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
    sqlite
  ];

  hardware.bluetooth.enable = true;

  environment = {
    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
    registry.unstable.flake = flake-inputs.nixpkgs;
  };

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
