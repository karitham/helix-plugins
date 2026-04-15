{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.callPackage ./lib { };
      plugins = pkgs.callPackage ./plugins { inherit (lib) mkPlugin; };
    in
    {
      inherit plugins lib;

      homeManagerModules.default =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        let
          pluginLib = pkgs.callPackage ./lib { };
          inherit (pluginLib) mkPluginsScm mkDynlibFiles;
        in
        {
          options.programs.helix.plugins = lib.mkOption {
            description = "List of plugins to load into Helix";
            type = with lib.types; listOf attrs;
            default = [ ];
          };

          config = {
            home.sessionVariables.STEEL_HOME = "$HOME/.steel";

            xdg.configFile."helix/plugins.scm".text = mkPluginsScm config.programs.helix.plugins;

            home.file = mkDynlibFiles config.programs.helix.plugins;
          };
        };
    };
}
