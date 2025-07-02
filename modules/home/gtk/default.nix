{
  lib,
  pkgs,
  hidpi,
  config,
  inputs,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.gtk;
in {
  options = {
    module.gtk = {
      enable = mkEnableOption "gtk";
    };
  };
  config = mkIf cfg.enable {
    home.pointerCursor = {
      name = "GoogleDot-Custom";
      package = with colors.hex;
        inputs.nix-cursors.packages.${pkgs.system}.google-cursor.override {
          background_color = overlay1;
          outline_color = fg;
          accent_color = overlay1;
        };
      size =
        if hidpi
        then 24
        else 16;
      gtk.enable = true;
      sway.enable = true;
      x11 = {
        enable = true;
        defaultCursor = "X_cursor";
      };
    };
    home.packages = [pkgs.dconf];
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {color-scheme = "prefer-dark";};
        "org/gnome/desktop/wm/preferences" = {button-layout = "";};
        "org/gnome/desktop/applications/terminal" = {exec = "foot";};
      };
    };
    gtk = {
      enable = true;
      font = {
        name = "Roboto Medium";
        size = 10;
        package = pkgs.roboto;
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      theme = {
        name = "paradise";
        package = pkgs.stdenv.mkDerivation {
          name = "generated-gtk-theme-paradise";
          src = pkgs.fetchFromGitHub {
            owner = "nana-4";
            repo = "materia-theme";
            rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
            sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
          };
          buildInputs = with pkgs; let
            rendersvg = pkgs.runCommand "rendersvg" {} ''
              mkdir -p $out/bin
              ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
            '';
          in [
            sassc
            bc
            which
            rendersvg
            meson
            ninja
            nodePackages.sass
            gtk4.dev
            optipng
          ];
          phases = [
            "unpackPhase"
            "installPhase"
          ];
          installPhase = with colors; # bash

            ''
              HOME=/build
              chmod 777 -R .
              patchShebangs .
              mkdir -p $out/share/themes
              mkdir bin
              sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

              cat > /build/gtk-colors << EOF
                BTN_BG=${surface2}
                BTN_FG=${fg}
                FG=${fg}
                BG=${bg}
                HDR_BTN_BG=${surface1}
                HDR_BTN_FG=${fg}
                ACCENT_BG=${select}
                ACCENT_FG=${fg}
                HDR_FG=${fg}
                HDR_BG=${bg}
                MATERIA_SURFACE=${surface0}
                MATERIA_VIEW=${bg-bright}
                MENU_BG=${surface0}
                MENU_FG=${fg}
                SEL_BG=${select}
                SEL_FG=${bg}
                TXT_BG=${red}
                TXT_FG=${fg}
                WM_BORDER_FOCUS=${bg}
                WM_BORDER_UNFOCUS=${bg}
                UNITY_DEFAULT_LAUNCHER_STYLE=False
                NAME=paradise
                MATERIA_STYLE_COMPACT=True
              EOF

              echo "Changing colours:"
              ./change_color.sh -o paradise /build/gtk-colors -i False -t "$out/share/themes"
              chmod 555 -R .
            '';
        };
      };
      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        extraConfig =
          #ini
          ''
            gtk-xft-antialias=1
            gtk-xft-hinting=1
            gtk-xft-hintstyle="hintslight"
            gtk-xft-rgba="rgb"
            gtk-dialogs-use-header=false
          '';
      };

      gtk3 = {
        extraConfig = {
          gtk-enable-event-sounds = 0;
          gtk-enable-input-feedback-sounds = 0;
          gtk-application-prefer-dark-theme = 1;
          gtk-xft-antialias = 1;
          gtk-xft-hinting = 1;
          gtk-xft-hintstyle = "hintslight";
          gtk-xft-rgba = "rgb";
          gtk-dialogs-use-header = false;
        };
        extraCss =
          # css
          ''
            window.csd,             /* gtk4? */
            window.csd decoration { /* gtk3 */
              box-shadow: none;
            }

            headerbar.default-decoration {
              /* You may need to tweak these values depending on your GTK theme */
              margin-bottom: 50px;
              margin-top: -100px;
            }

            .titlebar,
            messagedialog.csd decoration,
            .titlebar .background,
            decoration,
            window,
            window.background
            {
              box-shadow: none;
              border-radius: 0;
            }
          '';
      };
      gtk4 = {
        extraConfig = config.gtk.gtk3.extraConfig;
        extraCss = config.gtk.gtk3.extraCss;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };
  };
}
