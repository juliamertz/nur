{
  callPackage,
  makeToplevel,
}:
makeToplevel "firefox-addons" (callPackage ./addons.nix { })
