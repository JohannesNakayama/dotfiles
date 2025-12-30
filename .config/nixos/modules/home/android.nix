{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.android;
in {
  options.johannes.android.enable = lib.mkEnableOption "Android";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        android-studio
        android-tools
        android-udev-rules
        flutter-unwrapped
        jdk17
        usbutils
      ];

      sessionVariables = {
        CHROME_EXECUTABLE = "/run/current-system/sw/bin/brave";
      };
    };
  };
}
