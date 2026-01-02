{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.dotfiles;
in {
  options.johannes.dotfiles.enable = lib.mkEnableOption "Dotfiles";

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/nvim" = {
        source = ../dotfiles/nvim;
        recursive = true;
      };

      ".config/polybar" = {
        source = ../dotfiles/polybar;
        recursive = true;
      };

      "sqliterc".source = ../dotfiles/.sqliterc;

      ".config/ideavim" = {
        source = ../dotfiles/ideavim;
        recursive = true;
      };

      ".config/tig" = {
        source = ../dotfiles/tig;
        recursive = true;
      };

      ".config/tmux" = {
        source = ../dotfiles/tmux;
        recursive = true;
      };

      ".tmate.conf".source = ../dotfiles/.tmate.conf;

      ".config/snownews" = {
        source = ../dotfiles/snownews;
        recursive = true;
      };
    };
  };
}
