{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.core;
in {
  options.johannes.core.enable = lib.mkEnableOption "Core features";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      alejandra # nix language formatter
      clang
      curl
      file
      gnumake
      lshw # hardware lister
      ncdu # analyze storage on hard drive
      nix-output-monitor # human-readable logs for some nix commands
      ntfs3g # FUSE-based NTFS driver with full write support
      openssl
      p7zip
      parted
      patchelf
      psmisc # set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
      pv # monitor progress
      trash-cli
      unzip
      util-linux # set of system utilities
      wget
      xclip # access X clipboard
      xcwd # print current working directory of currently focussed window
      xdo # perform elementary actions on windows
      xkbutils
      zip
    ];

    programs = {
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        plugins = with pkgs.vimPlugins; [nvim-treesitter.withAllGrammars];

        # This config essentially replaces the previous `init.lua` in `~/.config/nvim` (symlinked by home manager).
        extraLuaConfig =
          # lua
          ''
            require("core.options")
            require("config.lazy")

            require("lazy").setup({
              spec = {
                { import = "plugins" },
                {
                  "nvim-treesitter",
                  dir = "${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}", -- use nvim-treesitter installed by nix
                  lazy = false,
                  priority = 1000,
                  config = function()
                    require("nvim-treesitter.configs").setup({
                      highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                      },
                      indent = { enable = true },

                      -- Since treesitter grammars are installed with nix, don't auto-install anything!
                      auto_install = false,
                      ensure_installed = {},
                    })
                  end,
                },
              },

              -- This is very important to not interfere with plugins that were installed with nix!
              performance = {
                reset_packpath = false, -- don't reset packpath
                rtp = { reset = false }, -- don't reset runtimepath
              },

              -- Write lazy lockfile to ~/.local/share/nvim/lazy-lock.json.
              -- This is necessary because home manager owns the ~/.config/nvim directory.
              lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
            })

            require("config.lsp")
            require("core.keymaps")
            vim.cmd [[ colorscheme everforest ]]
          '';
      };

      btop.enable = true;
    };
  };
}
