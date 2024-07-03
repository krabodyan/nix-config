{ pkgs, config, ... }: {
  home.sessionVariables = {
    EDITOR = "hx";
  };
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

        completion-timeout = 0;
        popup-border = "none";
        indent-heuristic = "tree-sitter";

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
      keys =
        let
          binds = {
            "C-x" = ":q";
            "C-s" = ":w";
            "C-c" = "normal_mode";
            "C-7" = "toggle_comments";
          };
        in
        {
          normal = binds // {
            p = "paste_clipboard_before";
            y = "yank_main_selection_to_clipboard";
            "esc" = [ "collapse_selection" "keep_primary_selection" ];
          };
          insert = binds;
          select = binds;
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
        formatter = {
          command = "${pkgs.python311Packages.python-lsp-server}/bin/pylsp";
        };
        language-servers = [ "pylsp" ];
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
