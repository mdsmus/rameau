#!/bin/sh

sbcl="sbcl --noinform --noprint --disable-debugger --load load-makefile.lisp"

exemplos=$(ls -1 exemplos/*.ly)
exemplos_regressao=$(ls -1 regressao/*.ly)
corais=$(ls -1 literatura/bach-corais/*.ly)

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
    "")
        testa $exemplos
        exit ;;
    *) 
        testa $@
        exit ;;
esac
