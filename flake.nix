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
          
          if [ -d "wolfram-js-frontend" ]; then
            rm -rf wolfram-js-frontend
          fi
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/JerryI/wolfram-js-frontend.git
          
          if [ -d "WolframLanguageForJupyter" ]; then
            rm -rf WolframLanguageForJupyter
          fi
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/WolframResearch/WolframLanguageForJupyter.git
            echo "configuring jupyter kernel ..."
            ./WolframLanguageForJupyter/configure-jupyter.wls add
         
        '';
      in
        {
          defaultPackage = cloneRepos;
        }
      );
}
