let
   pkgs = import <nixpkgs> {};
   pypkgs = with pkgs.python38Packages; [
     transformers
     pytorchWithCuda
   ];
in pkgs.stdenv.mkDerivation rec {
  name = "pyclj-app";
  buildInputs = with pkgs; [
    clojure
    clojure-lsp
    nodejs
    python3

    linuxPackages_5_8.nvidia_x11
  ] ++ pypkgs;
}
