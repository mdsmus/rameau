#!/bin/sh

funcoes=$(egrep -ho "\((defun|defmethod)[ ]+[0-9a-zA-Z><%\!\$&\*\?/-]+ " *.lisp | sed 's/(\(defun\|defmethod\) //g' | sort |uniq)
testes=$(grep lisp-unit:define-test tests/*.lisp | awk '{print $2}' | sort | uniq)

conta=$(echo "$funcoes" | wc -l)

echo "As seguintes funções [$conta] estão sem testes de unidade:"
echo 
for f in $funcoes
do
    if [ "$(echo "$testes" | grep $f)" == "" ]
    then
        echo -n "$f "
    fi
done

echo
echo
echo "As seguintes funções estão sem documentação:"
echo 

sbcl --noinform --noprint --disable-debugger --eval "
(progn 
(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))
(asdf:oos 'asdf:load-op 'rameau)
(in-package :rameau)
(defparameter funcoes '($funcoes))
(format t \"~{~(~a ~)~}\" (loop for f in funcoes unless (documentation f 'function) collect f))
(quit))"

