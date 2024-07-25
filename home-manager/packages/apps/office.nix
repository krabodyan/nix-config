{ pkgs, ... }:
let
  x11Fonts = pkgs.runCommand "X11-fonts" { preferLocalBuild = true; } ''
    mkdir -p "$out"
    font_regexp='.*\.\(ttf\|ttc\|otf\|pcf\|pfa\|pfb\|bdf\)\(\.gz\)?'
    find ${toString [ pkgs.corefonts ]} -regex "$font_regexp" \
      -exec cp '{}' "$out" \;
    cd "$out"
    ${pkgs.gzip}/bin/gunzip -f *.gz
    ${pkgs.xorg.mkfontscale}/bin/mkfontscale
    ${pkgs.xorg.mkfontdir}/bin/mkfontdir
    cat $(find ${pkgs.xorg.fontalias}/ -name fonts.alias) >fonts.alias
  '';

  mkFHSEnv =
    onlyofficeUnwrapped:
    pkgs.buildFHSUserEnvBubblewrap {
      name = "onlyoffice";
      runScript = "DesktopEditors";
      extraBwrapArgs = [
        "--tmpfs /usr/share"
        "--symlink ${x11Fonts} /usr/share/fonts"
      ];

      targetPkgs = pkgs: [ onlyofficeUnwrapped ];

      extraInstallCommands = ''
        mkdir -p $out/share/applications
        test -d ${onlyofficeUnwrapped}/share/icons && ln -s ${onlyofficeUnwrapped}/share/icons $out/share
        cp ${onlyofficeUnwrapped}/share/applications/onlyoffice-desktopeditors.desktop $out/share/applications
        substituteInPlace $out/share/applications/onlyoffice-desktopeditors.desktop \
          --replace "${onlyofficeUnwrapped}/bin/DesktopEditors" "$out/bin/onlyoffice"
      '';
    };
in
{
  home.packages = [ (mkFHSEnv pkgs.onlyoffice-bin) ];
}
