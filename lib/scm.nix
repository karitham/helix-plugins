_: plugins:
builtins.concatStringsSep "\n" (
  map (
    p:
    let
      req = "(require \"${p.src}/${p.main}\")";
    in
    if p.config != "" then "${req}\n${p.config}" else req
  ) plugins
)
