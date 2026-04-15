{ mkPlugin }:
mkPlugin {
  name = "scooter.hx";
  description = "Interactive find-and-replace Helix plugin";

  src = fetchGit {
    url = "https://github.com/thomasschafer/scooter.hx";
    rev = "eaf2de26eed45e1405df72d22a6400709870802a";
    ref = "main";
  };

  main = "scooter.scm";

  version = "0.1.4";
}
