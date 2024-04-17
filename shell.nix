{ pkgs ? import <nixpkgs> {} }:

# add unstable
pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    zsh
    cudaPackages_12_2.cudatoolkit
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.gcc}/lib64:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
    # export SHELL=${pkgs.zsh}/bin/zsh
    export CUDA_PATH=${pkgs.cudaPackages_12_2.cudatoolkit}
    export LD_LIBRARY_PATH=${pkgs.cudaPackages_12_2.cudatoolkit}/lib64:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:$LD_LIBRARY_PATH
    source $(poetry env info --path)/bin/activate # instead of poetry shell
    poetry run python3 gpu/main.py
    # exec ${pkgs.zsh}/bin/zsh
  '';
}
