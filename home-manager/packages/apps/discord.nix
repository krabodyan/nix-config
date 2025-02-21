{ pkgs, theme, ... }: {
  home.packages = [ pkgs.vesktop ];
  xdg.configFile."vesktop/settings/quickCss.css".text = with theme; ''
    * {
      font-family: "${font}" !important;
      font-weight: bold !important;
      font-size: 15px !important;
    }
  '';
  #   :root {
  #   --base00: #${bg}; /* Black */
  #   --base01: #${bg-bright}; /* Bright Black */
  #   --base02: #${overlay0}; /* Grey */
  #   --base03: #${fg-dark}; /* Brighter Grey */
  #   --base04: #${overlay2}; /* Bright Grey */
  #   --base05: #${subtext0}; /* White */
  #   --base06: #${fg-bright}; /* Brighter White */
  #   --base07: #${fg-bright}; /* Bright White */
  #   --base08: #${red}; /* Red */
  #   --base09: #${orange}; /* Orange */
  #   --base0A: #${bryellow}; /* Yellow */
  #   --base0B: #${brgreen}; /* Green */
  #   --base0C: #${cyan}; /* Cyan */
  #   --base0D: #${blue}; /* Blue */
  #   --base0E: #${brred}; /* Purple */
  #   --base0F: #${magenta}; /* Magenta */

  #   --primary-630: var(--base00); /* Autocomplete background */
  #   --primary-660: var(--base00); /* Search input background */
  # }

  # .theme-light, .theme-dark {
  #   --search-popout-option-fade: none; /* Disable fade for search popout */
  #   --bg-overlay-2: var(--base00); /* These 2 are needed for proper threads coloring */
  #   --home-background: var(--base00);
  #   --background-primary: var(--base00);
  #   --background-secondary: var(--base01);
  #   --background-secondary-alt: var(--base01);
  #   --channeltextarea-background: var(--base01);
  #   --background-tertiary: var(--base00);
  #   --background-accent: var(--base0E);
  #   --background-floating: var(--base01);
  #   --background-modifier-hover: var(--base00);
  #   --background-modifier-selected: var(--base00);
  #   --text-normal: var(--base05);
  #   --text-secondary: var(--base03);
  #   --text-muted: var(--base04);
  #   --text-link: var(--base0C);
  #   --interactive-normal: var(--base05);
  #   --interactive-hover: var(--base05);
  #   --interactive-active: var(--base07);
  #   --interactive-muted: var(--base03);
  #   --channels-default: var(--base04);
  #   --channel-icon: var(--base04);
  #   --header-primary: var(--base06);
  #   --header-secondary: var(--base04);
  #   --scrollbar-thin-track: transparent;
  #   --scrollbar-auto-track: transparent;
  # }

}
