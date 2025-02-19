{
  description = "Clone GitHub repositories to current directory";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        cloneRepos = pkgs.writeScriptBin "clone-repos" ''
          #!${pkgs.stdenv.shell}
          
          if [ ! -d "wolfram-js-frontend" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/JerryI/wolfram-js-frontend.git
          fi
          
          if [ ! -d "WolframLanguageForJupyter" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/WolframResearch/WolframLanguageForJupyter.git
          fi
        '';

        shellish = pkgs.stdenv.mkDerivation {
          name = "wolfram-engine-frontends";
          src = ./.;
          # buildInputs = [ cloneRepos ];
          
          # Remove the buildPhase that runs clone-repos
          installPhase = ''
            mkdir -p $out
            cp -r . $out/
          '';
        };
      in
       rec {
        defaultPackage = cloneRepos;
        devShell = pkgs.mkShell {
          buildInputs = [ cloneRepos ];
          shellHook = ''
            ${cloneRepos}/bin/clone-repos
            echo "Cloned 2 repos. Installing ..."
            ./WolframLanguageForJupyter/configure-jupyter.wls add
            echo "Installation done"
          '';
        };
      });
}
