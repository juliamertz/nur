{
  system,
  nixpkgs ? <nixpkgs>,
}:
let
  overlays = import ./overlays;
  modules = import ./modules;
  lib = import ./lib { inherit nixpkgs; };

  inherit (lib.importOverlayed system) callPackage;
  pins = callPackage ./pins.nix { };
in
{
  inherit overlays lib modules;

  bluegone = callPackage ./pkgs/bluegone { };
  nixpins = callPackage pins.sources.nixpins { };
  # firefox-addons = pkgs.callPackage ./pkgs/firefox-addons { };
}
