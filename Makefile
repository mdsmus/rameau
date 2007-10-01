sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger

all: pop2gab rameau-tests

pop2gab: pop2gab.lisp
	${sbcl} --load pop2gab.lisp 

rameau-tests: rameau-tests.lisp
	rm -f rameau-tests
	${sbcl} --eval "(progn (load \"rameau-tests\") (sb-ext:save-lisp-and-die \"rameau-tests\" :executable t :toplevel #'main))"

clean:
	-rm pop2gab rameau-tests