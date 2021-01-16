let
   pkgs = import <nixpkgs> {};
   pytorch-cuda = pkgs.python38Packages.pytorch.overrideAttrs ( old: rec {
     cudaSupport = true;
   });
   pypkgs = with pkgs.python38Packages; [
     transformers
   ];
in pkgs.stdenv.mkDerivation rec {
  name = "pyclj-app";
  buildInputs = with pkgs; [
    clojure
    clojure-lsp
    nodejs
    python3

    linuxPackages_5_8.nvidia_x11
  ] ++ pypkgs ++ [
    pytorch-cuda
  ] ;
}
