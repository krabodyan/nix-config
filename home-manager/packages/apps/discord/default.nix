{ pkgs, config, ... }:
let
  Vesktop = pkgs.vesktop; # pkgs.callPackage ./overlay.nix {};
in
{
  home.packages = [ Vesktop ];
  xdg.configFile."vesktop/settings/quickCss.css".text = with config.colors; ''
    * {
      font-family: "${config.font}" !important;
      font-feature-settings: 
        "ss02",
        "cv14",
        "cv18",
        "cv04",
        "cv16",
        "zero";
      font-size: 14px !important;
      font-weight: 600 !important;
    }
    :root {
      --base00: #${bg}; /* Black */
      --base01: #${bg-bright}; /* Bright Black */
      --base02: #${red}; /* Grey */
      --base03: #${fg-dark}; /* Brighter Grey */
      --base04: #${overlay1}; /* Bright Grey */
      --base05: #${fg}; /* White */
      --base06: #${fg-bright}; /* Brighter White */
      --base07: #${fg-bright}; /* Bright White */
      --base08: #${red}; /* Red */
      --base09: #${orange}; /* Orange */
      --base0A: #${yellow}; /* Yellow */
      --base0B: #${green}; /* Green */
      --base0C: #${cyan}; /* Cyan */
      --base0D: #${blue}; /* Blue */
      --base0E: #${pink}; /* Purple */
      --base0F: #${magenta}; /* Magenta */

      --primary-630: var(--base00); /* Autocomplete background */
      --primary-660: var(--base00); /* Search input background */
    }

    .theme-light, .theme-dark {
      --search-popout-option-fade: none; /* Disable fade for search popout */
      --bg-overlay-2: var(--base00); /* These 2 are needed for proper threads coloring */
      --home-background: var(--base00);
      --background-primary: var(--base00);
      --background-secondary: var(--base01);
      --background-secondary-alt: var(--base01);
      --channeltextarea-background: var(--base01);
      --background-tertiary: var(--base00);
      --background-accent: var(--base0E);
      --background-floating: var(--base01);
      --background-modifier-hover: #{{base00-hex}}4c; /* 30% of base00 */
      --background-modifier-selected: var(--base00);
      --text-normal: var(--base05);
      --text-secondary: var(--base03);
      --text-muted: var(--base04);
      --text-link: var(--base0C);
      --interactive-normal: var(--base05);
      --interactive-hover: var(--base05);
      --interactive-active: var(--base07);
      --interactive-muted: var(--base03);
      --channels-default: var(--base04);
      --channel-icon: var(--base04);
      --header-primary: var(--base06);
      --header-secondary: var(--base04);
      --scrollbar-thin-track: transparent;
      --scrollbar-auto-track: transparent;
    }
  '';
}
