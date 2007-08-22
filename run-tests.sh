#!/bin/sh

sbcl="sbcl --noinform --noprint --disable-debugger --load"

exemplos=$(ls -1 exemplos/*.ly)

function testa {
    ${sbcl} load-makefile.lisp $@
}

if [ "$1" == "" ]
then
    testa $exemplos
else
    testa $1
fi
