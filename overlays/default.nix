{
  inputs,
  # pkgs,
  ...
}: {
  nixpkgs.overlays = [
    # (final: prev: {
    #   xdg-desktop-portal-termfilechooser = prev.xdg-desktop-portal-termfilechooser.overrideAttrs {
    #     version = "1.0.1";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "hunkyburrito";
    #       repo = "xdg-desktop-portal-termfilechooser";
    #       rev = "3e8396f9a60343957b8a6ad8e516800f4f0c0181";
    #       hash = "sha256-0AS+VT8y6lJ2C/yK1psVgXz0uYVAJzBD+L6m13ILNt8=";
    #     };
    #   };
    # })
    # inputs.nixpkgs-wayland.overlay
  ];
}
