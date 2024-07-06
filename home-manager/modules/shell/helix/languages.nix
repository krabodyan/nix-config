{ pkgs }:
{
  file_watch_support = true;

  server = {
    timeout = 360;
  };

  language-server = {
    ruff = {
      command = "${pkgs.ruff-lsp}/bin/ruff-lsp";
      settings_section = "_";
    };
    ruff.settings._.globalSettings = {
      organizeImports = true;
      fixAll = true;
      codeAction.disableRuleComment.enable = false;
      codeAction.fixViolation.enable = false;
    };
  };
  language = [
    {
      name = "nix";
      auto-format = true;
      comment-token = "#";
      formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
    }
    {
      name = "python";
      auto-format = true;
      comment-token = "#";
      language-servers = [
        "pylsp"
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
