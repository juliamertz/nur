{ self, lib, ... }:
rec {
  default = lib.removeAttrs self.overlays [ "default" ] |> lib.attrValues |> lib.mergeOverlays;
  builders = import ./builders.nix;
  fetchers = import ./fetchers.nix;

  # packages =
  #   final: prev:
  #   let
  #     pkgs = import self.inputs.nixpkgs {
  #       inherit (self) system;
  #       overlays = [
  #         builders
  #         fetchers
  #       ];
  #     };
  #   in
  #   import ../pkgs (pkgs // { inherit (self) inputs; });
}
