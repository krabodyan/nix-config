{ pkgs }:
{
  file_watch_support = false;

  language-server = with pkgs; {
    ruff = {
      command = "${ruff-lsp}/bin/ruff-lsp";
    };
    nix = {
      command = "${nil}/bin/nil";
    };
    python = {
      # command = "${pkgs.pyright}/bin/pyright-langserver";
      # args = [ "--stdio" ];
      command = "${python312Packages.python-lsp-server}/bin/pylsp";
    };
    json = {
      command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      args = [ "--stdio" ];
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
    {
      name = "json";
      auto-format = true;
      language-servers = [ "json" ];
    }
  ];
}
