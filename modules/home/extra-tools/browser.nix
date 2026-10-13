{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    brave
    tor-browser
  ];

  programs = {
    nyxt.enable = true; # hacker browser
    firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
    };
  };
}
