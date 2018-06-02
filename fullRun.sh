#!/bin/bash

# Usage: ./fullRun.sh <mode> <file>

./build.sh
./run.sh $1 $2
wat2wasm output.wat -o output.wasm
node runwasm.js output.wasm