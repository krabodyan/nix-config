{
  programs.git = {
    enable = true;
    userName  = "krabodyan";
    userEmail = "krabraketa@example.com";
    extraConfig = {
      init = {defaultbranch = "main";};
      branch = {sort = "-committerdate";};
      pull = {rebase = true;};
      push = {default = "simple";};
    };
    ignores = [
      # c commons
      "__pycache__"
      "compile_commands.json"
      "vgcore.*"
      ".cache"
      "*.gc??"
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
    ];
  };
}
