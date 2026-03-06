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
          style = "dark";
	  transparent = true;
        };

        statusline.lualine = {
	  enable = true;
	  theme = "auto";
	};
        telescope.enable = true;
        autocomplete.blink-cmp.enable = true;
        treesitter.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;

          nix.enable = true;
          rust.enable = true;
          python.enable = true;
          ts.enable = true;
          markdown.enable = true;
          bash.enable = true;
        };
      };
    };
  };
}
