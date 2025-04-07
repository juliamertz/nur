{ buildNpmPackage, importNpmLock }:

buildNpmPackage {
  pname = "astro-site";
  version = "0.1.0";
  src = ./.;

  npmDeps = importNpmLock { npmRoot = ./.; };
  npmConfigHook = importNpmLock.npmConfigHook;
}
