{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "johannes";
  home.homeDirectory = "/home/johannes";

  home.sessionPath = [
    "$HOME/bin"
    "/usr/local/bin"
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    CHROME_EXECUTABLE = "/run/current-system/sw/bin/brave";
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    # --- terminal
    alacritty
    bat
    fzf
    ripgrep
    tig
    tmate
    tmux
    tree
    xclip

    pandoc
    python311Packages.grip
    parallel

    # -- git
    # git
    gh
    diff-so-fancy
    sublime-merge

    # --- remote
    curl
    flyctl
    wget
    magic-wormhole
    networkmanagerapplet
    openssl
    syncthing

    # --- system
    htop
    ntfs3g
    parted

    # --- build
    gnumake
    libstdcxx5
    cmake
    gcc
    glibc
    libclang
    libgcc

    # --- browsers
    brave
    firefox

    # --- desktop utils
    libsForQt5.dolphin
    libsForQt5.gwenview
    shutter
    libreoffice-still
    xournal
    openshot-qt
    thunderbird
    signal-desktop
    vscode
    libsForQt5.gwenview

    # --- terminal utils
    cloc
    p7zip
    taskwarrior
    trash-cli
    tree-sitter
    unzip
    zip
    xcwd
    psmisc
    fd
    file
    jq

    # nix utils
    nix-output-monitor
    alejandra # nix language formatter
    comma

    # --- mobile
    # android-studio
    # android-tools
    # android-udev-rules
    # flutter-unwrapped
    # jdk17
    usbutils
    util-linux

    # --- programming/scripting
    # go
    python3
    ruby_3_2
    rubyPackages_3_2.openssl
    libffi
    rustup
    nodejs_20
    prettierd
    julia-bin

    # --- window manager
    bspwm
    feh
    i3lock-color
    imagemagick
    picom
    polybarFull
    # rofi
    sxhkd
    xdo

    # --- data
    litecli
    # sqlite-interactive

    # --- crypto
    keepassxc
    gnupg
    pinentry-curses
  ];

  home.shellAliases = {
    # use nvim by default
    vim = "nvim";

    # vim aliases for frequently modified files
    # -- see also: vd in $HOME/bin
    vv = "nvim ~/.config/nvim/init.lua";
    vala = "nvim ~/.config/alacritty/alacritty.toml";
    vg = "nvim ~/.config/git/config";
    vs = "nvim ~/.config/sxhkd/sxhkdrc";
    vb = "nvim ~/.config/bspwm/bspwmrc";
    vn = "nvim ~/.config/nixos/configuration.nix";

    # ls aliases
    ls = "ls --group-directories-first --color=auto";
    l = "ls -lh";
    ll = "ls -alhF";
    la = "ls -A";
    lt = "tree -L 2";
    lt3 = "tree -L 3";

    # even shorter git aliases
    g = "git";
    ga = "git add";
    gst = "git status";
    gy = "git commit";
    gn = "git reset";
    gcl = "git clone";
    gco = "git checkout";
    gb = "git branch";
    gri = "git rebase -i HEAD~10";
    gps = "git push";
    gpl = "git pull";

    # config aliases
    cst = "cfg status";
    ca = "cfg add";
    cy = "cfg commit";
    cn = "cfg reset";
    cps = "cfg push";
    cpl = "cfg pull";

    # freqently used commands with long names
    tclip = "tmate display -p \"#{tmate_ssh}\" | xclip -selection clipboard";  # tmate session token to clipboard
    dc = "docker-compose";
    dcu = "docker-compose up";
    dcd = "docker-compose down -v";
    bt = "bluetoothctl";
    syncdash = "brave 127.0.0.1:8384 &"; # syncthing dashboard
    done = "cd ~/Documents/local-notes && nvim done.md";
    cat = "bat --paging=never";

    # fzf
    fzfp = "fzf --preview 'bat --color=always {}' --preview-window '~3'";

    # nix
    nrs = "sudo nixos-rebuild switch";
    nfu = "nix flake update";
    nur = "nix flake update $HOME/.config/nixos && sudo nixos-rebuild switch --flake $HOME/.config/nixos";

    # navigation
    p = "cd $HOME/Projects/social-protocols && cd $(ls -a | fzf)";
    c = "cd $(ls -a | fzf) && ll";

    # trash-cli aliases
    trp = "trash-put";
    trl = "trash-list";
    trr = "trash-restore";
    rm = "echo \"REMEMBER DECEMBER 2023 YOU IDIOT!\"; false";

    # python aliases
    python = "python3";
    pip = "pip3";
  };

  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    defaultKeymap = "viins"; # vi mode
    history = rec {
      size = 100000000;
      save = size;
      extended = true; # save timestamps
    };

    # old config:
    # -- https://github.com/JohannesNakayama/dotfiles/blob/2123a75323d6ece588930c823f08ee4d957f4d95/.zshrc
    initExtra = ''
      # Options
      unsetopt autocd
      setopt SHARE_HISTORY # share history between sessions

      # history prefix search
      autoload -U history-search-end # have the cursor placed at the end of the line once you have selected your desired command
      bindkey '^[[A' history-beginning-search-backward
      bindkey '^[[B' history-beginning-search-forward

      # Default fzf command (hidden files too)
      export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
    '';

    plugins = [
      {
        name = "zsh-system-clipboard";
        src = pkgs.zsh-system-clipboard;
        file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
      }
      {
        name = "zsh-print-alias";
        file = "print-alias.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "brymck";
          repo = "print-alias";
          rev = "8997efc356c829f21db271424fbc8986a7203119";
          sha256 = "sha256-6ZyRkg4eXh1JVtYRHTfxJ8ctdOLw4Ff8NsEqfpoxyfI=";
        };
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {}; # don't generate direnv.toml, use the existing one instead
  };

  programs.starship = {
    # https://starship.rs/config/
    enable = true;
    enableZshIntegration = true;
    settings = {
      git_status.stashed = ""; # disable stash indicator
      add_newline = false;
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };

  programs.rofi = {
    # application launcher, window switcher, ssh launcher
    enable = true;
    theme = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/5350da41a11814f950c3354f090b90d4674a95ce/basic/.local/share/rofi/themes/catppuccin-macchiato.rasi";
      sha256 = "0n9cixyv4ladvcfbybq5dsfyzklfh732cd8nmvjckd09pjkb62f1";
    };
    font = "Commit Mono 18";

    plugins = with pkgs; [rofi-vpn rofi-calc rofi-emoji rofi-systemd rofi-bluetooth rofi-pulse-select rofi-file-browser];
  };

  programs.git = {
    enable = true;
    userName = "Johannes Nakayama";
    userEmail = "johannes.nakayama@rwth-aachen.de";
    difftastic = {
      enable = true;
    };
    extraConfig = {
      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
      };
      interactive = {
        diffFilter = "diff-so-fancy --patch";
      };
      pull = {
        rebase = "true";
      };
      push = {
        default = "simple";
      };
      fetch = {
        prune = "true";
      };
      rebase = {
        autoStash = "true";
        autoSquash = "true";
      };
      merge = {
        ff = "only";
        ignore-space-change = "true";
        conflictStyle = "diff3"; # this allows to show 3 panes in meld [1]
      };
      diff = {
        algorithm = "histogram";
      };
      commit = {
        verbose = "true";
      };
      alias = {
        st = "status";
        co = "checkout";
        cl = "clone";
        yes = "commit";
        no = "reset";
      };
      init = {
        defaultBranch = "main";
      };
      credential = {
        helper = "cache";
      };
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

# ------------------------------------------------------------------------------
# --- REFERENCES ---------------------------------------------------------------
# ------------------------------------------------------------------------------

# [1] https://stackoverflow.com/questions/27417656/should-diff3-be-default-conflictstyle-on-git/70387424#70387424
