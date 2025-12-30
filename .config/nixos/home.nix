{
  config,
  pkgs,
  ...
}: {
  programs.home-manager.enable = true;

  imports = [
    ./modules/home/android.nix
    ./modules/home/core.nix
    ./modules/home/development.nix
    ./modules/home/file-manager.nix
    ./modules/home/git.nix
    ./modules/home/kubernetes.nix
    ./modules/home/terminal.nix
    ./modules/home/utilities.nix
    ./modules/home/window-manager.nix
  ];

  johannes = {
    android.enable = false;
    core.enable = true;
    development.enable = true;
    file-manager.enable = true;
    git.enable = true;
    kubernetes.enable = false;
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

    sessionVariables = {
      EDITOR = "nvim";
      THEME = "dark";
    };

    shellAliases = {
      # Open frequently modified files in neovim (see also: $HOME/bin/v).
      vv = "cd $HOME/.config/nvim && v";
      vn = "cd $HOME/.config/nixos && v";
      vd = "v dot";

      # Todo tool.
      tp = "todo plan";
      ts = "todo no-spawn"; # "todo select"

      # Note tool.
      n = "note";
      nn = "note new";
      ns = "note search";

      # Shop tool.
      sr = "shop recipe";
      si = "shop item";

      # Listing things.
      ls = "ls --group-directories-first --color=auto";
      l = "ls -lh";
      ll = "ls -AlhF";
      la = "ls -A";
      lt = "tree -L 2";
      lt3 = "tree -L 3";

      # Freqently used commands with long names.
      tclip = "tmate display -p \"#{tmate_ssh}\" | xclip -selection clipboard"; # tmate session token to clipboard
      bt = "bluetoothctl";
      syncdash = "brave 127.0.0.1:8384 &"; # syncthing dashboard
      done = "cd ~/Documents/local-notes && nvim done.md";
      ws = "wallpaper set";

      # Nix.
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos";
      nfu = "nix flake update --flake /etc/nixos";
      nur = "nfu && nrs";
      nixup =
        # bash
        ''
          sudo -v
          nix flake update --flake /etc/nixos
          nixos-rebuild build --flake /etc/nixos --log-format internal-json --no-link |& nom --json
          sudo nixos-rebuild switch --flake /etc/nixos
        '';

      # Remove files safely (see: $HOME/bin/byebye).
      brm = "byebye remove";
      bls = "byebye list";
      bfe = "byebye forever";
      rm = "echo \"REMEMBER DECEMBER 2023, MORON?\"; false";
    };
  };

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
