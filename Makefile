sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger

rameau: rameau.lisp src/packages.lisp src/parser.lisp src/utils.lisp src/pardo.lisp \
		src/formato.lisp src/rameau.asd src/cifras.lisp src/musiclib.lisp src/parser-grammar.lisp \
		src/segmento.lisp
	rm -f rameau
	${sbcl} --eval "(progn (load \"rameau.lisp\") (sb-ext:save-lisp-and-die \"rameau\" :executable t :toplevel #'main))"

clean:
	-rm rameau
