{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra # nix language formatter
    devbox # simple tool for reproducible dev environments
    nix-output-monitor # human-readable logs for some nix commands
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      config = {}; # don't generate direnv.toml, use the existing one instead
    };

    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    nix-index-database.comma.enable = true;
  };
}
