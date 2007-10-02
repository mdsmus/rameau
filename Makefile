sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger

lisp-files = $(wildcard src/*.lisp src/lib/*.lisp)

rameau: rameau.lisp $(lisp-files)
	${sbcl} --eval "(progn (load \"rameau.lisp\") (sb-ext:save-lisp-and-die \"rameau\" :executable t :toplevel #'main))"

clean:
	-rm rameau
