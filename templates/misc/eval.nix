# run with `nix eval --impure --file expr.nix`
let
  inherit (import <nixpkgs> { })
    pkgs
    lib
    ;
in
{ msg = "debugging is really easy now"; } |> builtins.toJSON
