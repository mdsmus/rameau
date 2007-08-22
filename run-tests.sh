#!/bin/sh

sbcl="sbcl --noinform --noprint --disable-debugger --load load-makefile.lisp"

exemplos=$(ls -1 exemplos/*.ly)

function testa {
    ${sbcl} $@
}

case "$1" in
    "-h")
        echo ./run-tests.sh [-w] [arquivos]
        echo "    * sem argumentos run-tests roda todos os testes em exemplos"
        echo "    * arquivos determina os arquivos para testar"
        echo "    * -w indica que os arquivos corretos não devem ser mostrados"
        exit ;;
    "-w")
        testa only-wrong $exemplos
        exit ;;
    "")
        testa $exemplos
        exit ;;
    *) 
        testa $@
        exit ;;
esac
