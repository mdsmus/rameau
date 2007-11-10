maindir = $(shell pwd)
sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger --eval
lisp = /usr/bin/lisp -batch -quiet -eval
lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp)
corais-ly = $(wildcard literatura/bach-corais/*.ly)
corais-png = $(patsubst %.ly,%.png,$(corais-ly))
corais-lyc = $(patsubst %.ly,%.lyc,$(corais-ly))
corais-dir = $(maindir)/corais

lilypond = lilypond -I $(maindir)/literatura/bach-corais -I $(maindir)/lily

vpath %.ly literatura/bach-corais
vpath %.lyc $(corais-dir)
vpath %.png $(corais-dir)

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

doc:
	cd docs ;\
	make pdf

update: 
	git fetch && git rebase origin/master
	make rameau

$(corais-dir):
	if [ ! -d $(corais-dir) ]; then mkdir -p $(corais-dir); fi; \

## BUG: regera os png toda vez que chama corais
corais: $(corais-png)

## BUG: regera os lyc toda vez que chama corais
corais-fast: $(corais-lyc)
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $(corais-lyc))

%.lyc: %.ly $(corais-dir)
	echo '\include "$(notdir $<)" \include "score.ly"' > $(corais-dir)/$(basename $(notdir $<)).lyc

%.png: %.lyc
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $<)

clean:
	rm -f rameau

cleanall:
	rm -rf rameau cmurameau eclrameau clisprameau $(corais-dir)
