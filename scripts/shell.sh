#!/usr/bin/env bash

set -ex

if $(command -v nix-shell >/dev/null)
then
  exec nix-shell shell.nix --run "$@"
else
  eval $*
fi
