{ pkgs, mkPlugin }:

let
  plugins = builtins.filter (file: builtins.match ".*\\.nix$" file != null && file != "default.nix") (
    builtins.attrNames (builtins.readDir ./.)
  );

  mkPluginDef = file: {
    name = builtins.substring 0 ((builtins.stringLength file) - 4) file;
    value = pkgs.callPackage ./${file} { inherit mkPlugin; };
  };

in
builtins.listToAttrs (map mkPluginDef plugins)
