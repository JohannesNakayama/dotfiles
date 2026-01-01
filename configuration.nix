# Get help:
# -- NixOS manual: run 'nixos-help'
# -- configuration.nix(5) man page
{
  config,
  pkgs,
  flake-inputs,
  ...
}: {
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

    tmp = {
      useTmpfs = false;
      cleanOnBoot = true;
    };

    supportedFilesystems = ["ntfs"]; # support ntfs (for external drives)
  };

  networking = {
    hostName = "nixos";
    enableIPv6 = true;
    networkmanager.enable = true;
    firewall.enable = true; # true by default, but let's make it explicit
  };

  hardware.bluetooth = {
    # See: https://nixos.wiki/wiki/Bluetooth.
    enable = true; # makes bluetoothctl available
    powerOnBoot = true;
    settings.General.Experimental = true; # bluetooth battery percentage
  };

  # Allow certain user-level processes to run with real-time priorities.
  # (Good for media editing and playing, useful when using pipewire.)
  security.rtkit.enable = true;

  # Uncomment if manual time zone setting is needed (need to disable services.automatic-timezoned first).
  # time.timeZone = "Europe/Berlin";

  console.keyMap = "neo"; # use neo2 layout in console

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

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts # Arial, Verdana, ...
      google-fonts # Droid Sans, Roboto, ...
      commit-mono # https://commitmono.com/

      # Nerdfonts (common fonts with icons and glyphs): https://www.nerdfonts.com/.
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];
    fontconfig = {
      includeUserConf = false; # no user fonts.conf
      defaultFonts.monospace = ["Commit Mono" "Noto Color Emoji"];
    };
    fontDir.enable = true;
  };

  location.provider = "geoclue2"; # requires services.geoclue2.enable = true

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.stable;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = ["nix-command" "flakes"]; # essential setting (flakes, the nix tool)!
      auto-optimise-store = true;
    };

    # When looking up things in the registry, look for nixpkgs downloaded in my flake-inputs first.
    registry.unstable.flake = flake-inputs.nixpkgs;

    # Nix path to correspond to my flakes.
    nixPath = ["nixpkgs=${flake-inputs.nixpkgs}"];

    # Nixdirenv requires this to stop nix from garbage collecting its stuff.
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    daemonIOSchedPriority = 7;
    daemonCPUSchedPolicy = "idle";
  };

  # Make sure zsh is available system-wide.
  environment.shells = with pkgs; [zsh]; # crucial setting (otherwise might cause problems with zsh not available)!

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh; # set default shell to zsh
    extraUsers = {
      johannes = {
        isNormalUser = true;
        description = "johannes";
        extraGroups = ["networkmanager" "wheel" "docker"];
      };
    };
  };

  services = {
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        tapping = false;
        scrollMethod = "twofinger";
        accelSpeed = "0.6";
        naturalScrolling = true; # seriously, try it for a day
      };
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "johannes";
      };
      defaultSession = "none+bspwm";
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "neo"; # neo keyboard layout
      };
      displayManager = {
        lightdm.enable = true;
        session = [
          {
            manage = "window";
            name = "bspwm";
            start = "${pkgs.xorg.xinit}/bin/xinit ~/.xsession";
          }
        ];
        sessionCommands = "${pkgs.xorg.setxkbmap}/bin/setxkbmap de neo";
      };
    };

    # Automatic timezone detection.
    automatic-timezoned.enable = true; # requires location.provider to be set and time.timeZone to not be set

    # Location detection.
    geoclue2.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Periodic SSD TRIM of mounted partitions in background.
    fstrim.enable = true;

    # Smart card support (not currently needed, but keep for potential future use).
    pcscd.enable = true;

    # Enable sound with pipewire (alternative to pulseaudio with better bluetooth support).
    pulseaudio.enable = false; # make sure pulseaudio is disabled (fights over the sound card with pipewire)
    pipewire = {
      # See: https://nixos.wiki/wiki/PipeWire.
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true; # uncomment if using Bitwig or any other sophisticated audio tool

      wireplumber.configPackages = [
        (
          pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua"
          # lua
          ''
            bluez_monitor.properties = {
              ["bluez5.enable-sbc-xq"] = true,
              ["bluez5.enable-msbc"] = true,
              ["bluez5.enable-hw-volume"] = true,
              ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
            }
          ''
        )
      ];
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  programs = {
    ssh.startAgent = true; # enabled here for seemless integration with keepassxc
    zsh.enable = true;

    i3lock = {
      enable = true; # enabled here because it interacts with the PAM
      package = pkgs.i3lock-color;
    };

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
