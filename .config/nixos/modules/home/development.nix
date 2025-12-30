{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.development;
in {
  options.johannes.development.enable = lib.mkEnableOption "Development tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cloc
      devbox
      flyctl
      libffi
      litecli
      nodejs_20
      python3
      sqlite-interactive
      tmate # shared terminal sessions
      tree-sitter

      # AI editors.
      # code-cursor
      # windsurf

      # Scala development.
      # coursier
      # scalafmt
      # visualvm # view information about Java applications
    ];

    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
        config = {}; # don't generate direnv.toml, use the existing one instead
      };

      vscode.enable = false;
      opencode.enable = true; # coding agent
    };
  };
}
