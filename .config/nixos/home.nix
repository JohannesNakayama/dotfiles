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
    THEME = "dark";
    PISTOL_CHROMA_STYLE = "tokyonight-night";
  };

  nix.gc.automatic = true;

  home.packages = with pkgs; [
    # --- terminal
    alacritty
    tig
    tmate
    tmux
    tree
    xclip
    chafa
    xorg.xkbutils
    ueberzugpp

    pandoc
    python311Packages.grip
    parallel

    # -- git
    gh
    diff-so-fancy
    sublime-merge

    # --- remote
    curl
    # flyctl -> probably project-level
    wget
    magic-wormhole
    networkmanagerapplet
    openssl
    syncthing

    # --- system
    ntfs3g
    parted
    bleachbit
    lshw
    ncdu

    # --- build
    gnumake
    cmake
    gcc
    glibc
    libclang
    libgcc
    patchelf

    # --- browsers
    brave
    firefox
    nyxt

    # --- desktop utils
    # libsForQt5.dolphin
    # libsForQt5.gwenview
    shutter
    thunderbird
    signal-desktop
    code-cursor
    # windsurf
    # libreoffice-still
    # xournalpp
    # openshot-qt
    # vlc

    # --- terminal utils
    cloc
    p7zip
    trash-cli
    tree-sitter
    unzip
    zip
    xcwd
    psmisc
    file
    pv
    devbox
    neomutt
    alsa-utils

    # -- IRC
    # weechat

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
    python3
    libffi
    nodejs_20

    # --- scala
    # coursier
    # visualvm
    # scalafmt

    (import ./tshPackage.nix { inherit pkgs; })

    # --- window manager
    i3lock-color
    imagemagick
    xdo

    # --- data
    litecli
    sqlite-interactive

    # --- crypto
    keepassxc
    gnupg
    pinentry-curses
    libsecret.out

    # --- kubernetes
    # kubectl
    # minicube
    # docker-compose
    # k9s
    # kubernetes-helm
  ];

  home.shellAliases = {
    # use nvim by default
    vim = "nvim";

    # v aliases for frequently modified files
    # -- see also: v in $HOME/bin
    vv = "cd $HOME/.config/nvim && v";
    vn = "cd $HOME/.config/nixos && v";
    vd = "v dot";
    vp = "v project";

    # todo tool
    tp = "todo plan";
    ts = "todo no-spawn"; # "todo select"

    # note
    n = "note";
    nn = "note new";
    ns = "note search";

    # shop
    sr = "shop recipe";
    si = "shop item";

    # ls aliases
    ls = "ls --group-directories-first --color=auto";
    l = "ls -lh";
    ll = "ls -AlhF";
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
    gsw = "git switch";
    gb = "git branch";
    gri = "git rebase -i HEAD~10";
    gps = "git push";
    gpl = "git pull";
    tig = "tig status";

    # kubernetes
    # k = k9s;

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
    ws = "wallpaper set";

    # TODO: find out why sqlite doesn't find this file by default
    sq = "sqlite3 --init ~/.config/sqlite3/sqliterc"; # little hack

    # nix
    nrs = "sudo nixos-rebuild switch";
    nfu = "nix flake update";
    nur = "nix flake update $HOME/.config/nixos && sudo nixos-rebuild switch --flake $HOME/.config/nixos";

    # trash-cli aliases (see: $HOME/bin/byebye)
    brm = "byebye remove";
    bls = "byebye list";
    bfe = "byebye forever";
    rm = "echo \"REMEMBER DECEMBER 2023, MORON?\"; false";
  };

  xsession.enable = true;
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 3;
      normal_border_color = "#282433";
      focused_border_color = "#acb0d0";
      window_gap = 0;
      split_ratio = 0.5;
      borderless_monocle = true;
      gapless_monocle = true;
      top_padding = 0;
      bottom_padding = 0;
    };
    monitors = {
      eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
    };
    # TODO: configure with home manager?
    startupPrograms = [
      "feh --bg-fill $HOME/Pictures/wallpapers/nix-snowflake.png"
      "syncthing --no-browser"
    ];
  };

  services.sxhkd = {
    enable = true;
    extraOptions = [ "-m 1" ];
    keybindings = {

      # shortcuts
      "alt + Return" = "alacritty --working-directory $(xcwd)";
      "alt + b" = "brave";
      "alt + t" = "alacritty -e todo";
      "alt + ctrl + t" = "todo spawn";
      "alt + n" = "alacritty -e note";
      "alt + ctrl + n" = "alacritty -e note new";
      "alt + d" = "rofi -show drun"; # launcher
      "alt + f" = "alacritty -e yazi"; # file manager

      # poweroff/reboot
      "ctrl + shift + super + alt + q" = "poweroff";
      "ctrl + shift + super + alt + r" = "reboot";

      # screen control
      "alt + g" = "i3lock -i ~/Pictures/wallpaper.jpg -b -f -C"; # lock screen
      "XF86MonBrightnessUp" = "xrandr --output eDP-1 --brightness 1.0"; # bright screen
      "XF86MonBrightnessDown" = "xrandr --output eDP-1 --brightness 0.5"; # dimmed screen

      # window manager general
      "ctrl + alt + {q,r}" = "bspc {quit,wm -r}"; # quit/restart bspwm
      "alt + {_,shift + }c" = "bspc node -{c,k}"; # close/kill window
      "alt + Escape" = "pkill -USR1 -x sxhkd"; # reload sxhkd config

      # window management
      "alt + mod3 + {n,t}" = "bspc desktop -f {prev,next}"; # Next/previous desktop
      "super + mod3 + {m,comma,period,n,r,t,h,g,f}" = "bspc desktop -f {1,2,3,4,5,6,7,8,9,10}"; # Navigate to specific desktop
      "alt + {_,shift + }{i,a,l,e}" = "bspc node -{f,s} {west,south,north,east}"; # Focus/shift node in given direction
      "alt + mod5 + {i,a,l,e}" = "bspc node -p {west,south,north,east}"; # Preselect direction
      "super + alt + space" = "bspc node -p cancel"; # Cancel preselection
      "alt + ctrl + {i,a,l,e}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}"; # Expand window
      "alt + shift + ctrl + {i,a,l,e}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}"; # Contract window
      "alt + shift + {n,t}" = "bspc node @/ -C {forward,backward}"; # Rotate tree [3]
      "alt + super + {n,t}" = "id=\$(bspc query --nodes --node); bspc node --to-desktop {prev,next}; bspc desktop --focus next; bspc node --focus \${id}"; # Move focused window to the next workspace and then switch to that workspace [4]

      # window state
      "alt + m" = "bspc desktop -l next"; # toggle tiled/monocle mode
      "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}"; # set the window state
      "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}"; # move a floating window

      # TODO: audio mappings
      # "alt + XF86AudioLowerVolume" = "amixer set Master 10%-";
      # "alt + XF86AudioRaiseVolume" = "amixer set Master 10%+";
      # "alt + XF86AudioMute" = "amixer set Master 0%";
    };
  };

  # inspired in part by [5]
  services.polybar = {
    enable = true;
    # config = "~/.config/polybar/config.ini";
    script = "polybar -r main &";
  };

  programs.jq.enable = true;
  programs.fd.enable = true;
  programs.btop.enable = true;

  programs.ripgrep.enable = true;

  # --- to try:
  # programs.ripgrep-all.enable = true;
  # programs.thefuck.enable = true;
  # programs.carapace.enable = true;

  programs.feh.enable = true;
  programs.zathura.enable = true;

  programs.bash.enable = true;

  programs.vscode.enable = true;

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
    initContent = ''
      # Options
      unsetopt autocd
      setopt SHARE_HISTORY # share history between sessions

      # history prefix search
      autoload -U history-search-end # have the cursor placed at the end of the line once you have selected your desired command
      bindkey '^[[A' history-beginning-search-backward
      bindkey '^[[B' history-beginning-search-forward
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

  programs.readline = {
    enable = true;
    includeSystemConfig = true;
    bindings = {
      # Map up and down arrows to history forward/backward search [2]
      # -- press up-arrow for previous matching command
      "^[[A" = "history-search-backward";
      # -- press down-arrow for next matching command
      "^[[B" = "history-search-forward";
    };
    variables = {
      editing-mode = "vi";
      show-mode-in-prompt = true;
    };
    extraConfig = ''
      # set the cursor style to reflect the mode
      # The Virtual Console uses different escape codes, so you should check
      # first which term is being used:
      $if term=linux
        set vi-ins-mode-string \1\e[?0c\2
        set vi-cmd-mode-string \1\e[?8c\2
      $else
        set vi-ins-mode-string \1\e[6 q\2
        set vi-cmd-mode-string \1\e[2 q\2
      $endif

      # switch to block cursor before executing a command
      set keymap vi-insert
      RETURN: "\e\n"
    '';
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
    plugins = with pkgs; [
      rofi-vpn
      rofi-calc
      rofi-emoji
      rofi-systemd
      rofi-bluetooth
      rofi-pulse-select
      rofi-file-browser
    ];
  };

  programs.git = {
    enable = true;
    userName = "Johannes Nakayama";
    userEmail = "johannes.nakayama@rwth-aachen.de";
    difftastic.enable = true;
    lfs.enable = true;
    extraConfig = {
      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        # might be necessary when working with Windows people:
        # autocrlf = "input";
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
        df = "diff --color-words='[A-Z][a-z]*|[a-z]+|[^[:space:]]' --irreversible-delete --find-copies-harder --find-copies --ignore-space-at-eol --ignore-space-change --ignore-all-space  --ignore-blank-lines --inter-hunk-context=2";
        dfs = "df --staged";
      };
      init = {
        defaultBranch = "main";
      };
      credential = {
        helper = "cache";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --glob '!.git'";
    defaultOptions = [
      "--border='bold'"
      "--border-label-pos='0'"
      "--preview-window='border-rounded'"
      "--padding='2'"
      "--margin='1'"
      "--prompt='> '"
      "--marker='>'"
      "--pointer='◆'"
      "--separator='─'"
      "--scrollbar='┃'"
      "--info='right'"
    ];
    colors = {
      fg = "#787c99";
      "fg+" = "#acb0d0";
      bg = "-1";
      "bg+" = "#32344a";
      hl = "#0db9d7";
      "hl+" = "#5fd7ff";
      info = "#afaf87";
      marker = "#9ece6a";
      prompt = "#ff7a93";
      spinner = "#ad8ee6";
      pointer = "#bb9af7";
      header = "#87afaf";
      border = "#444b6a";
      separator = "#acb0d0";
      label = "#aeaeae";
      query = "#d9d9d9";
    };
  };

  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "image/*";
        command = "chafa --fit-width --view-size=80x120 %pistol-filename%";
      }
    ];
  };

  programs.yazi = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.nyxt.enable = true;

  # services.redshift.enable = true;
  # services.redshift.provider = "geoclue2";

  services.unclutter = {
    # hide mouse after some seconds of no movement
    enable = true;
  };

  services.ollama.enable = true;

  services.picom.enable = true;

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
# [2] https://unix.stackexchange.com/questions/96510/search-for-a-previous-command-with-the-same-prefix-when-i-press-up-at-a-shell-pr
# [3] https://my-take-on.tech/2020/07/03/some-tricks-for-sxhkd-and-bspwm/
# [4] https://www.reddit.com/r/bspwm/comments/6jj6le/move_window_to_workspace_and_then_switch_to_that/
# [5] https://github.com/notusknot/dotfiles
