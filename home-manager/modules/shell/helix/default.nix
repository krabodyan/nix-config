{ pkgs, config, ... }: {
  home.sessionVariables = {
    EDITOR = "hx";
  };
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [ nil pyright ]; #ruff-lsp ];
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        mouse = false;
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        scrolloff = 10;
        completion-replace = true;
        preview-completion-insert = false;
        completion-timeout = 0;

        bufferline = "multiple";
        popup-border = "none";
        text-width = 100;
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
          wrap-at-text-width = true;
          wrap-indicator = "";
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
            "C-/" = "toggle_comments";
            "C-A-down" = [
              "extend_to_line_bounds"
              "delete_selection"
              "paste_after"
            ];
            "C-A-up" = [
              "extend_to_line_bounds"
              "delete_selection"
              "move_line_up"
              "paste_before"
            ];
          };
        in
        {
          normal = binds // {
            p = "paste_clipboard_before";
            y = "yank_main_selection_to_clipboard";
            tab = ":buffer-next";
            "S-q" = ":buffer-close";
            esc = [ "collapse_selection" "keep_primary_selection" ];
          };
          insert = binds;
          select = binds;
        };
    };

    languages.language-server = {
      # ruff-lsp = {
      #   command = "ruff-lsp";
      # };
      pyright.config.python.analysis = {
        typeCheckingMode = "strict";
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
        auto-format = true;
        comment-token = "#";
        language-servers = [ "pyright" ];
        formatter = {
          command = "${pkgs.black}/bin/black";
          args = [ "--line-length" "88" "--quiet" "-" ];
        };
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
