{
  lib,
  pkgs,
  config,
  inputs,
  system,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.firefox;
in {
  options = {
    module.firefox = {
      enable = mkEnableOption "firefox";
    };
  };
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      package = pkgs.firefox-esr;

      policies = import ./policies.nix;

      profiles.default = {
        id = 0;
        name = "krabodyan";
        isDefault = true;

        search = {
          force = true;
          default = "ddg";
        };

        settings = import ./options.nix;

        userChrome = builtins.readFile ./firefox.css;

        extensions = {
          force = true;

          packages = with inputs.firefox-addons.packages.${system}; [
            ublock-origin
            sponsorblock
            darkreader
            vimium-c
            screenshot-capture-annotate
            bitwarden
            nighttab
          ];
        };
      };
    };

    xdg.mimeApps.defaultApplications = mkAssociations {
      types = [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
        "application/xhtml+xml"
        "x-scheme-handler/ftp"
        "text/html"
        "application/xhtml+xml"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
      ];
      desktop = "firefox-esr.desktop";
    };
  };
}
