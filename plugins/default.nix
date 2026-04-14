{ mkPlugin }: let
  # The list of all .nix files in this dir (other than `default.nix`)
  plugins = builtins.filter
    (file: builtins.match ".*\\.nix$" file != null && file != "default.nix")
    (builtins.attrNames (builtins.readDir ./.));

  # Make it real!
  mkPluginDef = file: {
    name = builtins.substring 0 ((builtins.stringLength file) - 4) file;
    value = import ./${file} {
      inherit mkPlugin;
    };
  };

in builtins.listToAttrs (map mkPluginDef plugins)
