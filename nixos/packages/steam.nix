{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          liberation_ttf
          wqy_zenhei
        ];
    };
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
}
