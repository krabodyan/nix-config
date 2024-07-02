{ pkgs, config, ... }: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [ nil python311Packages.python-lsp-server ];
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        mouse = false;
        line-number = "relative";
        cursorline = true;
        color-modes = true;

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        indent-guides = {
          render = true;
          skip-levels = 1;
        };

        true-color = true;

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        soft-wrap = {
          enable = true;
          # wrap-at-text-width = true;
          # wrap-indicator = "↩";
        };

        statusline = {
          right = [ "version-control" "spinner" ];
          center = [ "diagnostics" ];
          left = [ "mode" "file-base-name" "file-modification-indicator" "read-only-indicator" ];
          separator = " │ ";
          mode = {
            normal = "normal";
            insert = "insert";
            select = "select";
          };
        };
      };

      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        # p = "paste_clipboard_before";
        # y = "yank_main_selection_to_clipboard";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        comment-token = "#";
        formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
      }
      {
        name = "python";
        # auto-format = true;
        formatter.command = "${pkgs.python311Packages.python-lsp-server}/bin/pylsp";
      }
    ];

    themes =
      let
        mkHex = color: "#${color}";
      in
      {
        catppuccin_mocha = {
          "inherits" = "catppuccin_mocha";
          "ui.background" = { };
          "comment" = mkHex config.colors.fg-dark;
        };
      };
  };
}
