{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns-preview"
      # "--colors=line:style:bold"
      "--colors=line:fg:magenta"
      "--colors=match:fg:30,30,46"
      "--colors=match:bg:180,190,254"
      "--ignore-case"
      "--context=1"
    ];
  };
}
