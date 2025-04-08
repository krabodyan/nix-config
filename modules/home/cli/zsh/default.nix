{
  lib,
  pkgs,
  config,
  hostname,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zsh;
in {
  options = {
    module.zsh = {
      enable = mkEnableOption "enable zsh";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zsh-completions
    ];

    programs.zsh = {
      enable = true;
      history = {
        size = 1000;
        save = 1000;
        share = false;
        saveNoDups = true;
        ignoreSpace = true;
        ignoreDups = true;
      };
      defaultKeymap = "vicmd";
      # plugins = with pkgs; [
      #   {
      #     inherit (jq-zsh-plugin) src name;
      #   }
      # ];
      shellAliases = {
        g = "git";
      };
      zsh-abbr = {
        enable = true;
        abbreviations = {
          tm = "${pkgs.tmux}/bin/tmux -L $(uuidgen)";

          # ---- DOCKER ----
          d = "docker";
          "docker s" = "docker stack";
          "docker sp" = "docker stack ps";
          "docker ss" = "docker stack services";
          "docker sd" = "docker stack deploy -c docker-compose-yml";
          "docker sv" = "docker service";
          "docker i" = "docker image";
          "docker c" = "docker container";
          "docker n" = "docker node";
          "docker nl" = "docker node ls";
          "docker np" = "docker node ps";
          "docker r" = "docker run --rm -it";

          # ---- GIT ----
          g = "git";
          gs = "git status";
          gr = "git restore";
          grs = "git restore --staged";
          ga = "git add";
          gg = "git graph -10";
          "git cm" = "git commit -m \"%\"";
          "git cma" = "git commit --all -m \"%\"";

          # ---- NIX ----
          "," = "comma -P fzf";
          ns = "nix-shell --command zsh -p";
          nr = "nix run nixpkgs#%";
          "nh os" = "nh os %boot -H ${hostname}";
          "nh home" = "nh home switch -c ${hostname}%";
        };
      };
      initContent = ''
        source ${./completion.zsh}
        source ${./binds.zsh}
        source ${./options.zsh}
      '';
      enableCompletion = true;
      autosuggestion = {
        enable = true;
        strategy = ["completion" "history"];
      };
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
