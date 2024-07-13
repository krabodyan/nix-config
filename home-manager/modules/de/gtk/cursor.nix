{ pkgs, ... }:
{
  home = {
    pointerCursor = {
      package = pkgs.stdenv.mkDerivation {
        name = "GoogleDot-Catppuccin";
        version = "1.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "krabodyan";
          repo = "GoogleDot-Catppuccin";
          rev = "fc44ac10903b2a00ebd1ac928fcd51aff127732d";
          sha256 = "sha256-/Xm6/821FWFoSAsRWvElWOS1lDW9D1CLV4m43eX4icc=";
        };
        dontConfigure = true;
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/share/icons/GoogleDot-Catppuccin/
          cp -r ./* $out/share/icons/GoogleDot-Catppuccin/
        '';
      };
      name = "GoogleDot-Catppuccin";
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
