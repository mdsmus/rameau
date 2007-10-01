sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger

rameau: rameau.lisp
	rm -f rameau
	${sbcl} --eval "(progn (load \"rameau.lisp\") (sb-ext:save-lisp-and-die \"rameau\" :executable t :toplevel #'main))"

clean:
	-rm rameau