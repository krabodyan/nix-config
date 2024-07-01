{ pkgs, fetchFromGithub, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraPackages = with pkgs; [ lua-language-server ];
  };

  xdg.configFile."nvim".source = pkgs.stdenv.mkDerivation {
    name = "NvChad";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "NvChad";
      rev = "7b73d1111cfb41f980d25c800d86d43ad802d8b8";
      hash = "sha256-P5TRjg603/7kOVNFC8nXfyciNRLsIeFvKsoRCIwFP3I=";
    };
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
      mkdir -p $out/lua/custom/
      cp -r ${./config.lua} $out/lua/custom/init.lua
    '';
  };
}
