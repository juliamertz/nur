final: prev: {

  # build derivation from xpi firefox addon archive
  # origin: https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/default.nix
  buildFirefoxXpiAddon =
    {
      pname,
      meta,
      version,
      addonId,
      url,
      sha256,
      ...
    }:
    with prev;
    stdenv.mkDerivation {
      name = "${pname}-${version}";
      src = prev.fetchurl { inherit url sha256; };
      preferLocalBuild = true;
      allowSubstitutes = true;
      passthru = { inherit addonId; };
      inherit meta;
      buildCommand =
        # sh
        ''
          dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
          mkdir -p "$dst"
          install -v -m644 "$src" "$dst/${addonId}.xpi"
        '';
    };

  wrapPackage =
    {
      package,
      # override derivation name
      name ? null,
      # runtime dependencies to add to PATH
      dependencies ? [ ],
      extraFlags ? [ ],
      appendFlags ? [ ],
      # extra arguments passed to makeWrapper script
      extraArgs ? [ ],
      # commands to run before wrap
      preWrap ? "",
      # commands to run after wrap
      postWrap ? "",
    }:
    let
      inherit (package.meta) mainProgram;
      join = value: if builtins.isList value then prev.lib.concatStringsSep " " value else value;
    in
    prev.symlinkJoin {
      name = if builtins.isNull name then mainProgram else name;
      paths = [ package ] ++ dependencies;
      buildInputs = [ prev.makeWrapper ];

      postBuild = ''
        ${preWrap}
        wrapProgram $out/bin/${mainProgram} \
          --add-flags "${join extraFlags}" \
          --append-flags "${join appendFlags}" \
          ${join extraArgs}
        ${postWrap}
      '';

      meta.mainProgram = mainProgram;
    };

}
