sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger

lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp)

.PHONY: update clean

rameau: $(lisp-files)
	${sbcl} --eval "(progn (load \"tools/rameau.lisp\") (sb-ext:save-lisp-and-die \"rameau\" :executable t :toplevel #'main))"

update:
	git pull && git rebase origin/master

clean:
	-rm rameau
