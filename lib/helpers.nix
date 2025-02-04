{
  _module.args.helpers = {
    mkHex = color: "#${color}";
    mkAssociations = { types, desktop }:
      builtins.listToAttrs (map (type: {
        name = type;
        value = desktop;
      }) types);
  };
}
