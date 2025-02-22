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

    # support ntfs (for external drives)
    supportedFilesystems = ["ntfs"];
  };

  networking = {
    hostName = "nixos";
    enableIPv6 = true;
    networkmanager.enable = true;

    # defaultGateway6 = {
    #   address = "fe80::1"; 
    #   interface = "wlp1s0";
    # };
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  home-manager.backupFileExtension = "backup";

  # services.automatic-timezoned.enable = true;
  time.timeZone = "Europe/Berlin";

  location.provider = "geoclue2";
  services.geoclue2.enable = true;

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

    displayManager.autoLogin = {
      enable = true;
      user = "johannes";
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "neo"; # neo keyboard layout
      };
      displayManager.lightdm.enable = true;
      windowManager.bspwm.enable = true;
    };

    picom.enable = true;

    blueman.enable = true;

    # Enable CUPS to print documents
    printing.enable = true;

    # periodic SSD TRIM of mounted partitions in background
    fstrim.enable = true;
  };

  console.keyMap = "neo";

  # Enable sound with pipewire
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true; # allows certain user-level processes to run with real-time priorities, good for media editing and playing
  services.pipewire = {
    # alternative to pulseaudio with better bluetooth support
    # -- https://nixos.wiki/wiki/PipeWire
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.configPackages = [
      (
        pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
          	["bluez5.enable-sbc-xq"] = true,
          	["bluez5.enable-msbc"] = true,
          	["bluez5.enable-hw-volume"] = true,
          	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
        ''
      )
    ];

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    # set default shell to zsh
    defaultUserShell = pkgs.zsh;

    # define user account
    extraUsers = {
      johannes = {
        isNormalUser = true;
        description = "johannes";
        extraGroups = ["networkmanager" "wheel" "docker"];
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true; # enable registry

    daemon.settings = {
      data-root = "/var/lib/docker";
    };
  };


  # Optional: Setup local private registry
  virtualisation.docker.extraOptions = ''
    --insecure-registry localhost:5000
  '';

  # If you want to run a local registry container
  systemd.services.docker-registry = {
    description = "Local Docker Registry";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      ExecStart = ''${pkgs.docker}/bin/docker run \
        -p 5000:5000 \
        --restart=always \
        --name registry \
        -v /path/to/registry/storage:/var/lib/registry \
        registry:2'';
      ExecStop = "${pkgs.docker}/bin/docker stop registry";
      ExecStopPost = "${pkgs.docker}/bin/docker rm registry";
    };
    wantedBy = [ "multi-user.target" ];
  };





  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts # Arial, Verdana, ...
      # vistafonts # Consolas, ...
      google-fonts # Droid Sans, Roboto, ...
      # ubuntu_font_family
      # nerdfonts: common fonts with icons and glyphs: https://www.nerdfonts.com/
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      commit-mono # https://commitmono.com/
    ];
    fontconfig = {
      includeUserConf = false; # no user fonts.conf
      defaultFonts.monospace = ["Commit Mono" "Noto Color Emoji"];
    };
    fontDir.enable = true;
  };

  hardware.bluetooth = {
    # https://nixos.wiki/wiki/Bluetooth
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true; # bluetooth battery percentage
  };

  environment = {
    shells = with pkgs; [zsh];
    variables = {
      EDITOR = "vim";
    };
  };

  # TODO: keybinding
  programs.light.enable = true; # adjust screen brightness

  programs.ssh.startAgent = true;

  programs.zsh.enable = true;

  programs.command-not-found.enable = false;

  nix = {
    package = pkgs.nixVersions.stable;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings.experimental-features = ["nix-command" "flakes"];
    settings.auto-optimise-store = true;

    # registry entries
    registry.unstable.flake = flake-inputs.nixpkgs;

    # nix path to correspond to my flakes
    nixPath = [
      "nixpkgs=${flake-inputs.nixpkgs}"
    ];

    # nixdirenv requires this to stop nix from garbage collecting its stuff
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    daemonIOSchedPriority = 7;
    daemonCPUSchedPolicy = "idle";
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
