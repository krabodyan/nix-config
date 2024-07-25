{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns-preview"
      "--colors=line:fg:blue"
      "--colors=line:style:bold"
      "--colors=path:fg:blue"
      "--colors=path:style:bold"
      "--colors=match:fg:65,65,102"
      "--colors=match:bg:180,190,254"
      "--ignore-case"
      "--context=1"
      "--glob=!.git/*"
    ];
  };
}
