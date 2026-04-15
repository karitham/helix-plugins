{ pkgs, lib }:
plugins:

let
  stdenv = pkgs.stdenv;

  /*
    Converts plugin name to dynlib name.
    e.g., "helix-file-watcher" -> "libhelix_file_watcher.so"
  */
  dynlibName =
    name:
    let
      ext = if stdenv.isDarwin then "dylib" else "so";
    in
    "lib${builtins.replaceStrings [ "-" ] [ "_" ] name}.${ext}";

  /*
    Generates home.file entries for plugins with dynlibs.
    Returns attr set like: { ".steel/native/libfoo.so" = { source = "/nix/store/..."; }; }
  */
  mkDynlibFiles = builtins.filter (p: p ? dynlib && p.dynlib != null) plugins;

  fileEntries = builtins.listToAttrs (
    map (
      p:
      let
        name = dynlibName p.name;
        target = ".steel/native/${name}";
      in
      lib.nameValuePair target { source = "${p.dynlib}/lib/${name}"; }
    ) mkDynlibFiles
  );
in
fileEntries
