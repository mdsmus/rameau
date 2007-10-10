sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger --eval
lisp = /usr/bin/lisp -batch -quiet -eval

lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp)

.PHONY: update clean

rameau: $(lisp-files)
	${sbcl} "(progn (load \"tools/rameau.lisp\") (sb-ext:save-lisp-and-die \"rameau\" :executable t :toplevel #'main))"

cmurameau: $(lisp-files)
	${lisp} "(progn (load \"tools/rameau.lisp\") (extensions:save-lisp \"cmurameau\" :init-function #'main))"

eclrameau: $(lisp-files)
	ecl -eval '(progn (compile-file "tools/rameau.lisp" :system-p t) (quit))'

clisprameau: $(lisp-files)
	clisp -ansi -K full -x "(progn (load \"tools/rameau.lisp\") (ext:saveinitmem \"clisprameau\" :script t :quiet t :executable t :init-function #'main) (quit))"

all: rameau cmurameau clisprameau

doc:
	cd docs ;\
	make pdf

update:
	git fetch && git rebase origin/master

clean:
	rm -f rameau cmurameau
