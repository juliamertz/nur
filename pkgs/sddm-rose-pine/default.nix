{
  sddm-rose-pine,
  libsForQt5,
}:
let
  pkg =
    {
      lib,
      qtbase,
      qtsvg,
      qtgraphicaleffects,
      qtquickcontrols2,
      wrapQtAppsHook,
      stdenvNoCC,
    }:
    stdenvNoCC.mkDerivation {
      pname = "sddm-rose-pine";
      version = "1.0.0";
      dontBuild = true;
      src = sddm-rose-pine;

      nativeBuildInputs = [ wrapQtAppsHook ];
      propagatedUserEnvPkgs = [
        qtbase
        qtsvg
        qtgraphicaleffects
        qtquickcontrols2
      ];

      installPhase = ''
        mkdir -p $out/share/sddm/themes
        cp -aR $src $out/share/sddm/themes/rose-pine
      '';

      meta = {
        homepage = "https://github.com/juliamertz/sddm-rose-pine";
        platforms = lib.platforms.linux;
      };
    };
in
libsForQt5.callPackage pkg { }
