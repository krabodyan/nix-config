{pkgs, ...}: {
  home = {
    pointerCursor = {
      package = pkgs.stdenv.mkDerivation {
        name = "GoogleDot-Paradise";
        version = "1.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "krabodyan";
          repo = "GoogleDot-Paradise";
          rev = "e9f2c85b9351c68a89998020faa195c2c1ea8d6a";
          sha256 = "sha256-/ZBwgB05+GFzE7wQLx3rl74N/KDcYhh0CGrRAB66RCU=";
        };
        dontConfigure = true;
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/share/icons/GoogleDot-Paradise/
          cp -r ./* $out/share/icons/GoogleDot-Paradise/
        '';
      };
      name = "GoogleDot-Paradise";
      size = 18;
      gtk.enable = true;
      x11.enable = true;
      # x11.defaultCursor = "X_cursor";
    };
  };
}
