#!/bin/sh

rm -rf systems/*

cd systems/
find .. -maxdepth 2 ! -type l -name "*.asd" -exec ln -s {} . \;
find ../clg -maxdepth 2 ! -type l -name "*.asd" -exec ln -s {} . \;
cd ..
