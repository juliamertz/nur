{
  callPackage,
  makeToplevel,
}:
let
  pins = callPackage ./pins.nix { };
in
makeToplevel "zsh-plugins" pins.sources
