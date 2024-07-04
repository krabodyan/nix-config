{ pkgs }: {
  file_watch_support = true;
  language-server = {
    pyright.config.python.analysis = {
      typeCheckingMode = "strict";
    };
  };
  language = [
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
}
