{ pkgs, config, ... }: {
  home.packages = [
    (import ./volume.nix { inherit pkgs; })
    (import ./touchpad.nix { inherit pkgs; })
    (import ./microphone.nix { inherit pkgs; })
    (import ./brightness.nix { inherit pkgs; })
    (import ./screenshot.nix {
      inherit pkgs;
      colors = config.colors;
    })
  ];
}
