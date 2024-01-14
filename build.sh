#!/usr/bin/env sh
export PATH=$PATH:/c/projects/romhacking/cc65-snapshot-win32/bin
set -e

cd "$(dirname "$0")"

mkdir -p out
ca65 ./src/main.asm -o ./out/main.o -g
ld65  -C ./src/hirom.cfg -o ./out/kid-icarusnes-revb.sfc ./out/main.o -Ln labels.txt
cp ./out/kid-icarusnes-revb.sfc ./out/msu/.