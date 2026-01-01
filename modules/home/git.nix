{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.git;
in {
  options.johannes.git.enable = lib.mkEnableOption "Git";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        sublime-merge # git merge tool
        tig
      ];

      shellAliases = {
        # --- Even shorter git aliases
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

        # --- Config aliases
        cst = "cfg status";
        ca = "cfg add";
        cy = "cfg commit";
        cn = "cfg reset";
        cps = "cfg push";
        cpl = "cfg pull";
      };
    };

    programs = {
      git = {
        enable = true;
        lfs.enable = true;
        settings = {
          user = {
            name = "Johannes Nakayama";
            email = "johannes.nakayama@rwth-aachen.de";
          };
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

      difftastic = {
        enable = true;
        git.enable = true;
      };

      gh.enable = true;
      diff-so-fancy.enable = true;
    };
  };
}
# ------------------------------------------------------------------------------
# --- REFERENCES ---------------------------------------------------------------
# ------------------------------------------------------------------------------
# [1] https://stackoverflow.com/questions/27417656/should-diff3-be-default-conflictstyle-on-git/70387424#70387424

