{
  pkgs ? import <nixpkgs> { },
}:
{
  mkPlugin = pkgs.callPackage ./mkPlugin.nix { };
  mkPluginsScm = pkgs.callPackage ./scm.nix { };
  mkDynlibFiles = pkgs.callPackage ./mkDynlibFiles.nix { };
}
