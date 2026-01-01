{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.terminal;
in {
  options.johannes.terminal.enable = lib.mkEnableOption "Terminal";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      parallel
      tree
    ];

    programs = {
      bash.enable = true;
      nix-index-database.comma.enable = true;

      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };

      alacritty = {
        enable = true;
        settings = {
          font = {
            size = 8.0;
            normal = {
              family = "FiraCode Nerd Font";
              style = "Regular";
            };
          };
          window = {
            decorations = "Full";
            startup_mode = "Maximized";
            padding = {
              x = 4;
              y = 8;
            };
          };
        };
        theme = "everforest_dark";
      };

      zsh = {
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

        initContent =
          # bash
          ''
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

      readline = {
        enable = true;
        includeSystemConfig = true;
        bindings = {
          # Map up and down arrows to history forward/backward search [1].
          "^[[A" = "history-search-backward"; # press up-arrow for previous matching command
          "^[[B" = "history-search-forward"; # press down-arrow for next matching command
        };
        variables = {
          editing-mode = "vi";
          show-mode-in-prompt = true;
        };
        extraConfig =
          # readline
          ''
            # Set the cursor style to reflect the mode.
            # The Virtual Console uses different escape codes, so you should check first which term is being used:
            $if term=linux
              set vi-ins-mode-string \1\e[?0c\2
              set vi-cmd-mode-string \1\e[?8c\2
            $else
              set vi-ins-mode-string \1\e[6 q\2
              set vi-cmd-mode-string \1\e[2 q\2
            $endif

            # Switch to block cursor before executing a command.
            set keymap vi-insert
            RETURN: "\e\n"
          '';
      };

      starship = {
        # See: https://starship.rs/config/.
        enable = true;
        enableZshIntegration = true;
        settings = {
          git_status.stashed = ""; # disable stash indicator
          add_newline = false;
        };
      };

      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      fzf = {
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

      bat.enable = true;
      jq.enable = true;
      fd.enable = true;
      ripgrep.enable = true;
      tmux.enable = false; # TODO: learn and configure
    };
  };
}
# ------------------------------------------------------------------------------
# --- REFERENCES ---------------------------------------------------------------
# ------------------------------------------------------------------------------
# [1] https://unix.stackexchange.com/questions/96510/search-for-a-previous-command-with-the-same-prefix-when-i-press-up-at-a-shell-pr
