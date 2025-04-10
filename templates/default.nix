{ lib }:
let
  templatesFromDir =
    path: suffix:
    import path
    |> lib.mapAttrsToList (
      name: value: {
        name = "${name}${if builtins.isNull suffix then "" else "-${suffix}"}";
        inherit value;
      }
    )
    |> lib.listToAttrs;

  flakeTemplates = templatesFromDir ./flake "flake";
  shellTemplates = templatesFromDir ./shell "shell";
  miscTemplates = templatesFromDir ./misc null;
in
flakeTemplates // shellTemplates // miscTemplates
