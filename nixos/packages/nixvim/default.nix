{ pkgs, ... } :
{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./autocmds.nix
  ];

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;

    extraPlugins = with pkgs; [
      vimPlugins.remember-nvim
      vimPlugins.whitespace-nvim
      vimPlugins.catppuccin-nvim
    ];

    plugins.airline = {
      enable = true;
      settings = {
        theme = "catppuccin";
        symbols_ascii = true;
        skip_empty_sections = true;
      };
    };

    extraConfigLua = ''
      require("remember").setup {
        open_folds = true,
      }

      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "mocha",
          dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.35, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = true, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = { "italic" },
          functions = { "italic", "bold" },
          keywords = { "italic" },
          strings = {},
          variables = { "italic" },
          numbers = { "bold" },
          booleans = { "italic", "bold" },
          properties = { "italic" },
          types = { "italic" },
          operators = { "bold" },
          miscs = { "italic" }, -- Uncomment to turn off hard-coded styles
        },
      color_overrides = {
        all = {
          rosewater = "#FC7971",
          flamingo = "#bd94eb", -- #e27782",
          -- pink = "#e15ea7",
          mauve = "#FE8E7A",
        },
      },
      custom_highlights = {},
      default_integrations = false,
      integrations = {
        neotree = true,
        barbar = true,
      },
    })
    vim.cmd.colorscheme "catppuccin-mocha"

    require('whitespace-nvim').setup({
      highlight = 'DiffDelete',
      ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
      ignore_terminal = true,
      return_cursor = true,
    })
    '';

    plugins.neo-tree = {
      enable = true;
      filesystem.followCurrentFile.enabled = true;
      closeIfLastWindow = true;
      enableGitStatus = true;
    };

    plugins.barbar = {
      enable = true;
      settings = {
        auto_hide = 1;
        focus_on_close = "previous";
        insert_at_start = true;
        animation = false;
        icons = {
          button = false;
          inactive.separator.left = "";
          inactive.separator.right = " ";
          pinned.separator.right = "";
          preset = "slanted";
        };
      };
      keymaps = {
        next.key = "<TAB>";
        previous.key = "<S-TAB>";
        close.key = "<S-q>";
      };
    };
  };
}
