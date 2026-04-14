{
  outputs = { ... }: let
    mkPlugin = args:
      if !(args ? main) then throw "mkPlugin: missing required field: main"
      else if !(args ? name) then throw "mkPlugin: missing required field: name"
      else if !(args ? src) then throw "mkPlugin: missing required field: src"
      else {
        description = args.description or "<no description provided>";
        version = args.version or "<unknown>";
        inherit (args) main name src;
        config = args.config or "";
      };
    
    mkPluginsScm = plugins:
      builtins.concatStringsSep "\n"
        (map (p: let
          req = "(require \"${p.src}/${p.main}\")";
        in
          if p.config != "" then "${req}\n${p.config}" else req
        ) plugins);

    plugins = import ./plugins {
      inherit mkPlugin;
    };
  in {
    inherit plugins;

    lib = {
      inherit mkPlugin mkPluginsScm;
    };
    
    homeManagerModules.default = { config, lib, ... }: {
      options.programs.helix.plugins = lib.mkOption {
        description = "List of plugins to load into Helix";
        type = with lib.types; listOf attrs;
        default = [];
      };

      config.home.file.".config/helix/plugins.scm".text =
        mkPluginsScm config.programs.helix.plugins;
    };
  };
}
