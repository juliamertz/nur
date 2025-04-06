{
  inputs,
  lib,
  system,
  callPackage,
  ...
}:
let
  systems = import ../lib/systems.nix;

  defaultPackage = input: input.packages.${system}.default;
  filterForSystem =
    system: attrs: lib.filterAttrs (_: p: lib.elem system p.meta.platforms or systems.default) attrs;
in
filterForSystem "x86_64-linux" {
  nixpins = defaultPackage inputs.nixpins;
  bluegone = callPackage ./bluegone { inherit inputs; };
  firefox-addons = callPackage ./firefox-addons { };
  sddm-rose-pine = callPackage ./sddm-rose-pine { inherit (inputs) sddm-rose-pine; };
}
