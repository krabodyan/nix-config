{ pkgs, ... }: {
  home.packages = with pkgs; [
    wlr-randr
    swaykbdd
    grim
    slurp
    wev
    xwayland
    wl-clipboard
    wl-clipboard-x11
    zathura
  ];
  xdg.mimeApps =
  let
    associations = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "image/jpeg" = "feh.desktop";
      "image/png"  = "feh.desktop";
      "image/webp" = "feh.desktop";
      "image/svg"  = "feh.desktop";
      "image/jpg"  = "feh.desktop";
    };
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
