{pkgs, ...}: {
  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    gnupg
    libsecret
    pinentry-curses
  ];

  programs.keepassxc.enable = true;
}
