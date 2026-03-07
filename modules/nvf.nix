{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        options = {
          number = true;
          relativenumber = true;
          shiftwidth = 2;
          tabstop = 2;
        };

        theme = {
          enable = true;
          name = "rose-pine";
          style = "moon";
          transparent = true;
        };

        statusline.lualine.enable = true;

        telescope.enable = true;
        autocomplete.blink-cmp.enable = true;

        treesitter.enable = true;
        lsp.enable = true;

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix.enable = true;
          python.enable = true;
          bash.enable = true;
          markdown.enable = true;
        };
      };
    };
  };
}
