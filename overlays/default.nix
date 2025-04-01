{
  builders = import ./builders.nix;
  fetchers = import ./fetchers.nix;

  # packages = final: prev: {
  #   firefoxAddons = final.callPackage ./packages/firefox-addons { };
  # };
  #
  # default = self.lib.mergeOverlays (
  #   nixpkgs.lib.mapAttrsToList (_: overlay: overlay) (
  #     nixpkgs.lib.removeAttrs self.overlays [ "default" ]
  #   )
  # );
}
