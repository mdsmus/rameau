sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger --eval
lisp = /usr/bin/lisp -batch -quiet -eval

lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp)

.PHONY: update clean

rameau: $(lisp-files)
	${sbcl} "(progn (load \"tools/rameau.lisp\") (sb-ext:save-lisp-and-die \"rameau\" :executable t :toplevel #'main))"

cmurameau: $(lisp-files)
	${lisp} "(progn (load \"tools/rameau.lisp\") (extensions:save-lisp \"cmurameau\" :init-function #'main :batch-mode t))"

update:
	git fetch && git rebase origin/master

clean:
	rm -f rameau cmurameau
