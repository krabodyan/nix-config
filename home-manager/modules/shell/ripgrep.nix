{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
      "--colors=line:fg:magenta"
      "--colors=match:fg:cyan"
      "--ignore-case"
      "--context=1"
    ];
  };
}
