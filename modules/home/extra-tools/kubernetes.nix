{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.kubernetes = {
    enable = lib.mkEnableOption "Enable Kubernetes";
    minikube.enable = lib.mkEnableOption "Enable minicube";
  };

  config = lib.mkMerge [
    (lib.mkIf config.features.kubernetes.enable {
      home = {
        packages = with pkgs; [
          kubectl
          k9s
          kubernetes-helm
        ];

        shellAliases = {
          k = "kubectl";
          kk = "k9s";
        };
      };
    })

    (lib.mkIf config.features.kubernetes.minikube.enable {
      home.packages = with pkgs; [minikube];
    })
  ];
}
