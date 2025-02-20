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
        
        cloneRepos = pkgs.writeScriptBin "install-frontends" ''
          #!${pkgs.stdenv.shell}
          
          # if [ ! -d "wolfram-js-frontend" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/JerryI/wolfram-js-frontend.git
          # fi
          
          # if [ ! -d "WolframLanguageForJupyter" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/WolframResearch/WolframLanguageForJupyter.git
            echo "configuring jupyter kernel ..."
            ./WolframLanguageForJupyter/configure-jupyter.wls add
          # fi
        '';
      in
        {
          defaultPackage = cloneRepos;
        }
      );
}
