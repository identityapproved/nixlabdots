{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;

    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          vim-nix
          plenary-nvim
          telescope-nvim
          nvim-treesitter.withAllGrammars
          nvim-lspconfig
          lualine-nvim
          which-key-nvim
          gitsigns-nvim
          comment-nvim
          tokyonight-nvim        # NEW: colorscheme (optional; remove and the pcall below no-ops)
        ];
      };

      customRC = ''
        lua << EOF
        vim.g.mapleader = " "

        -- ── Options ────────────────────────────────────────────────
        vim.o.number = true
        vim.o.relativenumber = true
        vim.o.expandtab = true
        vim.o.shiftwidth = 2
        vim.o.tabstop = 2
        vim.o.smartindent = true
        vim.o.termguicolors = true
        vim.o.signcolumn = "yes"
        vim.o.clipboard = "unnamedplus"

        -- NEW quality-of-life
        vim.o.ignorecase = true
        vim.o.smartcase = true
        vim.o.undofile = true          -- persistent undo across sessions
        vim.o.scrolloff = 8
        vim.o.updatetime = 250         -- snappier diagnostics / gitsigns
        vim.o.timeoutlen = 400         -- which-key pops faster
        vim.o.splitright = true
        vim.o.splitbelow = true
        vim.o.cursorline = true
        vim.o.mouse = "a"              -- click/select inside nvim under tmux
        vim.o.completeopt = "menuone,noselect,fuzzy"

        -- Use OSC52 so clipboard works over SSH and inside tmux.
        vim.g.clipboard = {
          name = "OSC 52",
          copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
          },
          paste = {
            ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
            ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
          },
        }

        -- ── Colorscheme ────────────────────────────────────────────
        pcall(vim.cmd.colorscheme, "tokyonight-night")

        -- ── Plugin setup ───────────────────────────────────────────
        require("lualine").setup()
        require("gitsigns").setup()
        require("Comment").setup()
        require("which-key").setup()

        -- nvim-treesitter "main" branch: no more .configs/.setup().
        -- Grammars already come from withAllGrammars, so just start per buffer.
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            pcall(vim.treesitter.start)
            -- optional experimental indent; drop this line if it feels janky:
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })

        -- ── LSP (the missing piece) ────────────────────────────────
        -- Servers come from packages.nix: nil, pyright, bash-language-server, marksman.
        -- lspconfig ships the default configs; we just enable them.
        vim.lsp.enable({ "nil_ls", "pyright", "bashls", "marksman" })

        vim.diagnostic.config({
          virtual_text = true,
          severity_sort = true,
          float = { border = "rounded" },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local buf = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            -- Built-in autocompletion, no nvim-cmp needed (nvim 0.11+)
            if client and client:supports_method("textDocument/completion") then
              vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
            end

            local map = function(keys, fn, desc)
              vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc })
            end
            map("gd", vim.lsp.buf.definition, "Go to definition")
            map("gD", vim.lsp.buf.declaration, "Go to declaration")
            map("gi", vim.lsp.buf.implementation, "Go to implementation")
            map("gr", vim.lsp.buf.references, "References")
            map("K", vim.lsp.buf.hover, "Hover")
            map("<leader>rn", vim.lsp.buf.rename, "LSP rename")
            map("<leader>ca", vim.lsp.buf.code_action, "Code action")
            map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
          end,
        })

        -- Diagnostic navigation (0.11 jump API)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })

        -- ── Telescope ──────────────────────────────────────────────
        local telescope = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })

        -- ── Misc ───────────────────────────────────────────────────
        -- Briefly highlight yanked text
        vim.api.nvim_create_autocmd("TextYankPost", {
          callback = function() (vim.hl or vim.highlight).on_yank() end,
        })
        EOF
      '';
    };
  };
}

