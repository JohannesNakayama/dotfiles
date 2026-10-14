{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      clang
      cloc
      curl
      file
      glow # display Github flavoured markdown in the terminal
      gnumake
      libffi
      # litecli # TODO (bug)
      lshw # hardware lister
      ncdu # analyze storage on hard drive
      ntfs3g # FUSE-based NTFS driver with full write support
      openssl
      p7zip
      parted
      patchelf
      psmisc # set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
      pv # monitor progress
      sqlite-interactive
      # tmate # shared terminal sessions
      trash-cli
      tree-sitter
      unzip
      util-linux # set of system utilities
      wget
      xclip # access X clipboard
      xcwd # print current working directory of currently focussed window
      xdo # perform elementary actions on windows
      xkbutils
      zip

      # TODO
      # nodejs
      # python3
    ];

    file = {
      "sqliterc".source = ./extra-config/sqlite/.sqliterc;
    };
  };

  programs.btop.enable = true;
}
