{pkgs, ...}: {
  home.packages = with pkgs; [gh lazygit];
  programs.git = {
    enable = true;
    userName = "krabodyan";
    userEmail = "krabraketa@gmail.com";
    signing.format = "ssh";
    aliases = {
      cm = "commit -m";
      st = "status -sb";
      last = "diff HEAD^";
    };
    extraConfig = {
      init = {defaultbranch = "master";};
      branch = {sort = "-committerdate";};
      pull = {rebase = true;};
      rebase.autoStash = true;
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
      diff.algorithm = "histogram";
      safe = {directory = "*";};
    };
    ignores = [
      "*.bak"
      # c commons
      "__pycache__"
      "cmake-build-debug"
      "compile_commands.json"
      "vgcore.*"
      ".cache"
      "*.gc??"
      "target"
      "node_modules"
      # locked files
      "*~"
      # nix buid
      "result"
      # ide folders
      ".editorconfig"
      ".vscode"
      ".idea"
      ".vs"
      ".devenv.*"
      "venv"
    ];
  };
}
