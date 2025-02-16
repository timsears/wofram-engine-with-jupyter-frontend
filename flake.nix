{ pkgs }: {
    packages = [
      pkgs.wolfram-engine
      pkgs.gcc
      #pkgs.python3
      pkgs.jupyter
    ];
    env = {
      LD_LIBRARY_PATH = "${pkgs.gcc.lib}/lib";
    };
  }
