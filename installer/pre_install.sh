#!/bin/bash

if ! [ -x "$(command -v chimera)" ]; then
  echo 'Error: UCSF Chimera is not installed or in PATH. Visit https://www.cgl.ucsf.edu/chimera.' >&2
  exit 1
fi

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi