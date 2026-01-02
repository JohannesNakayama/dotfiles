{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.utilities;
in {
  options.johannes.utilities.enable = lib.mkEnableOption "Utilities";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      alsa-utils
      bleachbit # clean up tool
      brave
      brightnessctl
      glow # display Github flavoured markdown in the terminal
      gnupg
      imagemagick
      keepassxc
      # libreoffice-still
      libsecret.out
      magic-wormhole
      # neomutt
      networkmanagerapplet
      # openshot-qt
      pandoc
      pinentry-curses
      shutter
      signal-desktop
      syncthing
      thunderbird
      tor-browser
      vlc
      # weechat
      # xournalpp # pdf editing tool

      # Custom note taking tool.
      # (import ../../packages/tsh.nix {inherit pkgs;})
    ];

    programs = {
      nyxt.enable = true; # hacker browser
      firefox.enable = true;
      feh.enable = true; # display images
      zathura.enable = true; # display pdfs

      rofi = {
        # application launcher, window switcher, ssh launcher
        enable = true;
        theme = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/rofi/5350da41a11814f950c3354f090b90d4674a95ce/basic/.local/share/rofi/themes/catppuccin-macchiato.rasi";
          sha256 = "0n9cixyv4ladvcfbybq5dsfyzklfh732cd8nmvjckd09pjkb62f1";
        };
        font = "Commit Mono 18";
        plugins = with pkgs; [
          rofi-vpn
          rofi-calc
          rofi-emoji
          rofi-systemd
          rofi-bluetooth
          rofi-pulse-select
          rofi-file-browser
        ];
      };
    };

    services = {
      redshift = {
        enable = false;
        provider = "geoclue2"; # requires geoclue2 to be enabled
      };

      ollama.enable = true;
      unclutter.enable = true; # hide mouse after some seconds of no movement
    };
  };
}
