let
  pkgs      = import <nixpkgs> {};
  stdenv    = pkgs.stdenv;
  fetchgit  = pkgs.fetchgit;
  gcc       = pkgs.gcc;
in rec {
  buildEnv = stdenv.mkDerivation rec {
    name = "build-env";
    shellHook = ''
    alias cls=clear
    '';
    buildInputs = with pkgs; [
      stdenv
      sbt
      jre8
    ];
  };
} 
