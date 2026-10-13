{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.music.enable = lib.mkEnableOption "Enable music tools";

  config = lib.mkIf config.features.music.enable {
    home.packages = with pkgs; [bitwig-studio];
  };
}
