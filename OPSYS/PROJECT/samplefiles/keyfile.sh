#!/bin/bash

gnome-terminal --working-directory="$(dirname "$(readlink -f "$0")")" -- ./recv
./sender keyfile.txt
