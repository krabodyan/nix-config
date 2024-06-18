{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "nixos_small";
        padding = {
          right = 5;
        };
      };
      display = {
        binaryPrefix = "si";
        color = "blue";
        separator = " ‣ ";
      };
      modules = [
        "title"
        "break"
        "wm"
        "memory"
        "cpu"
        "disk"
      ];
    };
  };
}
