{ pkgs }:
{
  file_watch_support = true;

  server = {
    timeout = 360;
  };
  language-server = with pkgs; {
    # ruff = {
    #   command = "${ruff-lsp}/bin/ruff-lsp";
    #   settings_section = "_";
    # };
    # ruff.settings._.globalSettings = {
    #   organizeImports = true;
    #   fixAll = true;
    #   codeAction.disableRuleComment.enable = false;
    #   codeAction.fixViolation.enable = false;
    # };
    nil = {
      command = "${nil}/bin/nil";
    };
    pylsp = {
      command = "${pkgs.basedpyright}/bin/basedpyright-langserver";
      args = [ "--stdio" ];
      # command = "${python312Packages.python-lsp-server}/bin/pylsp";
    };
  };
  language = [
    {
      name = "nix";
      auto-format = true;
      comment-token = "#";
      language-servers = [ "nil" ];
      formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
    }
    {
      name = "python";
      auto-format = true;
      comment-token = "#";
      language-servers = [
        "pylsp"
        # "ruff"
      ];
      formatter = {
        command = "${pkgs.black}/bin/black";
        args = [
          "--line-length"
          "88"
          "--quiet"
          "-"
        ];
      };
    }
  ];
}
