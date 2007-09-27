#!/bin/sh

sbcl --noinform --noprint --disable-debugger --load pop2gab.lisp $(pwd) $1

