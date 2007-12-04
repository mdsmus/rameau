maindir = $(shell pwd)
sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger --eval
lisp = /usr/bin/lisp -batch -quiet -eval
lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp)
corais-lyi = $(wildcard literatura/bach-corais/*.lyi)
corais-png = $(notdir $(patsubst %.lyi,%.png,$(corais-lyi)))
corais-png-partitura = $(addprefix coral-,$(notdir $(patsubst %.lyi,%.png,$(corais-lyi))))
corais-ly-partitura = $(addprefix coral,$(notdir $(patsubst %.lyi,%.ly,$(corais-lyi))))
corais-ly = $(notdir $(patsubst %.lyi,%.ly,$(corais-lyi)))
corais-dir = $(maindir)/corais

lilypond = lilypond -I $(maindir)/literatura/bach-corais -I $(maindir)/lily

vpath %.lyi literatura/bach-corais
vpath %.ly $(corais-dir)
vpath %.pop $(corais-dir)
vpath %.log $(corais-dir)
vpath %.png $(corais-dir)

.PHONY: update clean all doc update corais-ly corais

default: corais-ly rameau

all-rameau: rameau cmurameau clisprameau

rameau: $(lisp-files)
	${sbcl} "(load \"tools/make-image.lisp\")"

cmurameau: $(lisp-files)
	${lisp} "(load \"tools/make-image.lisp\")" 

eclrameau: $(lisp-files)
	ecl -eval  "(load \"tools/make-image.lisp\")"

clisprameau: $(lisp-files)
	clisp -ansi -K full -x  "(load \"tools/make-image.lisp\")"

doc:
	cd docs ;\
	make pdf

update: 
	git fetch && git rebase origin/master

corais-ly: $(corais-ly)

## BUG: regera os png quando não precisa (mas não faz isso sempre)
corais: $(corais-png)

corais-partitura: $(corais-png-partitura)

## BUG: regera os lyc quando não precisa (mas não faz isso sempre)
corais-fast: $(corais-ly)
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $(corais-ly))

## BUG: gera dos os ly que tem no diretorio, inclusive coral-*.ly
corais-partitura-fast: $(corais-ly)
	./rameau partitura corais -vt
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $(corais-ly-partitura))

%.ly: %.lyi
	@if [ ! -d $(corais-dir) ]; then mkdir -p $(corais-dir); fi;
	@cat $< lily/score.lyi > $(corais-dir)/$(basename $(notdir $<)).ly
	@if [ -f $(patsubst %.lyi,%.pop,$<) ]; then cp $(patsubst %.lyi,%.pop,$<) $(corais-dir); fi

coral-%.png: %.ly 
	./rameau partitura corais -t -f $(notdir $(basename $<))
	cd $(corais-dir); \
	$(lilypond) --png coral-$(notdir $<) 2> $(corais-dir)/coral-$(notdir $(basename $<)).log

%.png: %.ly
	cd $(corais-dir); \
	$(lilypond) --png $< 2> $(corais-dir)/$(notdir $(basename $<)).log

clean:
	rm -f rameau

cleanall:
	rm -rf rameau cmurameau eclrameau clisprameau $(corais-dir)
