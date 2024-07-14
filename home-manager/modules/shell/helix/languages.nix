{ pkgs }:
{
  file_watch_support = false;

  language-server = with pkgs; {
    ruff = {
      command = "${ruff-lsp}/bin/ruff-lsp";
      settings_section = "_";
    };
    ruff.settings._.globalSettings = {
      organizeImports = true;
      fixAll = true;
      codeAction.disableRuleComment.enable = false;
      codeAction.fixViolation.enable = false;
    };
    nix = {
      command = "${nil}/bin/nil";
    };
    python = {
      # command = "${pkgs.pyright}/bin/pyright-langserver";
      # args = [ "--stdio" ];
      command = "${python312Packages.python-lsp-server}/bin/pylsp";
    };
  };
  language = [
    {
      name = "nix";
      auto-format = true;
      comment-token = "#";
      language-servers = [ "nix" ];
      formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
    }
    {
      name = "python";
      auto-format = true;
      comment-token = "#";
      language-servers = [
        "python"
        "ruff"
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
