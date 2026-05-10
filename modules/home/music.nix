{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.music;
in {
  options.johannes.music.enable = lib.mkEnableOption "Music";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [bitwig-studio];
    };
  };
}
