{
  _module.args.helpers = {
    mkAssociations = { types, desktop }:
      builtins.listToAttrs (map (type: {
        name = type;
        value = desktop;
      }) types);
  };
}
