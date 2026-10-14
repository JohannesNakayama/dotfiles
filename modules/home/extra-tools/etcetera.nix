{pkgs, ...}: {
  home.packages = with pkgs; [
    bleachbit # clean up tool
    imagemagick
    libreoffice
    magic-wormhole
    shutter
    visualvm # view information about Java applications
    vlc
    xournalpp # pdf editing tool
    zbar
    zoom-us

    # Custom note taking tool.
    # (import ../../packages/tsh.nix {inherit pkgs;})
  ];

  programs = {
    pandoc.enable = true;
    zathura.enable = true; # display pdfs
    vscode.enable = false;
  };

  services.syncthing.enable = true;
}
