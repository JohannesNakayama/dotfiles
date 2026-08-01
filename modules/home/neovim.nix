{
  config,
  lib,
  ...
}: let
  cfg = config.johannes.neovim;
in {
  options.johannes.neovim.enable = lib.mkEnableOption "NeoVim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      # colorschemes.tokyonight.enable = true;
      colorschemes.everforest.enable = true;
      # colorschemes.nord.enable = true;
      # colorschemes.modus.enable = true;
      # colorschemes.nightfox.enable = true;

      globals = {
        mapleader = " ";
        maplocalleader = "_";

        loaded_netrw = 1;
        loaded_netrwPlugin = 1;
        minipairs_disable = true;
      };

      opts = {
        wrap = true;
        linebreak = true;
        breakindent = true;
        breakindentopt = {
          shift = 2;
        };
        list = true;
        listchars = {
          tab = "·-";
          trail = "·";
        };
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;

        ignorecase = true;
        smartcase = true;
        hls = true;

        clipboard = "unnamedplus";
        gdefault = true;
        undofile = true;
        history = 10000;

        # TODO: guifont
        termguicolors = true;
        showcmd = false;
        cursorline = true;
        laststatus = 3;
        number = true;
        startofline = false;
        confirm = true;
      };

      files = {
        "after/ftplugin/cs.lua" = {
          localOpts = {
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
          };
        };
        "after/ftplugin/go.lua" = {
          localOpts = {
            tabstop = 2;
            shiftwidth = 2;
            expandtab = false;
          };
        };
        "after/ftplugin/lua.lua" = {
          localOpts = {
            tabstop = 2;
            shiftwidth = 2;
            expandtab = false;
          };
        };
        "after/ftplugin/nix.lua" = {
          localOpts = {
            tabstop = 2;
            shiftwidth = 2;
            expandtab = true;
          };
        };
        "after/ftplugin/python.lua" = {
          localOpts = {
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
          };
        };
        "after/ftplugin/rust.lua" = {
          localOpts = {
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
          };
        };
        "after/ftplugin/sql.lua" = {
          localOpts = {
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
          };
        };
      };

      keymaps = [
        {
          action = ":bnext<CR>";
          key = "l";
          mode = ["n" "v"];
          options.desc = "Next buffer";
        }
        {
          action = ":bprev<CR>";
          key = "L";
          mode = ["n" "v"];
          options.desc = "Previous buffer";
        }

        {
          action = ":update<CR>";
          key = "ö";
          mode = "n";
          options.desc = "Save buffer";
        }
        {
          action = "<ESC>:update<CR>";
          key = "ö";
          mode = "v";
          options.desc = "Save buffer";
        }
        {
          action = ":q<CR>";
          key = "ä";
          mode = "n";
          options.desc = "Quit";
        }
        {
          action = "<ESC>:q<CR>";
          key = "ä";
          mode = "v";
          options.desc = "Quit";
        }
        {
          action = ":bd<CR>";
          key = "ü";
          mode = "n";
          options.desc = "Close buffer";
        }
        {
          action = "<ESC>:bd<CR>";
          key = "ü";
          mode = "v";
          options.desc = "Close buffer";
        }
        # TODO: <leader>vv for open neovim config
        # TODO: <leader>vt for open todo

        {
          action = ">gv";
          key = ">";
          mode = "v";
          options.desc = "Indent right";
        }
        {
          action = "<gv";
          key = "<";
          mode = "v";
          options.desc = "Indent left";
        }
        {
          action = "=gv";
          key = "=";
          mode = "v";
          options.desc = "Reset indentation";
        }

        {
          action = ":nohl<CR>";
          key = "<leader>h";
          mode = "n";
          options.desc = "Switch off highlighting";
        }

        # TODO convenient yanking/pasting

        {
          action.__raw =
            # lua
            ''
              function()
                toggle_char_at_eol(",")
              end
            '';
          key = "<leader>,";
          mode = "n";
          options.desc = "Toggle , at end of line";
        }
        {
          action.__raw =
            # lua
            ''
              function()
                toggle_char_at_eol(";")
              end
            '';
          key = "<leader>;";
          mode = "n";
          options.desc = "Toggle ; at end of line";
        }

        {
          action = ":ZenMode<CR>";
          key = "<leader>z";
          mode = "n";
          options.desc = "Toggle zen mode";
        }

        {
          action = ":NvimTreeFindFileToggle<CR>";
          key = "<leader>e";
          mode = "n";
          options.desc = "Toggle file explorer";
        }
        {
          action = ":NvimTreeFocus<CR>";
          key = "<leader>tf";
          mode = "n";
          options.desc = "Focus file explorer";
        }

        {
          action.__raw =
            # lua
            ''
              function()
                require("which-key").show({ global = false })
              end
            '';
          key = "<leader>?";
          mode = "n";
          options.desc = "Buffer local keymaps (which-key)";
        }

        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>ff";
          mode = "n";
          options.desc = "Find files";
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>fg";
          mode = "n";
          options.desc = "Live grep";
        }
        {
          action = "<cmd>Telescope buffers<CR>";
          key = "<leader>fb";
          mode = "n";
          options.desc = "Find buffers";
        }
        {
          action = "<cmd>Telescope help_tags<CR>";
          key = "<leader>fh";
          mode = "n";
          options.desc = "Find help tags";
        }
        {
          action = "<cmd>Telescope oldfiles<CR>";
          key = "<leader>fo";
          mode = "n";
          options.desc = "Find recent files";
        }

        {
          action.__raw = "function() vim.diagnostic.open_float() end";
          key = "<leader>d";
          mode = "n";
          options.desc = "Line Diagnostics";
        }
        {
          action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
          key = "]d";
          mode = "n";
          options.desc = "Next Diagnostic";
        }
        {
          action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
          key = "[d";
          mode = "n";
          options.desc = "Previous Diagnostic";
        }
      ];

      extraConfigLua =
        # lua
        ''
          -- TODO: potentially move into a module
          -- Toggle a specific character at the end of the current line
          function toggle_char_at_eol(target_char)
            local line_content = vim.api.nvim_get_current_line()

            if line_content:sub(-1) == target_char then
              -- Remove the character if it's at the end
              vim.api.nvim_set_current_line(line_content:sub(1, -2))
            else
              -- Add the character at the end
              vim.api.nvim_set_current_line(line_content .. target_char)
            end
          end
        '';

      plugins = {
        bufferline = {
          enable = true;
          settings.options = {
            filetype = "NvimTree";
            text = "Files";
            highlight = "Directory";
            separator = false;
            separator_style = "slant";
            diagnostics = "nvim_lsp";
            # TODO: diagnostics indicator function
          };
        };

        colorizer.enable = true;
        visual-multi.enable = true;
        commentary.enable = true;
        lastplace.enable = true;
        indent-blankline.enable = true;
        dressing.enable = true;
        inc-rename.enable = true;

        # TODO:
        # - auto-mkdir2
        # - switch.nvim
        # - auto-swap
        # - vim-rzip
        # - vim-just
        # - splitjoin (mini-splitjoin?)
        # - easypick
        # - undotree

        luasnip.enable = true;

        cmp = {
          enable = true;
          settings = {
            autoEnableSources = true;

            snippet.expand =
              # lua
              ''
                function(args) require('luasnip').lsp_expand(args.body) end
              '';

            mapping = {
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.abort()";
              "<CR>" = "cmp.mapping.confirm({ select = false })";

              "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";

              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };

            sources = [
              {name = "nvim_lsp";}
              {name = "luasnip";}
              {name = "path";}
              {name = "buffer";}
            ];
          };
        };

        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              rust = ["rustfmt"];
              go = ["gofmt"];
              lua = ["stylua"];
              nix = ["alejandra"];
              sql = ["sleek"];
              proto = ["buf"];
            };
            formatters = {
              sleek = {
                command = "sleek";
                args = ["--uppercase" "true"];
              };
            };
            format_on_save = {
              timeout_ms = 2000;
              lsp_fallback = true;
            };
          };
        };

        lsp = {
          enable = true;
          servers = {
            gopls.enable = true;
            pyright.enable = true;
            lua_ls.enable = true;
            nil_ls.enable = true;
            rust_analyzer = {
              enable = true;
              # Install per project:
              installCargo = false;
              installRustc = false;
            };
            svelte.enable = true;
            ts_ls.enable = true;
          };
          keymaps.lspBuf = {
            "gd" = "definition";
            "gD" = "references";
            "gt" = "type_definition";
            "gi" = "implementation";
            "K" = "hover";
            "<leader>ca" = "code_action";
            "<leader>rn" = "rename";
          };
        };

        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          # folding.enable = true;
        };

        nvim-surround.enable = true;

        trouble = {
          # TODO: check if this works when lsp is setup
          enable = true;
          settings.keymaps = [
            {
              key = "<leader>xx";
              action = "<cmd>Trouble diagnostics toggle<cr>";
              mode = "n";
              desc = "Diagnostics (Trouble)";
            }
            {
              key = "<leader>cs";
              action = "<cmd>Trouble symbols toggle focus=false<cr>";
              mode = "n";
              desc = "Symbols (Trouble)";
            }
          ];
        };

        lualine = {
          enable = true;
          settings = {
            options = {
              icons_enabled = true;
              theme = "auto";
            };
            sections = {
              lualine_a = [
                "filename"
                {path = 1;}
              ];
            };
          };
        };

        nvim-tree = {
          enable = true;
          settings = {
            git = {
              enable = true;
              ignore = false;
              timeout = 500;
            };
            view = {
              side = "right";
              width = 80;
            };
          };
        };

        gitsigns = {
          enable = true;
          settings.on_attach =
            # lua
            ''
              function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                  if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                  else
                    gitsigns.nav_hunk("next")
                  end
                end, { desc = "Move to next hunk" })

                map("n", "[c", function()
                  if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                  else
                    gitsigns.nav_hunk("prev")
                  end
                end, { desc = "Move to previous hunk" })

                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

                map("v", "<leader>hs", function()
                  gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Stage hunk" })

                map("v", "<leader>hr", function()
                  gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Reset hunk" })

                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Perview hunk inline" })

                map("n", "<leader>hb", function()
                  gitsigns.blame_line({ full = true })
                end, { desc = "Show blame in floating window" })

                map("n", "<leader>hD", function()
                  gitsigns.diffthis("~")
                end, { desc = "Show diff" })

                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
                map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })
              end
            '';
        };

        telescope = {
          enable = true;
          extensions.fzf-native.enable = true;
          settings = {
            pickers = {
              find_files.find_command = ["rg" "--files" "--hidden" "--glob" "!**/.git/*"];
              live_grep.additional_args = ["--hidden" "--glob" "!**/.git/*"];
            };
          };
        };

        which-key.enable = true;

        web-devicons.enable = true;
        zen-mode.enable = true;
      };
    };
  };
}
