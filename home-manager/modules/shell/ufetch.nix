{ pkgs, ...}:
let
  ufetch = pkgs.stdenv.mkDerivation {
    name = "ufetch";
    version = "1.0.0";
    src = pkgs.fetchFromGitLab {
      owner = "jschx";
      repo = "ufetch";
      rev = "e539253c6c7fb7b582cd2a6ec758797b0a052ea3";
      sha256 = "sha256-2MPzAIzvES3JZ55rRVNucs72xmQzDy6FwA6P9FXsr+8=";
    };
    installPhase = ''
      mkdir -p $out/bin
      cp -rv $src/ufetch-nixos "$out/bin/ufetch"
    '';
  };
in {
  home.packages = [ ufetch ];
}
