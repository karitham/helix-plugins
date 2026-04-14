# Helix Plugin Nix Registry

A community-maintained registry of plugins for [Helix].

[Helix]: https://helix-editor.com

## Usage

Add the flake to your inputs:

```nix
inputs.helix-plugins.url = "github:icorbrey/helix-plugins";
```

### Home Manager

Import the module and enable plugins:

```nix
imports = [
  inputs.helix-plugins.homeManagerModules.default
];

programs.helix.plugins = with inputs.helix-plugins.plugins; [
  plugin1
  plugin2
  plugin3
];
```

Then add to the top of your `~/.config/helix/init.scm` (or otherwise generated):

```scheme
(require "plugins.scm")
```

Any per-plugin configuration should be done in `init.scm` after the require,
using whatever API the plugin exposes.

```nix
programs.helix.plugins = [
  (inputs.helix-plugins.plugins.plugin1 // {
    src = fetchGit {
      url = "https://github.com/user/plugin1.hx";
      rev = "abc123";
    };
  })
];
```

## Contributing

Each plugin is a `.nix` file in `plugins/`. To add a plugin, create
`plugins/your-plugin.nix`:

```nix
{ mkPlugin }: mkPlugin {
  name = "your-plugin";
  description = "What it does";

  src = fetchGit {
    url = "https://github.com/you/your-plugin";
    rev = "abc123";
    ref = "main";
  };

  main = "entrypoint.scm";
  version = "1.0.0";
}
```

### Required Fields

| Field  | Description                                   |
|--------|-----------------------------------------------|
| `name` | Plugin identifier                             |
| `src`  | `fetchGit` source, pinned to a specific `rev` |
| `main` | Entry point `.scm` file                       |

### Optional Fields

| Field         | Default                     | Description       |
|---------------|-----------------------------|-------------------|
| `description` | `<no description provided>` | Short description |
| `version`     | `<unknown>`                 | Version string    |

Follows nixpkgs conventions: one version per plugin, updated via PR.
