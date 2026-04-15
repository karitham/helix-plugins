{ pkgs }:

{
  name,
  src,
  main,
  dynlib ? null,
  config ? null,
  description ? "<no description provided>",
  version ? "<unknown>",
}:

let
  stdenv = pkgs.stdenv;
  # Derive the dynlib output name from plugin name
  # e.g., "helix-file-watcher" -> "libhelix_file_watcher.so"
  dynlibName = "lib${builtins.replaceStrings [ "-" ] [ "_" ] name}.${if stdenv.isDarwin then "dylib" else "so"}";
in

{
  inherit
    name
    src
    main
    dynlib
    config
    description
    version
    ;

  passthru = {
    inherit
      name
      src
      main
      dynlib
      config
      description
      version
      ;
  };
}
