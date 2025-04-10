# run with `nix eval --impure --file expr.nix`
let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) lib;
in
{ msg = "debugging is really easy now"; } |> builtins.toJSON
