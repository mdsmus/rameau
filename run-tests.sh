#!/bin/sh

sbcl="sbcl --noinform --noprint --disable-debugger --load load-makefile.lisp"

exemplos=$(ls -1 exemplos/*.ly)
exemplos_regressao=$(ls -1 regressao/*.ly)
lily=$(ls -1 regressao-lily/*.ly)
corais=$(ls -1 literatura/bach-corais/*.ly)
kostka=$(ls -1 literatura/kostka-payne/*.ly)

function testa {
    ${sbcl} $@
}

case "$1" in
    "-h")
        echo ./run-tests.sh [-w|-r] [arquivos]
        echo "    * sem argumentos run-tests roda todos os testes em exemplos"
        echo "    * arquivos determina os arquivos para testar"
        echo "    * -w indica que os arquivos corretos não devem ser mostrados"
        echo "    * -r roda todos os testes em regressão"
        exit ;;
    "-c")
        testa regression $corais
        exit ;;
    "-w")
        testa only-wrong $exemplos
        exit ;;
    "-r")
        testa regression $exemplos_regressao
        exit ;;
    "-k")
        testa regression $kostka
        exit ;;
    "-l")
        testa regression $lily
        exit ;;
    "")
        testa $exemplos
        exit ;;
    *) 
        testa $@
        exit ;;
esac
