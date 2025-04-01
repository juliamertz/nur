{
  system ? "x86_64-linux",
  nixpkgs ? <nixpkgs>,
}:
let
  overlays = import ./overlays;
  modules = import ./modules;
  lib = import ./lib { inherit nixpkgs; };

  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      (import ./overlays/builders.nix)
      (import ./overlays/fetchers.nix)
    ];
  };

  pins = pkgs.callPackage ./pins.nix { };
  nurPkgs = pkgs.callPackage ./pkgs { inherit pins; };
in
{
  inherit overlays lib modules;
}
// nurPkgs
