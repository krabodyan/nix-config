{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns-preview"
      "--colors=line:fg:red"
      "--colors=line:style:bold"
      "--colors=path:fg:magenta"
      "--colors=path:style:bold"
      "--colors=match:fg:black"
      "--colors=match:bg:white"
      "--ignore-case"
      "--context=1"
      "--glob=!.git/*"
    ];
  };
}
