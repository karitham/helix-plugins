{ mkPlugin }: mkPlugin {
  name = "helix-file-watcher";
  description = "File watcher plugin for Helix using Steel";

  src = fetchGit {
    url = "https://github.com/mattwparas/helix-file-watcher";
    rev = "e36434634b0a862280dc832921c9aa0d62198964";
    ref = "master";
  };

  main = "helix-file-watcher.scm";
  config = "(spawn-watcher)";
}
