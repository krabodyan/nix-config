{ pkgs, ... }: {
  home.packages = with pkgs; [ grim slurp wlr-randr wev xwayland wl-clipboard ];
}
