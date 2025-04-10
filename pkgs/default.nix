{
  inputs,
  lib,
  system,
  callPackage,
  ...
}:
let
  systems = import ../lib/systems.nix;
  pins = (callPackage ../pins.nix { }).sources;

  defaultPackage = pin: pin.packages.${system}.default;
  filterForSystem =
    system: attrs: lib.filterAttrs (_: p: lib.elem system p.meta.platforms or systems.default) attrs;
in
filterForSystem "x86_64-linux" {
  nixpins = defaultPackage pins.nixpins;
  bluegone = callPackage ./bluegone { inherit (pins) bluegone; };
  sddm-rose-pine = callPackage ./sddm-rose-pine { inherit (pins) sddm-rose-pine; };

  firefoxAddons = callPackage ./firefox-addons { };
  zshPlugins = callPackage ./zsh-plugins { };
}
