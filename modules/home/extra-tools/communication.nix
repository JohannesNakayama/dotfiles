{pkgs, ...}: {
  home.packages = with pkgs; [
    signal-desktop
    slack
    # weechat # TODO
  ];

  programs = {
    neomutt.enable = false; # TODO
    thunderbird.enable = true;
  };
}
