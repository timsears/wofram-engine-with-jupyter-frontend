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
          
          # Clone first repository
          if [ ! -d "wolfram-js-frontend" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/JerryI/wolfram-js-frontend.git
          fi
          
          # Clone second repository
          if [ ! -d "WolframLanguageForJupyter" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/WolframResearch/WolframLanguageForJupyter.git
          fi
        '';
      in
      {
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
