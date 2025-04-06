{
  lib,
  symlinkJoin,
  callPackage,
}:
let
  addons = callPackage ./addons.nix { };
in
addons
//
# join extensions into single direcotry so CI can build them all at once
symlinkJoin {
  name = "firefox-addons";
  paths = lib.attrValues addons |> lib.filter lib.isDerivation;
}
