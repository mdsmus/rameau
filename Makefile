sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger --eval
lisp = /usr/bin/lisp -batch -quiet -eval

lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp)

.PHONY: update clean

rameau: $(lisp-files)
	${sbcl} "(load \"tools/make-image.lisp\")"

cmurameau: $(lisp-files)
	${lisp} "(load \"tools/make-image.lisp\")" 

eclrameau: $(lisp-files)
	ecl -eval  "(load \"tools/make-image.lisp\")"

clisprameau: $(lisp-files)
	clisp -ansi -K full -x  "(load \"tools/make-image.lisp\")"

all: rameau cmurameau clisprameau

corais:
	if [ ! -d partituras ]; then mkdir partituras; fi; \
	cd partituras; \
	if [ ! -d bach-corais ]; then mkdir bach-corais; fi; \
	cd bach-corais; \
	lilypond  `ls ../../literatura/bach-corais/*.ly`


doc:
	cd docs ;\
	make pdf

update: 
	git fetch && git rebase origin/master
	make rameau

clean:
	rm -f rameau

cleanall:
	rm -rf rameau cmurameau eclrameau clisprameau
