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
        ];
      };

      customRC = ''
        lua << EOF
        vim.g.mapleader = " "

        vim.o.number = true
        vim.o.relativenumber = true
        vim.o.expandtab = true
        vim.o.shiftwidth = 2
        vim.o.tabstop = 2
        vim.o.smartindent = true
        vim.o.termguicolors = true
        vim.o.signcolumn = "yes"

        require("lualine").setup()
        require("gitsigns").setup()
        require("Comment").setup()
        require("which-key").setup()

        require("nvim-treesitter.configs").setup({
          highlight = { enable = true },
          indent = { enable = true },
        })

        local telescope = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", telescope.find_files)
        vim.keymap.set("n", "<leader>fg", telescope.live_grep)
        vim.keymap.set("n", "<leader>fb", telescope.buffers)
        vim.keymap.set("n", "<leader>fh", telescope.help_tags)
        EOF
      '';
    };
  };
}
