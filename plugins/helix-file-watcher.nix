{ pkgs, mkPlugin }:

let
  rustPlatform = pkgs.rustPlatform;
  src = fetchGit {
    url = "https://github.com/mattwparas/helix-file-watcher";
    rev = "e36434634b0a862280dc832921c9aa0d62198964";
    ref = "master";
  };

  dynlib = rustPlatform.buildRustPackage {
    pname = "helix-file-watcher-lib";
    version = "0.1.0";

    inherit src;

    cargoHash = pkgs.lib.fakeHash;
  };

in
mkPlugin {
  name = "helix-file-watcher";
  description = "File watcher plugin for Helix using Steel";

  main = "helix-file-watcher.scm";
  config = "(spawn-watcher)";

  inherit dynlib;
  inherit src;
}
