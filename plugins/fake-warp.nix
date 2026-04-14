{ mkPlugin }:
mkPlugin {
  name = "fake-warp.hx";
  description = "Triggers terminal cursor animations for block cursors";

  src = fetchGit {
    url = "https://github.com/Xerxes-2/fake-warp.hx";
    rev = "542214f6359880c70663e3e58e0d1c5fda10d328";
    ref = "master";
  };

  main = "fake-warp.scm";
  config = "(install-fake-warp!)";
}
