{
  description = "Wolfram Engine with Jupyter Frontend";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.buildEnv {
          name = "wolfram-frontends-env";
          paths = [
            pkgs.jupyter
            pkgs.libuv
          ];
        };

        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.gcc
            pkgs.jupyter
          ];
          shellHook = ''
            export LD_LIBRARY_PATH="${pkgs.gcc.lib}/lib:$LD_LIBRARY_PATH"
          '';
        };
      }
    );
}
