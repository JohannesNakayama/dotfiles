{config, ...}: {
  programs.home-manager.enable = true;

  imports = [
    ./modules/home/ai.nix
    ./modules/home/android.nix
    ./modules/home/core.nix
    ./modules/home/development.nix
    ./modules/home/dotfiles.nix
    ./modules/home/file-manager.nix
    ./modules/home/git.nix
    ./modules/home/kubernetes.nix
    ./modules/home/music.nix
    ./modules/home/neovim.nix
    ./modules/home/scripts.nix
    ./modules/home/terminal.nix
    ./modules/home/utilities.nix
    ./modules/home/window-manager.nix
  ];

  johannes = {
    ai.enable = true;
    android.enable = true;
    core.enable = true;
    development.enable = true;
    dotfiles.enable = true;
    file-manager.enable = true;
    git.enable = true;
    kubernetes.enable = false;
    music.enable = true;
    neovim.enable = true;
    scripts.enable = true;
    terminal.enable = true;
    utilities.enable = true;
    window-manager.enable = true;
  };

  home = {
    username = "johannes";
    homeDirectory = "/home/johannes";

    sessionPath = [
      "$HOME/bin"
      "/usr/local/bin"
      "$HOME/.local/bin"
    ];

    # Symlink downloads and documents directories to state directory (otherwise some apps might recreate those).
    file = {
      "download".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/state/download";
      "documents".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/state/documents";
    };

    sessionVariables = {
      EDITOR = "nvim";
      THEME = "dark";
    };

    shellAliases = {
      # Open frequently modified files in neovim (see also: $HOME/bin/v).
      vd = "cd $HOME/dotfiles && v";

      # Listing things.
      ls = "ls --group-directories-first --color=auto";
      l = "ls -lh";
      ll = "ls -AlhF";
      la = "ls -A";
      lt = "tree -L 2";
      lt3 = "tree -L 3";
      lt4 = "tree -L 4";

      # Freqently used commands with long names.
      sboc = "sandboxed-opencode";
      tclip = "tmate display -p \"#{tmate_ssh}\" | xclip -selection clipboard"; # tmate session token to clipboard
      bt = "bluetoothctl";
      ws = "wallpaper set";

      # Nix.
      # nrs = "sudo nixos-rebuild switch --flake /etc/nixos";
      # nfu = "nix flake update --flake /etc/nixos";
      # nur = "nfu && nrs";
      switch = "sudo nixos-rebuild switch --flake $HOME/dotfiles";
      nixup =
        # bash
        ''
          cd $HOME/dotfiles
          sudo -v
          nix flake update --flake .
          sudo -v # build can take a long time -> validate credentials once more before running it
          nixos-rebuild build --flake . --log-format internal-json --no-link |& nom --json
          sudo nixos-rebuild switch --flake .
        '';

      # Remove files safely (see: $HOME/bin/byebye).
      brm = "byebye remove";
      bls = "byebye list";
      bfe = "byebye forever";
      rm = "echo \"REMEMBER DECEMBER 2023, MORON?\"; false";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;

    documents = "${config.home.homeDirectory}/state/documents";
    download = "${config.home.homeDirectory}/state/download";
    pictures = "${config.home.homeDirectory}/state/pictures";
    projects = "${config.home.homeDirectory}/state/projects";

    # Unnecessary xdg user directories are set to null.
    desktop = null;
    music = null;
    publicShare = null;
    templates = null;
    videos = null;
  };

  systemd.user.tmpfiles.rules = [
    "d /home/johannes/state/backups 0755 johannes users -"
    "d /home/johannes/state/music 0755 johannes users -"
    "d /home/johannes/state/notes 0755 johannes users -"
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}
