{
  perSystem = _: {
    treefmt.config = {
      projectRootFile = "flake.nix";
      settings = {
        global.excludes = [
          "*.tmTheme"
          "*.css"
          "*.md"
          "*.toml"
          ".gitignore"
          "secrets/**"
          "assets/**"
        ];
      };
      programs = {
        alejandra.enable = true;
      };
    };
  };
}
