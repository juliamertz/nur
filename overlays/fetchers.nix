final: prev: {

  fetchGist =
    opts:
    prev.fetchurl {
      url = with opts; "https://gist.githubusercontent.com/${id}/raw/${rev}/${file}";
      inherit (opts) hash;
    };

  fetchFlakeFromGitHub =
    {
      owner,
      repo,
      rev,
    }:
    let
      flake = builtins.getFlake "github:${owner}/${repo}/${rev}";
    in
    flake
    // {
      devShells = flake.devShells.${prev.system};
      packages = flake.packages.${prev.system};
      checks = flake.checks.${prev.system};
      apps = flake.apps.${prev.system};
    };

}
