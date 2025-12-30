{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.kubernetes;
in {
  options.johannes.kubernetes.enable = lib.mkEnableOption "Kubernetes";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        kubectl
        minicube
        k9s
        kubernetes-helm
      ];

      shellAliases = {
        k = "k9s";
      };
    };
  };
}
