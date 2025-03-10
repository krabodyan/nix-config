{
  allDirs = dirName:
    builtins.filter (
      module: ((builtins.pathExists module) && ((builtins.readFileType module) == "directory"))
    ) (map (module: "${dirName}/${module}") (builtins.attrNames (builtins.readDir dirName)));

  mkAssociations = {
    types,
    desktop,
  }:
    builtins.listToAttrs (map (type: {
        name = type;
        value = desktop;
      })
      types);
}
