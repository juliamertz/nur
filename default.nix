{
  system ? "x86_64-linux",
  nixpkgs ? <nixpkgs>,
}:
let
  overlays = import ./overlays;
  modules = import ./modules;
  lib = import ./lib { inherit nixpkgs; };

  pkgs = lib.overlayedPackages system;
  pins = pkgs.callPackage ./pins.nix { };
in
{
  inherit overlays lib modules;

  bluegone = pkgs.callPackage ./pkgs/bluegone { };
  nixpins = pkgs.callPackage ./pkgs/nixpins { };
  firefox-addons = pkgs.callPackage ./pkgs/firefox-addons { };
}
